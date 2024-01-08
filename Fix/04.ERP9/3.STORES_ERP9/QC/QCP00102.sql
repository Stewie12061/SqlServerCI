IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP00102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[QCP00102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- <summary>
---- Load dữ liệu chart tỉ lệ hàng NG (QCD0003)
--- <history>
---- Created by Anh Đô on 04/08/2023
---- Modified by Anh Đô on 18/08/2023: Fix lỗi load dữ liệu
---- Modified by Anh Đô on 26/08/2023: Cập nhật xử lí load dữ liệu
---- Modified by Anh Đô on 29/08/2023: Cập nhật xử lí load dữ liệu

CREATE PROC QCP00102
(
	   @DivisionID VARCHAR(50)
	 , @ListPeriod NVARCHAR(MAX) = N''
	 , @ListWeek NVARCHAR(MAX) = N''
	 , @IsMonth TINYINT = 1
	 , @ListLineID NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX),
			@sSql2 NVARCHAR(MAX),
			@sSql3 NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX) = N'1 = 1 ',
			@BeginYear VARCHAR(4) = (SELECT TOP 1 BeginYear FROM AT1101)

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + N'AND M.DivisionID = '''+ @DivisionID +''' '
	IF ISNULL(@ListLineID, '') != ''
		SET @sWhere = @sWhere + N'AND Q1.PhaseID IN (SELECT Value FROM [dbo].StringSplit('''+ @ListLineID +''', '','')) '

	CREATE TABLE #ChartLine
	(
		[CategoryID] VARCHAR(50) NULL,
		[CategoryName] NVARCHAR(100) NULL,
		[TargetPercent] DECIMAL(28, 8) NULL,
		[OKQuantity] DECIMAL(28, 8) NULL,
		[NGQuantity] DECIMAL(28, 8) NULL,
		LineID VARCHAR(50) NULL
	)

	-- Bảng tạm lưu các line nhận từ filter
	CREATE TABLE #LineTmp
	(
		LineID VARCHAR(50)
	)

	-- Insert những line được thiết lập mục tiêu và nằm trong danh sách lọc vào bảng #LineTmp
	INSERT INTO #LineTmp
	SELECT [Value] FROM [dbo].StringSplit(@ListLineID, ',')
	WHERE [Value] IN (
			SELECT PhaseID FROM QCT2080 M WITH (NOLOCK)
			LEFT JOIN QCT2081 Q1 WITH (NOLOCK) ON Q1.APKMaster = M.APK
			WHERE M.TranYear = @BeginYear AND ISNULL(Q1.PhaseID, '') != '' AND M.DeleteFlg = 0 AND Q1.DeleteFlg = 0
		)

	IF @IsMonth = 1
	BEGIN
		-- Load dữ liệu chart theo tháng

		-- Bảng tạm lưu danh sách kỳ từ filter
		CREATE TABLE #PeriodTmp (PeriodID VARCHAR(50))

		INSERT INTO #PeriodTmp
		SELECT [Value] FROM [dbo].StringSplit(@ListPeriod, ',')

		-- Insert các line và kỳ chọn từ filter vào bảng #ChartLine
		INSERT INTO #ChartLine (LineID, CategoryID)
		SELECT LineID, PeriodID FROM #LineTmp, #PeriodTmp

		-- Bảng tạm lưu query load dữ liệu mục tiêu của từng tháng
		-- Dữ liệu mục tiêu của mỗi tháng sẽ cộng từ các tuần khác nhau
		-- => Mỗi tháng sẽ có một query load dữ liệu khác nhau
		CREATE TABLE #MonthSumQuery (MonthID INT, YearID INT, Query NVARCHAR(MAX))

		-- Tạo query lấy dữ liệu mục tiêu cho từng tháng và lưu vào bảng  #MonthSumQuery
		DECLARE TargetCursor CURSOR FOR
		SELECT CategoryID, LineID FROM #ChartLine

		DECLARE @MonthID INT
			  , @YearID INT
			  , @Query NVARCHAR(MAX)
			  , @PeriodID VARCHAR(50)
			  , @LineID VARCHAR(50)
			  , @TargetQuery NVARCHAR(MAX) -- Query load dữ liệu mục tiêu
			  , @ActualQuery NVARCHAR(MAX) -- Query load dữ liệu thực tế

		OPEN TargetCursor
		FETCH NEXT FROM TargetCursor INTO @PeriodID, @LineID
		WHILE @@FETCH_STATUS = 0
		BEGIN

			SET @MonthID = CONVERT(INT, (SELECT TOP 1 [Value] FROM [dbo].StringSplit(@PeriodID, '/')))
			SET @YearID = CONVERT(INT, RIGHT(@PeriodID, 4))

			-- Tạo query sum các tuần theo tháng
			-- VD: Tháng 6/2023 gồm các tuần 11 -> 15 => @Query = ISNULL(Q1.Value11, 0) + ... + ISNULL(Q1.Value15, 0)
			SET @Query = (SELECT STUFF((SELECT CONCAT('+ ISNULL(Q1.Value', WeekName, ', 0)') FROM [dbo].RangeWeekInMonth(@MonthID, @YearID)
						FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1, 2, ''))
			
			-- Query load dữ liệu mục tiêu theo từng line
			SET @TargetQuery = N'
				DECLARE @SumTargetPercent DECIMAL(28, 8)

				SELECT 
					@SumTargetPercent = SUM('+ @Query +')
				FROM QCT2081 Q1 WITH (NOLOCK)
				LEFT JOIN QCT2080 Q2 WITH (NOLOCK) ON Q2.APK = Q1.APKMaster
				WHERE Q2.TranYear = '+ STR(@YearID) +' AND Q1.DeleteFlg = 0  AND Q2.DeleteFlg = 0 AND ISNULL(Q1.PhaseID, '''') != ''''
				AND Q1.PhaseID = '''+ @LineID +'''
				
				UPDATE #ChartLine SET TargetPercent = @SumTargetPercent WHERE CategoryID = '''+ @PeriodID +''' AND LineID = '''+ @LineID +'''
			'

			-- Query load dữ liệu thực tế theo từng line
			SET @ActualQuery = N'
				DECLARE @NGQuantity DECIMAL(28, 8) = 0
					  , @OKQuantity DECIMAL(28, 8) = 0

				SELECT 
					  @NGQuantity = SUM(ISNULL(M1.ItemReturnedQuantity, 0))
					, @OKQuantity = SUM(ISNULL(M1.ItemActual, 0))
				FROM MT2210 M WITH (NOLOCK)
				LEFT JOIN MT2211 M1 WITH (NOLOCK) ON M1.APKMaster = M.APK
				WHERE M.TranMonth = '''+ STR(@MonthID) +''' AND M.TranYear = '''+ STR(@YearID) +'''  AND M1.Ana06ID = '''+ @LineID +'''
				AND M.DeleteFlg = 0 AND M1.DeleteFlg = 0
				
				UPDATE #ChartLine SET NGQuantity = @NGQuantity, OKQuantity = @OKQuantity WHERE CategoryID = '''+ @PeriodID +''' AND LineID = '''+ @LineID +'''
			'

			EXEC(@TargetQuery)
			EXEC(@ActualQuery)

			--PRINT(@TargetQuery)
			--PRINT(@ActualQuery)

			FETCH NEXT FROM TargetCursor INTO @PeriodID, @LineID
		END

		CLOSE TargetCursor
		DEALLOCATE TargetCursor

		-- Sum các dữ liệu
		SET @sSql = N'
			DECLARE @DeclaredLines INT = 0
			      , @TotalWeeks DECIMAL
				  , @PeriodID VARCHAR(50)

			-- Lấy số lượng line được thiết lập mục tiêu và nằm trong danh sách lọc
			SELECT @DeclaredLines = COUNT(*) FROM #LineTmp
			
			-- Bảng tạm lưu số tuần của một tháng
			CREATE TABLE #MonthWeek
			(
				MonthID INT,
				YearID INT,
				TotalWeek DECIMAL
			)

			-- Tính số lượng tuần của từng tháng và lưu vào bảng #MonthWeek
			DECLARE PeriodCursor CURSOR
			FOR SELECT PeriodID FROM #PeriodTmp

			DECLARE @Month INT
				  , @Year INT

			OPEN PeriodCursor
			FETCH NEXT FROM PeriodCursor INTO @PeriodID
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @Month = CONVERT(INT, LEFT(@PeriodID, 2))
				SET @Year = CONVERT(INT, RIGHT(@PeriodID, 4))
				SET @TotalWeeks = (SELECT COUNT(*) FROM [dbo].RangeWeekInMonth(@Month, @Year))

				INSERT INTO #MonthWeek (MonthID, YearID, TotalWeek) VALUES (@Month, @Year, @TotalWeeks)

				FETCH NEXT FROM PeriodCursor INTO @PeriodID
			END

			CLOSE PeriodCursor
			DEALLOCATE PeriodCursor

			-- Công thức tính phần trăm mục tiêu (TargetPercent)
			-- Phần trăm  mục tiêu = Tổng giá trị mục tiêu của các tuần theo tháng / (Số line * Số tuần)
			SELECT
				  CategoryID
				, (SELECT TOP 1 CONCAT(Name, '' '', LEFT(CategoryID, 2)) FROM A00001 WHERE LanguageID = ''vi-VN'' AND ID = ''A00.MonthCalendar'') AS CategoryName
				, SUM(OKQuantity) AS OKQuantity
				, SUM(NGQuantity) AS NGQuantity
				, CASE WHEN (SUM(OKQuantity) + SUM(NGQuantity)) > 0 THEN CONVERT(DECIMAL(28, 8), SUM(NGQuantity)) / CONVERT(DECIMAL(28, 8), (SUM(OKQuantity) + SUM(NGQuantity))) * 100 ELSE 0 
				  END AS ActualPercent
				, CASE WHEN @DeclaredLines > 0 THEN ROUND(
						SUM(TargetPercent) 
						/ (@DeclaredLines * CONVERT(INT, (SELECT TotalWeek FROM #MonthWeek WHERE MonthID = LEFT(CategoryID, 2) AND YearID = RIGHT(CategoryID, 4))))
						, 5
					) ELSE 0 
				 END AS TargetPercent
			FROM #ChartLine WITH (NOLOCK)
			GROUP BY CategoryID
			ORDER BY CategoryID
		'

		EXEC(@sSql)
	END
	ELSE
	BEGIN
		-- Load dữ liệu chart theo tuần

		-- Bảng tạm lưu danh sách tuần từ filter
		CREATE TABLE #WeekTmp (WeekID VARCHAR(50))

		INSERT INTO #WeekTmp
		SELECT [Value] FROM [dbo].StringSplit(@ListWeek, ',')

		-- Insert tuần và line từ filter vào bảng #ChartLine
		INSERT INTO #ChartLine ([CategoryID], LineID)
		SELECT
			WeekID, LineID
		FROM #WeekTmp, #LineTmp

		-- Lấy dữ liệu mục tiêu
		SET @sSql = N'	
			UPDATE M
			SET
				M.TargetPercent = (
				CASE WHEN M.CategoryID = ''1'' THEN Q1.Value1
					 WHEN M.CategoryID = ''2'' THEN Q1.Value2
					 WHEN M.CategoryID = ''3'' THEN Q1.Value3
					 WHEN M.CategoryID = ''4'' THEN Q1.Value4
					 WHEN M.CategoryID = ''5'' THEN Q1.Value5
					 WHEN M.CategoryID = ''6'' THEN Q1.Value6
					 WHEN M.CategoryID = ''7'' THEN Q1.Value7
					 WHEN M.CategoryID = ''8'' THEN Q1.Value8
					 WHEN M.CategoryID = ''9'' THEN Q1.Value9
					 WHEN M.CategoryID = ''10'' THEN Q1.Value10
					 WHEN M.CategoryID = ''11'' THEN Q1.Value11
					 WHEN M.CategoryID = ''12'' THEN Q1.Value12
					 WHEN M.CategoryID = ''13'' THEN Q1.Value13
					 WHEN M.CategoryID = ''14'' THEN Q1.Value14
					 WHEN M.CategoryID = ''15'' THEN Q1.Value15
					 WHEN M.CategoryID = ''16'' THEN Q1.Value16
					 WHEN M.CategoryID = ''17'' THEN Q1.Value17
					 WHEN M.CategoryID = ''18'' THEN Q1.Value18
					 WHEN M.CategoryID = ''19'' THEN Q1.Value19
					 WHEN M.CategoryID = ''20'' THEN Q1.Value20
					 WHEN M.CategoryID = ''21'' THEN Q1.Value21
					 WHEN M.CategoryID = ''22'' THEN Q1.Value22
					 WHEN M.CategoryID = ''23'' THEN Q1.Value23
					 WHEN M.CategoryID = ''24'' THEN Q1.Value24
					 WHEN M.CategoryID = ''25'' THEN Q1.Value25
					 WHEN M.CategoryID = ''26'' THEN Q1.Value26
					 WHEN M.CategoryID = ''27'' THEN Q1.Value27
					 WHEN M.CategoryID = ''28'' THEN Q1.Value28
					 WHEN M.CategoryID = ''29'' THEN Q1.Value29
					 WHEN M.CategoryID = ''30'' THEN Q1.Value30
					 WHEN M.CategoryID = ''31'' THEN Q1.Value31
					 WHEN M.CategoryID = ''32'' THEN Q1.Value32
					 WHEN M.CategoryID = ''33'' THEN Q1.Value33
					 WHEN M.CategoryID = ''34'' THEN Q1.Value34
					 WHEN M.CategoryID = ''35'' THEN Q1.Value35
					 WHEN M.CategoryID = ''36'' THEN Q1.Value36
					 WHEN M.CategoryID = ''37'' THEN Q1.Value37
					 WHEN M.CategoryID = ''38'' THEN Q1.Value38
					 WHEN M.CategoryID = ''39'' THEN Q1.Value39
					 WHEN M.CategoryID = ''40'' THEN Q1.Value40
					 WHEN M.CategoryID = ''41'' THEN Q1.Value41
					 WHEN M.CategoryID = ''42'' THEN Q1.Value42
					 WHEN M.CategoryID = ''43'' THEN Q1.Value43
					 WHEN M.CategoryID = ''44'' THEN Q1.Value44
					 WHEN M.CategoryID = ''45'' THEN Q1.Value45
					 WHEN M.CategoryID = ''46'' THEN Q1.Value46
					 WHEN M.CategoryID = ''47'' THEN Q1.Value47
					 WHEN M.CategoryID = ''48'' THEN Q1.Value48
					 WHEN M.CategoryID = ''49'' THEN Q1.Value49
					 WHEN M.CategoryID = ''50'' THEN Q1.Value50
					 WHEN M.CategoryID = ''51'' THEN Q1.Value51
					 WHEN M.CategoryID = ''52'' THEN Q1.Value52 ELSE 0
				END)
			FROM #ChartLine M WITH (NOLOCK)
			LEFT JOIN QCT2081 Q1 WITH (NOLOCK) ON Q1.PhaseID = M.LineID
			LEFT JOIN QCT2080 Q2 WITH (NOLOCK) ON Q2.APK = Q1.APKMaster
			WHERE Q2.TranYear = YEAR(GETDATE()) AND Q1.DeleteFlg = 0 AND Q2.DeleteFlg = 0 AND ISNULL(Q1.PhaseID, '''') != ''''
		'

		-- Lấy dữ liệu thực tế
		SET @sSql2 = N'
			DECLARE @StartDate DATETIME,
					@BeginWeek INT,
					@NumWeek INT,
					@EndWeek12 INT

			SET @StartDate = (CAST((SELECT TOP 1 CONCAT(BeginYear, ''-'', MONTH(StartDate), ''-'', DAY(StartDate)) FROM AT1101 ORDER BY BeginYear) AS DATETIME))
			SET @BeginWeek = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, @StartDate),0))
			SET @NumWeek = @BeginWeek - 1 -- Số tuần chênh lệch
			SET @EndWeek12 = DATEPART(WW, CONCAT(YEAR(@StartDate), ''-12-31''))

			UPDATE M
			SET
				  M.OKQuantity = ISNULL(P.OKQuantity, 0)
				, M.NGQuantity = ISNULL(P.NGQuantity, 0)
			FROM #ChartLine M WITH (NOLOCK)
			LEFT JOIN (
				SELECT M2.Ana06ID
				     , SUM(ISNULL(M2.ItemActual, 0)) AS OKQuantity
					 , SUM(ISNULL(M2.ItemReturnedQuantity, 0)) AS NGQuantity
					 , IIF(MONTH(M1.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, M1.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, M1.VoucherDate)) AS WeekID
				FROM MT2210 M1 WITH (NOLOCK)
				LEFT JOIN MT2211 M2 WITH (NOLOCK) ON M2.APKMaster = M1.APK
				GROUP BY M2.Ana06ID, IIF(MONTH(M1.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, M1.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, M1.VoucherDate))
			) AS P ON P.Ana06ID = M.LineID AND P.WeekID = M.CategoryID
		'

		SET @sSql3 = N'
			DECLARE @DeclaredLines INT = 0

			-- Số lượng line được khai báo mục tiêu và nằm trong danh sách lọc
			SELECT @DeclaredLines = COUNT(*) FROM #LineTmp

			SELECT
				  CONVERT(INT, CategoryID) AS CategoryID
				, (SELECT TOP 1 CONCAT(Name, '' '', CategoryID) FROM A00001 WHERE LanguageID = ''vi-VN'' AND ID = ''A00.WeekCalendar'') AS CategoryName
				, SUM(OKQuantity) AS OKQuantity
				, SUM(NGQuantity) AS NGQuantity
				, CASE WHEN (SUM(OKQuantity) + SUM(NGQuantity)) > 0 THEN SUM(NGQuantity) / (SUM(OKQuantity) + SUM(NGQuantity)) * 100 ELSE 0 
				  END AS ActualPercent
				, CASE WHEN @DeclaredLines > 0 THEN SUM(TargetPercent) / @DeclaredLines ELSE 0
				  END AS TargetPercent
			FROM #ChartLine WITH (NOLOCK)
			GROUP BY CategoryID
			ORDER BY CategoryID
		'

		EXEC(@sSql + @sSql2 + @sSql3)
		PRINT(@sSql + @sSql2 + @sSql3)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
