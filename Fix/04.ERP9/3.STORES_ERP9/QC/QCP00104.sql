IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP00104]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP00104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- <summary>
---- Load dữ liệu chart tỉ lệ hàng NG (Dữ liệu cột theo line) (QCD0002)
--- <history>
---- Created by Viết Toàn on 21/08/2023
---- Modified by Viết Toàn on 23/08/2023: Lấy dữ liệu đúng theo tuần (Dựa trên thời gian bắt đầu và kết thúc 1 năm theo thiết lập ở bảng AT1101)

CREATE PROCEDURE [dbo].[QCP00104]
( 
	 @DivisionIDs VARCHAR(50),
	 @PeriodList NVARCHAR(MAX) = N'',
	 @WeekList NVARCHAR(MAX) = N'',
	 @IsMonth TINYINT = 1,
	 @Line NVARCHAR(MAX),
	 @ConditionQC NVARCHAR(MAX) = NULL
) 
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sSelect NVARCHAR(MAX) = N'',
		@sGroupBy NVARCHAR(MAX) = N'',
		@week VARCHAR(2)

CREATE TABLE #TargetLine (
	[Type] NVARCHAR(50),
	TypeName NVARCHAR(50), -- Tên cột (Lấy theo tên của line đã chọn ở combobox)
	Quantity DECIMAL(28, 8), -- Giá trị thực tế
	[Target] DECIMAL(28, 8) -- Giá trị mục tiêu
)

