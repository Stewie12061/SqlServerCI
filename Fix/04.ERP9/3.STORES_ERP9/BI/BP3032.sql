IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modifed by Kiều Nga 11/09/2020: Bổ sung đk lọc @DivisionIDList
-- <Example>

CREATE PROC [dbo].[BP3032]

@DivisionID varchar(50),
@UserID varchar(50),
@FromYear varchar(50),
@ToYear varchar(50),
@FromPeriodFilter varchar(50),
@ToPeriodFilter varchar(50),
@IsPeriod tinyint,
@DivisionIDList AS NVARCHAR(MAX) = NULL
--@Ana01ID varchar(50)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @InputFromDate varchar(10) = '' -- format: yyyyMMdd
			, @FromDatePivot date
			, @InputToDate varchar(10) = '' -- format: yyyyMMdd
			, @ToDatePivot date
			, @TmpDatePivot date
			, @ColumnPivot nvarchar(max) = ''
			, @QueryPivot nvarchar(max) = ''
			, @AnaTypeID varchar(50) = 'A02'
			, @Ana01ID varchar(50) = ''
			, @sSQLWhereDivision NVARCHAR(MAX) = ''
	--Format giá trị đầu vào

	IF COALESCE(@DivisionIDList, '') = ''
	BEGIN
		SET @sSQLWhereDivision = @sSQLWhereDivision + ' AND DivisionID IN ('''+ @DivisionID+''')'
	END
	Else
	BEGIN
	SET @sSQLWhereDivision = @sSQLWhereDivision + ' AND DivisionID IN ('''+@DivisionIDList+''')'
	END

	----------------------------------------
	--DECLARE #DataSource TABLE (TieuChi nvarchar(500), [Date] Datetime, [Value] decimal(20,8))
	CREATE TABLE #DataSource (DivisionID nvarchar(50),TieuChi nvarchar(500), [Date] Datetime, [Value] decimal(20,8))
	-- BÁO CÁO THEO KỲ (THÁNG)
	IF @IsPeriod = 0
	BEGIN
		--[Dữ liệu đầu vào có dạng: 01/2020]
		--Chuẩn hóa dữ liệu đầu vào thành: yyyyMMdd 
		select @InputFromDate = CONCAT(@InputFromDate,[VALUE]) from dbo.StringSplit(@FromPeriodFilter,'/') ORDER BY [VALUE] DESC
		SET @InputFromDate = @InputFromDate + '01'

		select @InputToDate = CONCAT(@InputToDate,[VALUE]) from dbo.StringSplit(@ToPeriodFilter,'/') ORDER BY [VALUE] DESC
		SET @InputToDate = DATEADD(day, -1,DATEADD(m, 1,CONVERT(date, @InputToDate+'01')))

		INSERT INTO #DataSource 
		SELECT DivisionID,Ana01ID, VoucherDate, ConvertedAmount
		FROM AT9000 WITH (NOLOCK)
		WHERE VoucherDate BETWEEN @InputFromDate AND @InputToDate
			AND ISNULL(Ana02ID,'') <> ''

		--Cài đặt dữ liệu vòng.
		SET @FromDatePivot = CONVERT(date, @InputFromDate)
		SET @ToDatePivot = CONVERT(date, @InputToDate)
		
		WHILE @FromDatePivot < @ToDatePivot
		BEGIN
			SET @ColumnPivot = @ColumnPivot + QUOTENAME(FORMAT(@FromDatePivot,'MM/yyyy')) +','
			SET @FromDatePivot = DATEADD(m,1, @FromDatePivot)
		END	

		SET @ColumnPivot = LEFT(@ColumnPivot, LEN(@ColumnPivot) -1)

		SET @QueryPivot = N'
			SELECT AT1011.AnaName TIEUCHI, '+@ColumnPivot+'
			FROM (
				SELECT TIEUCHI, FORMAT([DATE],''MM/yyyy'') [Period], [VALUE]
				FROM #DataSource
				WHERE [DATE] BETWEEN @InputFromDate AND @InputToDate '+@sSQLWhereDivision+'
			)  AS tbl_Pivot
			PIVOT  (
				SUM([VALUE])
				FOR [Period] IN (
				'+@ColumnPivot+'
				)
			) AS tbl_Pivot
			RIGHT JOIN (SELECT AnaID,AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeID = @AnaTypeID) AT1011 ON tbl_Pivot.TIEUCHI = AT1011.AnaID
		'
		PRINT @QueryPivot
		EXEC sp_executesql @QueryPivot
		,N'@InputFromDate DATETIME, @InputToDate DATETIME, @AnaTypeID Varchar(50)'
		, @InputFromDate = @InputFromDate
		, @InputToDate = @InputToDate
		, @AnaTypeID = @AnaTypeID
	END

	-- BÁO CÁO THEO NĂM
	IF @IsPeriod = 2
	BEGIN
		--[Dữ liệu đầu vào có dạng: YYYY]
		--Chuẩn hóa dữ liệu đầu vào thành: yyyyMMdd 
		SET @InputFromDate = @FromYear + '/01/01'
		SET @InputToDate = @ToYear + '/12/31'

		INSERT INTO #DataSource 
		SELECT DivisionID,Ana01ID, VoucherDate, ConvertedAmount
		FROM AT9000 WITH (NOLOCK)
		WHERE VoucherDate BETWEEN @InputFromDate AND @InputToDate
			AND ISNULL(Ana01ID,'') <> ''
		--Cài đặt dữ liệu vòng.
		SET @FromDatePivot = CONVERT(date, @InputFromDate)
		SET @ToDatePivot = CONVERT(date, @InputToDate)

		WHILE @FromDatePivot <= @ToDatePivot
		BEGIN
			SET @ColumnPivot = @ColumnPivot + QUOTENAME(FORMAT(@FromDatePivot,'yyyy')) +','
			SET @FromDatePivot = DATEADD(YEAR,1, @FromDatePivot)
		END
		print @ColumnPivot
		SET @ColumnPivot = LEFT(@ColumnPivot, LEN(@ColumnPivot) -1)

		SET @QueryPivot = N'
			SELECT AT1011.AnaName TIEUCHI, '+@ColumnPivot+'
			FROM (
				SELECT TIEUCHI, FORMAT([DATE],''yyyy'') [Year], [VALUE]
				FROM #DataSource
				WHERE [DATE] BETWEEN @InputFromDate AND @InputToDate '+@sSQLWhereDivision+'
			)  AS tbl_Pivot
			PIVOT  (
				SUM([VALUE])
				FOR [Year] IN (
				'+@ColumnPivot+'
				)
			) AS tbl_Pivot
			RIGHT JOIN (SELECT AnaID,AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeID = @AnaTypeID) AT1011 ON tbl_Pivot.TIEUCHI = AT1011.AnaID
		'
		PRINT @QueryPivot
		EXEC sp_executesql @QueryPivot
		,N'@InputFromDate DATETIME, @InputToDate DATETIME, @AnaTypeID varchar(50)'
		, @InputFromDate = @InputFromDate
		, @InputToDate = @InputToDate
		, @AnaTypeID = @AnaTypeID
	END
END
GO


