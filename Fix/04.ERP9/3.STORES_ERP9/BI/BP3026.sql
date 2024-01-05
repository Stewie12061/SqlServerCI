IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--  <Summary>
--		Dữ liệu vẽ biểu đồ, sau khi xử lý Store AV7620 (Core) lãi lỗ từng chi nhánh
--  </Summary>
--	<History>
/*
	Ngày tạo: 10/09/2019 
		Người tạo: Bảo Toàn
	Ngày sửa: 21/08/2020
		Người sửa: Trọng Kiên - Fix lỗi điều kiện DivisionID
*/
--	</History>
--	<Example>
/*	BP3026 
	@DivisionID=N'DTI',
	@ReportCode= N'AR- Báo cáo lãi lỗ chi nhánh theo tháng',	
	@FromValueID=N'HCM',
	@ToValueID=N'HN',
	@UserID=N'BAOTOAN'
*/
--	</Example>
CREATE PROC BP3026
	@DivisionID AS nvarchar(50) ,
	@ReportCode nvarchar(500),	
	@FromValueID AS nvarchar(50),   
	@ToValueID AS nvarchar(50),
	@UserID AS VARCHAR(50) = '' 
AS

BEGIN
	set nocount on;
	DECLARE @Code VARCHAR(50) = (SELECT TOP 1 FieldID FROM AT7620 WITH (NOLOCK) WHERE ReportCode= @ReportCode)
	DECLARE @TableAna TABLE (AnaID VARCHAR(50)) 

	SELECT AnaID INTO #TableAna
	FROM AT1011 WITH (NOLOCK) WHERE DivisionID in (@DivisionID, '@@@') AND AnaTypeID = @Code AND AnaID BETWEEN @FromValueID AND @ToValueID
	DECLARE @ColumnMegre INT = (SELECT Count(1) as ColumnMegre FROM AT1011 WITH (NOLOCK) WHERE DivisionID in (@DivisionID, '@@@') AND AnaTypeID = @Code AND AnaID BETWEEN @FromValueID AND @ToValueID)
	--Cột thêm cột tổng 
	SET @ColumnMegre = @ColumnMegre+1
	--Bảng chứa các kỳ cần truy xuất	
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

	--khởi tại table @TableAna
	INSERT INTO @TableAna
	SELECT AnaID FROM #TableAna

	
	
	WHILE EXISTS(SELECT TOP 1 AnaID FROM #TableAna)
	BEGIN
		SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
		----------------------------
		SET @SqlAlter = 'ALTER TABLE #dataResult ADD '+@ColumnField + '  DECIMAL(28,8)'
		EXEC(@SqlAlter)			
		-----------------------------
		
		DELETE #TableAna WHERE AnaID = @ColumnField

		--INSERT COLUMN TABLE
		INSERT INTO @TableColumn(ColName) VALUES (@ColumnField)

	END	
		--Tạo chuỗi Insert
		SET @SqlExcute = 'INSERT INTO #dataResult (LevelID, LineDescription, LineCode'
		INSERT INTO #TableAna
		SELECT AnaID FROM @TableAna

		WHILE EXISTS(SELECT TOP 1 AnaID FROM #TableAna)
		BEGIN
			SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
			----------------------------
			--SET @SqlExcute = CONCAT_WS(', ',@SqlExcute, @ColumnField)
			SET @SqlExcute = CONCAT(@SqlExcute,', ', @ColumnField)
			-----------------------------
			DELETE #TableAna WHERE AnaID = @ColumnField
		END	
		SET @SqlExcute =  CONCAT(@SqlExcute,') SELECT LevelID, LineDescription, LineCode')
	
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
			-----------------------------
			SET @ColumnField = (SELECT TOP 1 AnaID FROM #TableAna)
			DELETE #TableAna WHERE AnaID = @ColumnField
		END	
		
		SET @SqlExcute =  CONCAT(@SqlExcute,' FROM AV7620 WITH (NOLOCK) WHERE ReportCode = N'''+@ReportCode+'''')
		
		PRINT @SqlExcute
		EXEC (@SqlExcute)
			--------------------------------------------	\

	DECLARE @SqlResult Nvarchar(MAX) = ''
	SET @SqlResult = 'SELECT Criteria'
	--SELECT @SqlResult = CONCAT_WS(',',@SqlResult, ColName)
	SELECT @SqlResult = CONCAT(@SqlResult,',', ColName)
	FROM @TableColumn

	SET @SqlResult = CONCAT(@SqlResult, ' FROM (')
	--Doanh thu
	SET @SqlResult = CONCAT(@SqlResult, ' Select N''Doanh thu'' Criteria ')
	--SELECT @SqlResult = CONCAT_WS(',',@SqlResult, 'SUM('+ColName+') AS '+ColName)
	SELECT @SqlResult = CONCAT(@SqlResult,',', 'SUM('+ColName+') AS '+ColName)
	FROM @TableColumn	
	SET @SqlResult = CONCAT(@SqlResult, ' From #dataResult WHERE LineCode IN (''10'',''21'')')
	SET @SqlResult = CONCAT(@SqlResult, ' UNION ALL ')
	--Chi phí
	SET @SqlResult = CONCAT(@SqlResult, N' Select N''Chi phí'' Criteria ')
	--SELECT @SqlResult = CONCAT_WS(',',@SqlResult, 'SUM('+ColName+') AS '+ColName)
	SELECT @SqlResult = CONCAT(@SqlResult,',', 'SUM('+ColName+') AS '+ColName)
	FROM @TableColumn	
	SET @SqlResult = CONCAT(@SqlResult, ' From #dataResult WHERE LineCode IN (''22'',''25'',''26'')')
	SET @SqlResult = CONCAT(@SqlResult, ' UNION ALL ')
	--Lãi lỗ
	SET @SqlResult = CONCAT(@SqlResult, N' Select N''Lãi lỗ'' Criteria ')
	--SELECT @SqlResult = CONCAT_WS(',',@SqlResult, 'SUM('+ColName+') AS '+ColName)
	SELECT @SqlResult = CONCAT(@SqlResult,',', 'SUM('+ColName+') AS '+ColName)
	FROM @TableColumn	
	SET @SqlResult = CONCAT(@SqlResult, ' From #dataResult WHERE LineCode IN (''52'')')
	SET @SqlResult = CONCAT(@SqlResult, ' ) AS T')

	print @SqlResult
	EXEC (@SqlResult)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
