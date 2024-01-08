IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--  <Summary>
--		Báo cáo lãi lỗ chi nhánh nhiều kỳ
--  </Summary>
--	<History>
/*
	Ngày tạo: 10/09/2019 
		Người tạo: Bảo Toàn
	Modified by Trọng Kiên on 16/11/2020: Bổ sung xử lý giá trị trả về NULL
*/
--	</History>
--	<Example>
/*	BP3027 
	@DivisionID=N'DTI',
	@ReportCode= 'AR-Báo cáo so sánh chi phí', --N'AR- Báo cáo lãi lỗ chi nhánh theo tháng',
	@FromMonth=N'07',
	@FromYear=N'2019',
	@ToMonth=N'8',
	@ToYear=N'2019',
	@FromValueID=N'HCM',
	@ToValueID=N'HN',
	@StrDivisionID=N'DTI',
	@UserID=N'BAOTOAN',
	@IsExcelorPrint=1,
	@IsPeriod=1
*/
--	</Example>
CREATE PROC BP3027
@DivisionID AS nvarchar(50),   
  @ReportCode AS nvarchar(50),   
  @FromMonth int,   
  @FromYear  int,   
  @ToMonth int,   
  @ToYear  int,  
  @FromValueID AS nvarchar(50),   
  @ToValueID AS nvarchar(50),  
  @StrDivisionID AS NVARCHAR(4000) = '' ,
  @UserID AS VARCHAR(50) = '' ,
  @IsExcelorPrint tinyint = NULL, --1: In; 2: Xuất Excel
  @IsPeriod int = NULL,	--1: Theo kỳ; 2: Theo Quý; 3: Năm
  @IsDashBoard bit = 0
AS