DECLARE @Year NVARCHAR(4) = (SELECT TOP 1 BeginYear FROM AT1101)
DECLARE @APKMaster NVARCHAR(50) = (SELECT TOP 1 APK FROM QCT2080 WHERE TranYear = @Year AND DeleteFlg <> 1)
DECLARE @Count INT = 0
-- Month option
IF @IsMonth = 1
BEGIN
	DECLARE @Period NVARCHAR(10),
			@Month NVARCHAR(2),
			@Year1 NVARCHAR(4)
			

	SELECT [Name]
	INTO #PeriodTmp 
	FROM Splitstring(REPLACE(@PeriodList, '''', ''), ',')

	WHILE EXISTS (SELECT TOP 1 1 FROM #PeriodTmp)
	BEGIN
		SET @Period = (SELECT TOP 1 [Name] FROM #PeriodTmp)
		SET @Month = (SELECT TOP 1 [Name] FROM SplitString(@Period, '/'))
		SET @Year1 = (SELECT TOP 1 [Name] FROM SplitString(@Period, '/') ORDER BY [Name] DESC)
		SET @sSelect = N''
		SET @sGroupBy = N''

		SELECT WeekName
		INTO #week_tmp
		FROM dbo.RangeWeekInMonth(CAST(@Month AS INT), CAST(@Year AS INT))

		SET @Count = @Count + (SELECT COUNT(WeekName) FROM #week_tmp)

		WHILE EXISTS (SELECT TOP 1 1 FROM #week_tmp)
		BEGIN
			SET @week = (SELECT TOP 1 WeekName FROM #week_tmp)
			SET @sSelect = @sSelect + CONCAT('QCT81.Value', @week, '+')

			SET @sGroupBy = @sGroupBy + CONCAT('QCT81.Value', @week, ',')

			DELETE FROM #week_tmp WHERE WeekName = @week
		END

		SET @sSQL = N' 
			SELECT DISTINCT ''' +@Month+ ''' AS [Type], AT11.AnaName AS TypeName, MT11.Ana06ID, MT10.VoucherNo,
				ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
				ISNULL(MT11.ItemActual, 0) AS QuantityOK,
				('+SUBSTRING(@sSelect, 1, LEN(@sSelect) - 1)+') AS [Target]
			INTO #TBL_tmp
			FROM 
				MT2211 MT11 WITH (NOLOCK) --ON MT11.APK = QCT01.InheritVoucher
				LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
				LEFT JOIN QCT2081 QCT81 WITH (NOLOCK) ON QCT81.PhaseID = MT11.Ana06ID
				LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK --AND ISNULL(QCT80.DeleteFlg, 0) = 0 AND QCT80.TranYear = CONVERT(INT, '+@Year+')
				LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = MT11.Ana06ID
			WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString('''+@DivisionIDs+''', '',''))
				AND MT10.TranMonth = CONVERT(INT, '''+@Month+''')
				AND MT10.TranYear = CONVERT(INT, '''+@Year1+''')
				AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
				AND QCT80.APK = '''+@APKMaster+'''
			GROUP BY '+SUBSTRING(@sGroupBy, 1, LEN(@sGroupBy) - 1)+'
				  , MT11.ItemReturnedQuantity, MT11.ItemActual, AT11.AnaName, MT11.Ana06ID, MT10.VoucherNo

			SELECT *
			INTO #tmp
			FROM (
				SELECT *
				FROM #TBL_tmp
				UNION ALL
				SELECT ''' +@Month+ ''' AS [Type], AT11.AnaName AS TypeName, MT11.Ana06ID, MT10.VoucherNo,
				ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
				ISNULL(MT11.ItemActual, 0) AS QuantityOK, 0 AS Target
				FROM MT2211 MT11
				LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
				LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = MT11.Ana06ID
				WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString('''+@DivisionIDs+''', '',''))
				AND MT10.TranMonth = CONVERT(INT, '''+@Month+''')
				AND MT10.TranYear = CONVERT(INT, '''+@Year1+''')
				AND MT11.Ana06ID NOT IN (SELECT PhaseID FROM QCT2081 WHERE APKMaster = N'''+@APKMaster+''' AND ISNULL(PhaseID, '''') <> '''')
				AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
			) T1

			SELECT *
			INTO #tmp2 
			FROM (
				SELECT T.Type, T.TypeName, T.Ana06ID, T.VoucherNo, T.QuantityNG, t.QuantityOK, T.Target
				FROM #tmp T
				UNION ALL
				SELECT ''' +@Month+ ''' AS [Type], AT11.AnaName AS TypeName, QCT81.PhaseID AS Ana06ID, N'''' AS VoucherNo ,0 AS QuantityNG, 0 AS QuantityOK, ('+SUBSTRING(@sSelect, 1, LEN(@sSelect) - 1)+') AS [Target]
				FROM QCT2081 QCT81
				LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = QCT81.PhaseID
				WHERE QCT81.PhaseID NOT IN (SELECT Ana06ID FROM #TBL_tmp GROUP BY Ana06ID)
				AND QCT81.APKMaster = '''+@APKMaster+'''
				AND  ISNULL(QCT81.PhaseID, '''') IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
			) T2

			--select *, '+CONVERT(NVARCHAR(50), @Count)+' as count from #tmp2

			INSERT INTO #TargetLine
			SELECT TB.[Type], TB.TypeName
			, IIF(SUM(TB.QuantityNG) <> 0 OR SUM(TB.QuantityOK) <> 0, (SUM(TB.QuantityNG) / (SUM(TB.QuantityNG) + SUM(TB.QuantityOK))) * 100, 0) AS Quantity
			, MAX(Target)
			FROM #tmp2 TB
			GROUP BY TB.TypeName, TB.[Type]

			DROP TABLE #tmp2
			DROP TABLE #tmp
			DROP TABLE #TBL_tmp
		'
		PRINT(@sSQL)
		EXEC(@sSQL)
		
		DROP TABLE #week_tmp
		DELETE FROM #PeriodTmp WHERE [Name] = @Period
	END

	SELECT  TypeName, SUM(Quantity) AS Quantity, IIF(@Count <> 0, SUM(Target) / @Count, 0) AS Target, (SELECT SUM(Quantity) FROM #TargetLine) AS Total 
	FROM #TargetLine
	GROUP BY TypeName

END
 --Week option
ELSE
BEGIN
	DECLARE @StartDate DATETIME,
			@BeginWeek INT,
			@NumWeek INT,
			@EndWeek12 INT 

	SET @StartDate = (CAST((SELECT TOP 1 CONCAT(BeginYear, '-', MONTH(StartDate), '-', DAY(StartDate)) FROM AT1101 ORDER BY BeginYear) AS DATETIME))
	SET @BeginWeek = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, @StartDate),0))
	SET @NumWeek = @BeginWeek - 1 -- Số tuần chênh lệch
	SET @EndWeek12 = DATEPART(WW, CONCAT(YEAR(@StartDate), '-12-31')) -- Tuần kết thúc của tháng 12

	SELECT [Name]
	INTO #tblWeek
	FROM SplitString(REPLACE(@WeekList, '''', ''), ',')

	WHILE EXISTS (SELECT TOP 1 1 FROM #tblWeek)
	BEGIN
		SET @week = (SELECT TOP 1 [Name] FROM #tblWeek)
		SET @Count = @Count + 1

		SELECT DISTINCT @week AS [Type], AT11.AnaName AS TypeName, MT10.VoucherNo, MT11.Ana06ID,
				ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
				ISNULL(MT11.ItemActual, 0) AS QuantityOK,
				CASE WHEN CONVERT(INT, ISNULL(@week, 0)) = 1 THEN QCT81.Value1
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 2 THEN QCT81.Value2
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 3 THEN QCT81.Value3
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 4 THEN QCT81.Value4
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 5 THEN QCT81.Value5
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 6 THEN QCT81.Value6
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 7 THEN QCT81.Value7
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 8 THEN QCT81.Value8
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 9 THEN QCT81.Value9
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 10 THEN QCT81.Value10
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 11 THEN QCT81.Value11
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 12 THEN QCT81.Value12
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 13 THEN QCT81.Value13
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 14 THEN QCT81.Value14
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 15 THEN QCT81.Value15
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 16 THEN QCT81.Value16
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 17 THEN QCT81.Value17
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 18 THEN QCT81.Value18
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 19 THEN QCT81.Value19
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 20 THEN QCT81.Value20
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 21 THEN QCT81.Value21
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 22 THEN QCT81.Value22
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 23 THEN QCT81.Value23
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 24 THEN QCT81.Value24
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 25 THEN QCT81.Value25
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 26 THEN QCT81.Value26
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 27 THEN QCT81.Value27
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 28 THEN QCT81.Value28
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 29 THEN QCT81.Value29
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 30 THEN QCT81.Value30
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 31 THEN QCT81.Value31
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 32 THEN QCT81.Value32
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 33 THEN QCT81.Value33
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 34 THEN QCT81.Value34
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 35 THEN QCT81.Value35
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 36 THEN QCT81.Value36
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 37 THEN QCT81.Value37
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 38 THEN QCT81.Value38
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 39 THEN QCT81.Value39
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 40 THEN QCT81.Value40
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 41 THEN QCT81.Value41
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 42 THEN QCT81.Value42
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 43 THEN QCT81.Value43
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 44 THEN QCT81.Value44
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 45 THEN QCT81.Value45
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 46 THEN QCT81.Value46
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 47 THEN QCT81.Value47
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN QCT81.Value48
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN QCT81.Value48
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 50 THEN QCT81.Value50
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 51 THEN QCT81.Value51
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 52 THEN QCT81.Value52
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 53 THEN QCT81.Value53
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 54 THEN QCT81.Value54
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 55 THEN QCT81.Value55
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 56 THEN QCT81.Value56
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 57 THEN QCT81.Value57
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 58 THEN QCT81.Value58
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 59 THEN QCT81.Value59
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 60 THEN QCT81.Value60
					ELSE 0 END AS [Target]
		INTO #TBL_tmp
		FROM 
			MT2211 MT11 WITH (NOLOCK)
			LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
			LEFT JOIN QCT2081 QCT81 WITH (NOLOCK) ON QCT81.PhaseID = MT11.Ana06ID
			--LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK --AND ISNULL(QCT80.DeleteFlg, 0) = 0 AND QCT80.TranYear = YEAR(@StartDate)
			LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = MT11.Ana06ID
		WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString(@DivisionIDs, ','))
			AND IIF(MONTH(MT10.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, MT10.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, MT10.VoucherDate)) = CONVERT(INT, @week)
			AND QCT81.APKMaster = @APKMaster
			AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString(@Line, ','))
		GROUP BY QCT81.Value1, QCT81.Value2, QCT81.Value3, QCT81.Value4, QCT81.Value5, QCT81.Value6
			  , QCT81.Value7, QCT81.Value8, QCT81.Value9, QCT81.Value10, QCT81.Value11, QCT81.Value12
			  , QCT81.Value13, QCT81.Value14, QCT81.Value15, QCT81.Value16, QCT81.Value17, QCT81.Value18
			  , QCT81.Value19, QCT81.Value20, QCT81.Value21, QCT81.Value22, QCT81.Value23, QCT81.Value24
			  , QCT81.Value25, QCT81.Value26, QCT81.Value27, QCT81.Value28, QCT81.Value29, QCT81.Value30
			  , QCT81.Value31, QCT81.Value32, QCT81.Value33, QCT81.Value34, QCT81.Value35, QCT81.Value36
			  , QCT81.Value37, QCT81.Value38, QCT81.Value39, QCT81.Value40, QCT81.Value41, QCT81.Value42
			  , QCT81.Value43, QCT81.Value44, QCT81.Value45, QCT81.Value46, QCT81.Value47, QCT81.Value48
			  , QCT81.Value49, QCT81.Value50, QCT81.Value51, QCT81.Value52, QCT81.Value53, QCT81.Value54
			  , QCT81.Value55, QCT81.Value56, QCT81.Value57, QCT81.Value58, QCT81.Value59, QCT81.Value60
			  , MT11.ItemReturnedQuantity, MT11.ItemActual, AT11.AnaName, MT10.VoucherNo, MT11.Ana06ID

		SELECT *
		INTO #tmp
		FROM (
			SELECT *
			FROM #TBL_tmp
			UNION ALL
			SELECT @week AS [Type], AT11.AnaName AS TypeName, MT11.Ana06ID, MT10.VoucherNo,
			ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
			ISNULL(MT11.ItemActual, 0) AS QuantityOK, 0 AS Target
			FROM MT2211 MT11
			LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
			LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = MT11.Ana06ID
			WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString(@DivisionIDs, ','))
			AND IIF(MONTH(MT10.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, MT10.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, MT10.VoucherDate)) = CONVERT(INT, @week)
			AND MT11.Ana06ID NOT IN (SELECT PhaseID FROM QCT2081 WHERE APKMaster = @APKMaster AND ISNULL(PhaseID, '') <> '')
			AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString(@Line, ','))
		) T1


		SELECT *
		INTO #tmp2 
		FROM (
			SELECT T.Type, T.TypeName, T.Ana06ID, T.VoucherNo, T.QuantityNG, t.QuantityOK, T.Target
			FROM #tmp T
			UNION ALL
			SELECT @week AS [Type]
			, AT11.AnaName AS TypeName
			, QCT81.PhaseID AS Ana06ID
			, N'' AS VoucherNo 
			,0 AS QuantityNG
			, 0 AS QuantityOK
			, CASE WHEN CONVERT(INT, ISNULL(@week, 0)) = 1 THEN QCT81.Value1
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 2 THEN QCT81.Value2
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 3 THEN QCT81.Value3
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 4 THEN QCT81.Value4
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 5 THEN QCT81.Value5
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 6 THEN QCT81.Value6
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 7 THEN QCT81.Value7
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 8 THEN QCT81.Value8
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 9 THEN QCT81.Value9
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 10 THEN QCT81.Value10
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 11 THEN QCT81.Value11
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 12 THEN QCT81.Value12
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 13 THEN QCT81.Value13
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 14 THEN QCT81.Value14
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 15 THEN QCT81.Value15
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 16 THEN QCT81.Value16
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 17 THEN QCT81.Value17
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 18 THEN QCT81.Value18
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 19 THEN QCT81.Value19
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 20 THEN QCT81.Value20
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 21 THEN QCT81.Value21
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 22 THEN QCT81.Value22
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 23 THEN QCT81.Value23
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 24 THEN QCT81.Value24
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 25 THEN QCT81.Value25
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 26 THEN QCT81.Value26
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 27 THEN QCT81.Value27
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 28 THEN QCT81.Value28
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 29 THEN QCT81.Value29
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 30 THEN QCT81.Value30
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 31 THEN QCT81.Value31
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 32 THEN QCT81.Value32
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 33 THEN QCT81.Value33
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 34 THEN QCT81.Value34
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 35 THEN QCT81.Value35
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 36 THEN QCT81.Value36
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 37 THEN QCT81.Value37
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 38 THEN QCT81.Value38
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 39 THEN QCT81.Value39
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 40 THEN QCT81.Value40
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 41 THEN QCT81.Value41
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 42 THEN QCT81.Value42
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 43 THEN QCT81.Value43
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 44 THEN QCT81.Value44
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 45 THEN QCT81.Value45
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 46 THEN QCT81.Value46
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 47 THEN QCT81.Value47
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN QCT81.Value48
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN QCT81.Value48
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 50 THEN QCT81.Value50
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 51 THEN QCT81.Value51
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 52 THEN QCT81.Value52
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 53 THEN QCT81.Value53
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 54 THEN QCT81.Value54
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 55 THEN QCT81.Value55
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 56 THEN QCT81.Value56
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 57 THEN QCT81.Value57
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 58 THEN QCT81.Value58
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 59 THEN QCT81.Value59
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 60 THEN QCT81.Value60
					ELSE 0 END AS [Target]
			FROM QCT2081 QCT81
			LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = QCT81.PhaseID
			WHERE QCT81.PhaseID NOT IN (SELECT Ana06ID FROM #TBL_tmp GROUP BY Ana06ID)
			AND QCT81.APKMaster = @APKMaster
			AND  ISNULL(QCT81.PhaseID, '') IN (SELECT [Name] FROM SplitString(@Line, ','))
		) T2

		INSERT INTO #TargetLine
		SELECT N'', TB.TypeName
		, IIF(SUM(TB.QuantityNG) <> 0 OR SUM(TB.QuantityOK) <> 0, (SUM(TB.QuantityNG) / (SUM(TB.QuantityNG) + SUM(TB.QuantityOK))) * 100, 0) AS Quantity
		, MAX(Target)
		FROM #tmp2 TB
		GROUP BY TB.TypeName

		
		
		DROP TABLE #TBL_tmp
		DROP TABLE #tmp2
		DROP TABLE #tmp

		DELETE FROM #tblWeek WHERE [NAME] = @week
	END

	SELECT  TypeName, SUM(Quantity) AS Quantity, IIF(@Count <> 0, SUM(Target) / @Count, 0) AS Target, (SELECT SUM(Quantity) FROM #TargetLine) AS Total 
	FROM #TargetLine
	GROUP BY TypeName

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