BEGIN
	DECLARE @Code VARCHAR(50) = (SELECT TOP 1 FieldID FROM AT7620 WITH (NOLOCK) WHERE ReportCode= @ReportCode)
	DECLARE @FromDate DATE =  CAST(@FromYear as varchar(4)) + RIGHT('0' + CAST(@FromMonth as varchar(4)), 2) + '01'
	DECLARE @ToDate DATE = CAST(@ToYear as varchar(4)) + RIGHT('0' +  CAST(@ToMonth as varchar(4)), 2) + '01'
	DECLARE @TableAna TABLE (AnaID VARCHAR(50)) 


	SELECT AnaID INTO #TableAna
	FROM AT1011 WITH (NOLOCK) WHERE DivisionID in ('DTI', '@@@') AND AnaTypeID = @Code AND AnaID BETWEEN @FromValueID AND @ToValueID
	DECLARE @ColumnMegre INT = (SELECT Count(1) as ColumnMegre FROM AT1011 WITH (NOLOCK) WHERE DivisionID in ('DTI', '@@@') AND AnaTypeID = @Code AND AnaID BETWEEN @FromValueID AND @ToValueID)
	--Cột thêm cột tổng 
	SET @ColumnMegre = @ColumnMegre+1
	--Bảng chứa các kỳ cần truy xuất
	DECLARE @TablePeriod TABLE (PeriodNumber VARCHAR(50), ColumnMegre INT, ColumnName varchar(50))
	DECLARE @TableColumn Table(ColName varchar(50))
	--Tạo bảng chứa dữ liệu
	SELECT TOP 0 CAST('' AS VARCHAR(50)) AS LevelID
		, CAST('' AS NVARCHAR(500)) AS LineDescription
		, CAST('' AS VARCHAR(50)) AS LineCode into #dataResult
	DECLARE @ColumnField VARCHAR(50) = ''
			, @SqlAlter NVARCHAR(MAX) = ''
			, @SqlExcute NVARCHAR(MAX) = ''
			, @SqlTotal NVARCHAR(MAX) = ''
			, @StartIndex int = 0


	DECLARE @Loopdate DATE = @FromDate

	--khởi tại table @TableAna
	INSERT INTO @TableAna
	SELECT AnaID FROM #TableAna

	SET @Loopdate = @FromDate
	WHILE @Loopdate <= @ToDate
	BEGIN 
		INSERT INTO #TableAna
		SELECT AnaID FROM @TableAna

		WHILE EXISTS(SELECT TOP 1 AnaID FROM #TableAna)
		BEGIN
			SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
			----------------------------
			SET @SqlAlter = 'ALTER TABLE #dataResult ADD C'+ FORMAT(@Loopdate,'yyyyMM')+ '@'+@ColumnField + '  DECIMAL(28,8)'
			EXEC(@SqlAlter)			
			-----------------------------
			DELETE #TableAna WHERE AnaID = @ColumnField

			--INSERT COLUMN TABLE
			INSERT INTO @TableColumn(ColName) VALUES ('C'+ FORMAT(@Loopdate,'yyyyMM')+ '@'+@ColumnField)

		END	
		SET @SqlAlter = 'ALTER TABLE #dataResult ADD C'+ FORMAT(@Loopdate,'yyyyMM')+ '@Total  DECIMAL(28,8)'
		--INSERT COLUMN TABLE
		INSERT INTO @TableColumn(ColName) VALUES ('C'+ FORMAT(@Loopdate,'yyyyMM')+ '@Total')

		EXEC(@SqlAlter)	
		SET @Loopdate = DATEADD(MONTH, 1, @Loopdate)
	END

	SET @Loopdate = @FromDate
	WHILE @Loopdate <= @ToDate
	BEGIN 
		

		INSERT INTO @TablePeriod(PeriodNumber,ColumnMegre, ColumnName)
		SELECT FORMAT(@Loopdate,'MM/yyyy'), @ColumnMegre,'C'+ FORMAT(@Loopdate,'yyyyMM')+'@'
		--Tạo chuỗi Insert
		SET @SqlExcute = 'INSERT INTO #dataResult (LevelID, LineDescription, LineCode'
		INSERT INTO #TableAna
		SELECT AnaID FROM @TableAna

		WHILE EXISTS(SELECT TOP 1 AnaID FROM #TableAna)
		BEGIN
			SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
			----------------------------
			--SET @SqlExcute = CONCAT_WS(', ',@SqlExcute, 'C'+ FORMAT(@Loopdate,'yyyyMM')+'@'+ @ColumnField)
			SET @SqlExcute = CONCAT(@SqlExcute,', ', 'C'+ FORMAT(@Loopdate,'yyyyMM')+'@'+ @ColumnField)
			-----------------------------
			DELETE #TableAna WHERE AnaID = @ColumnField
		END	
		SET @SqlExcute =  CONCAT(@SqlExcute,',C'+ FORMAT(@Loopdate,'yyyyMM')+'@Total)','SELECT LevelID, LineDescription, LineCode')
	
		SET @StartIndex = 0
		SET @SqlTotal = ''
		INSERT INTO #TableAna
		SELECT AnaID FROM @TableAna
	
		WHILE EXISTS(SELECT TOP 1 AnaID FROM #TableAna)
		BEGIN	
			SET @StartIndex = @StartIndex + 1
			----------------------------
			--SET @SqlExcute = CONCAT_WS(', ',@SqlExcute, 'Amount'+ RIGHT('00'+CAST(@StartIndex AS VARCHAR(50)),2))
			SET @SqlExcute = CONCAT(@SqlExcute,', ', 'Amount'+ RIGHT('00'+CAST(@StartIndex AS VARCHAR(50)),2))
			--SET @SqlTotal = CONCAT_WS('+',@SqlTotal,'Amount'+ RIGHT('00'+CAST(@StartIndex AS VARCHAR(50)),2))
			SET @SqlTotal = CONCAT(@SqlTotal,'+','Amount'+ RIGHT('00'+CAST(@StartIndex AS VARCHAR(50)),2))
			-----------------------------
			SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
			DELETE #TableAna WHERE AnaID = @ColumnField
		END	
		PRINT SUBSTRING(@SqlTotal,2, LEN(@SqlTotal))
		IF SUBSTRING(@SqlTotal,2, LEN(@SqlTotal)) <> ''
			SET @SqlExcute =  CONCAT(@SqlExcute,',' +  SUBSTRING(@SqlTotal,2, LEN(@SqlTotal)))
		ELSE
			SET @SqlExcute =  CONCAT(@SqlExcute,',0')
		PRINT '-------------------------------'
		PRINT @SqlExcute
		SET @SqlExcute =  CONCAT(@SqlExcute,' FROM AV7620 WITH (NOLOCK) WHERE ReportCode = N'''+@ReportCode+'''')

		SET @FromMonth = CAST(FORMAT(@Loopdate,'MM') AS VARCHAR(50))
		SET @FromYear = CAST(FORMAT(@Loopdate,'yyyy') AS VARCHAR(50))

		EXEC AP7620 @DivisionID,@ReportCode,@FromMonth,@FromYear,@FromMonth,@FromYear
					,@FromValueID,@ToValueID,@StrDivisionID,@UserID,@IsExcelorPrint,@IsPeriod
		PRINT @SqlExcute
		EXEC (@SqlExcute)
			--------------------------------------------	
		--DK kết thúc
		SET @Loopdate = DATEADD(MONTH, 1, @Loopdate)
	END
	--SELECT LevelID, LineDescription, LineCode, Amount01, Amount02,Amount01+Amount02 FROM AV7620 WITH (NOLOCK) ORDER BY LineCode
	--select * from #dataResult ORDER BY LineCode
	--return
	

	

	DECLARE @SqlResult Nvarchar(MAX) = ''
	SET @SqlResult = 'SELECT LevelID, LineDescription, LineCode'

	print @SqlResult
	--SELECT @SqlResult = CONCAT_WS(',',@SqlResult, 'SUM('+ColName+') AS '+ColName)
	SELECT @SqlResult = CONCAT(@SqlResult,',', 'SUM('+ColName+') AS '+ColName)
	FROM @TableColumn
	print @SqlResult
	SET @SqlResult = CONCAT(@SqlResult, ' FROM #dataResult GROUP BY LevelID, LineDescription, LineCode ORDER BY LineCode')
	--Bieu do
	DECLARE @ColumnChart VARCHAR(50) = ''
	SELECT M.PeriodNumber,M01.AnaID,M.ColumnName
			, CAST(0 AS DECIMAL(28,8)) DOANHTHU
			, CAST(0 AS DECIMAL(28,8)) CHIPHI
			, CAST(0 AS DECIMAL(28,8)) LAILO
			, CAST(0 AS BIT) ISUPDATE
			into #TableChart
	FROM @TablePeriod M
		CROSS JOIN @TableAna M01 

	WHILE EXISTS(SELECT 1 FROM #TableChart WHERE ISUPDATE= 0)
	BEGIN
		SET @ColumnChart = (SELECT TOP 1 (ColumnName + AnaID) FROM #TableChart WHERE ISUPDATE= 0)
		SET @SqlExcute = '
				DECLARE @DoanhThu Decimal(28,8) = 0
				SET @DoanhThu = (SELECT SUM('+@ColumnChart
							+') FROM #dataResult '
							+' WHERE LineCode in (''10'',''21''))

				UPDATE #TableChart
				SET DOANHTHU = @DoanhThu
				WHERE (ColumnName + AnaID) = '''+@ColumnChart+''' 

				DECLARE @ChiPhi Decimal(28,8) = 0
				SET @ChiPhi = (SELECT SUM('+@ColumnChart
							+') FROM #dataResult '
							+' WHERE LineCode in (''22'',''25'',''26''))

				UPDATE #TableChart
				SET CHIPHI = @ChiPhi
				WHERE (ColumnName + AnaID) = '''+@ColumnChart+''' 

				DECLARE @LaiLo Decimal(28,8) = 0
				SET @LaiLo = (SELECT SUM('+@ColumnChart
							+') FROM #dataResult '
							+' WHERE LineCode in (''52''))

				UPDATE #TableChart
				SET LAILO = @LaiLo
				WHERE (ColumnName + AnaID) = '''+@ColumnChart+''' 			
		'

		PRINT @SqlExcute
		EXEC(@SqlExcute)

		UPDATE #TableChart
		SET ISUPDATE = 1
		WHERE (ColumnName + AnaID) = @ColumnChart
	END

	--Xem báo cáo chi tiết
	IF @IsDashBoard =0
	BEGIN
		SELECT PeriodNumber, ColumnMegre FROM @TablePeriod
		EXEC (@SqlResult)
		SELECT AnaID, PeriodNumber, ISNULL(DOANHTHU, 0) AS DOANHTHU, ISNULL(CHIPHI, 0) AS CHIPHI, ISNULL(LAILO, 0) AS LAILO 
		FROM #TableChart
		ORDER BY PeriodNumber,AnaID
	END

	--Xem trên dash board
	IF @IsDashBoard =1
	BEGIN
		SELECT AnaID, PeriodNumber, ISNULL(DOANHTHU, 0) AS DOANHTHU, ISNULL(CHIPHI, 0) AS CHIPHI, ISNULL(LAILO, 0) AS LAILO 
		FROM #TableChart
		ORDER BY PeriodNumber,AnaID
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
