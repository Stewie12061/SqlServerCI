IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP04071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP04071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---		Báo cáo phân loại doanh thu sản phẩm theo cấp (Đã trừ hồi)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Viết Toàn on [18/12/2023]:	-- Bổ sung Báo cáo phân loại doanh thu sản phẩm theo cấp (Đã trừ hồi)
	
 CREATE PROCEDURE [dbo].[AP04071] (
		 @DivisionID VARCHAR(100),
		 @IsDate INT,
		 @FromMonth INT,
		 @ToMonth INT,
		 @FromYear INT,
		 @ToYear INT,
		 @FromDate DATETIME,
		 @ToDate DATETIME,
		 @FromAnaID VARCHAR(50),
		 @ToAnaID VARCHAR(50),
		 @FromObjectID VARCHAR(50),
		 @ToObjectID VARCHAR(50),
		 @FromInventoryID VARCHAR(50),
		 @ToInventoryID VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWHERE NVARCHAR(MAX) = N'', 
		@sWHERE1 NVARCHAR(MAX) = N'', 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20)

	SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
	SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	IF @IsDate = 0
	BEGIN
		SET @sWHERE = @sWHERE + ' AND A00.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+''''
		SET @sWHERE1 = @sWHERE1 + ' AND AT9000.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+''''
	END
	ELSE
	BEGIN
		SET @sWHERE = @sWHERE + ' AND (CONVERT(INT, A00.TranMonth) + CONVERT(INT, A00.TranYear) * 100) BETWEEN '+@FromMonthYearText+' AND '+@ToMonthYearText
		SET @sWHERE1 = @sWHERE1 + ' AND (CONVERT(INT, AT9000.TranMonth) + CONVERT(INT, AT9000.TranYear) * 100) BETWEEN '+@FromMonthYearText+' AND '+@ToMonthYearText
	END

	IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND A00.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+ ''''
		SET @sWHERE1 = @sWHERE1 + ' AND AT9000.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+ ''''
	END

	IF ISNULL(@FromInventoryID, '') <> '' AND ISNULL(@ToInventoryID, '') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND A00.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+ ''''
		SET @sWHERE1 = @sWHERE1 + ' AND AT9000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+ ''''
	END
	
	IF ISNULL(@FromAnaID, '') <> '' AND ISNULL(@ToAnaID, '') <> ''
		SET @sWHERE = @sWHERE + ' AND A22.I01ID BETWEEN '''+@FromAnaID+''' AND '''+@ToAnaID+ ''''

	SET @sSQL = '
		SELECT ROW_NUMBER () OVER (ORDER BY A00.InventoryID) AS Orders
		, A00.InventoryID
		, A02.InventoryName
		, A15.AnaID, A15.AnaName
		, A99.S01ID, A99.S02ID, A99.S03ID, A99.S04ID, A99.S05ID, A99.S06ID, A99.S07ID, A99.S08ID, A99.S09ID, A99.S10ID
		, A99.S11ID, A99.S12ID, A99.S13ID, A99.S14ID, A99.S15ID, A99.S16ID, A99.S17ID, A99.S18ID, A99.S19ID, A99.S20ID
		, CASE WHEN SUM(ISNULL(A00.ConvertedQuantity, 0)) > COALESCE(SUM(ISNULL(A01.ConvertedQuantity, 0)), 0) THEN SUM(ISNULL(A00.ConvertedQuantity, 0)) - COALESCE(SUM(ISNULL(A01.ConvertedQuantity, 0)), 0) ELSE 0 END AS Quantity
		, CASE WHEN SUM(ISNULL(A00.ConvertedAmount, 0)) > COALESCE(SUM(ISNULL(A01.ConvertedAmount, 0)), 0) THEN SUM(ISNULL(A00.ConvertedAmount, 0)) - COALESCE(SUM(ISNULL(A01.ConvertedAmount, 0)), 0) ELSE 0 END AS Revenue
		FROM AT9000 A00
		LEFT JOIN (
			SELECT AT9000.InventoryID, AT9000.ConvertedQuantity, AT9000.ConvertedAmount
			, A99_1.S01ID, A99_1.S02ID, A99_1.S03ID, A99_1.S04ID, A99_1.S05ID, A99_1.S06ID, A99_1.S07ID, A99_1.S08ID, A99_1.S09ID, A99_1.S10ID
			, A99_1.S11ID, A99_1.S12ID, A99_1.S13ID, A99_1.S14ID, A99_1.S15ID, A99_1.S16ID, A99_1.S17ID, A99_1.S18ID, A99_1.S19ID, A99_1.S20ID
			FROM AT9000
			LEFT JOIN AT8899 A99_1 WITH (NOLOCK) ON A99_1.VoucherID = AT9000.VoucherID AND A99_1.TransactionID = AT9000.TransactionID AND A99_1.DivisionID = AT9000.DivisionID
			WHERE AT9000.TransactionTypeID IN (''T24'',''T74'',''T04'')
				AND AT9000.TableID in (''AT9000'', ''AT1326'', ''MT1603'')
				'+@sWHERE1+'
		) A01 ON A01.InventoryID = A00.InventoryID
		LEFT JOIN AV1322 A22 WITH (NOLOCK) ON A22.InventoryID = A00.InventoryID
		LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.AnaID = A22.I01ID AND A15.AnaTypeID = ''I01''
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = A00.InventoryID AND A02.DivisionID IN (''@@@'', A00.DivisionID)
		LEFT JOIN AT8899 A99 WITH (NOLOCK) ON A99.VoucherID = A00.VoucherID AND A99.TransactionID = A00.TransactionID AND A99.DivisionID = A00.DivisionID
		WHERE A00.TransactionTypeID IN (''T04'',''T64'') 
		AND A00.DivisionID IN (SELECT [Value] FROM StringSplit('''+@DivisionID+''', '',''))
	' + @sWHERE + ' 
		 AND ISNULL(A01.S01ID, '''') = ISNULL(A99.S01ID, '''')
		 AND ISNULL(A01.S02ID, '''') = ISNULL(A99.S02ID, '''')
		 AND ISNULL(A01.S03ID, '''') = ISNULL(A99.S03ID, '''')
		 AND ISNULL(A01.S04ID, '''') = ISNULL(A99.S04ID, '''')
		 AND ISNULL(A01.S05ID, '''') = ISNULL(A99.S05ID, '''')
		 AND ISNULL(A01.S06ID, '''') = ISNULL(A99.S06ID, '''')
		 AND ISNULL(A01.S07ID, '''') = ISNULL(A99.S07ID, '''')
		 AND ISNULL(A01.S08ID, '''') = ISNULL(A99.S08ID, '''')
		 AND ISNULL(A01.S09ID, '''') = ISNULL(A99.S09ID, '''')
		 AND ISNULL(A01.S10ID, '''') = ISNULL(A99.S10ID, '''')
		 AND ISNULL(A01.S11ID, '''') = ISNULL(A99.S11ID, '''')
		 AND ISNULL(A01.S12ID, '''') = ISNULL(A99.S12ID, '''')
		 AND ISNULL(A01.S13ID, '''') = ISNULL(A99.S13ID, '''')
		 AND ISNULL(A01.S14ID, '''') = ISNULL(A99.S14ID, '''')
		 AND ISNULL(A01.S15ID, '''') = ISNULL(A99.S15ID, '''')
		 AND ISNULL(A01.S16ID, '''') = ISNULL(A99.S16ID, '''')
		 AND ISNULL(A01.S17ID, '''') = ISNULL(A99.S17ID, '''')
		 AND ISNULL(A01.S18ID, '''') = ISNULL(A99.S18ID, '''')
		 AND ISNULL(A01.S19ID, '''') = ISNULL(A99.S19ID, '''')
		 AND ISNULL(A01.S20ID, '''') = ISNULL(A99.S20ID, '''')
		GROUP BY A00.InventoryID, A02.InventoryName, A15.AnaID, A15.AnaName
		, A99.S01ID, A99.S02ID, A99.S03ID, A99.S04ID, A99.S05ID, A99.S06ID, A99.S07ID, A99.S08ID, A99.S09ID, A99.S10ID
		, A99.S11ID, A99.S12ID, A99.S13ID, A99.S14ID, A99.S15ID, A99.S16ID, A99.S17ID, A99.S18ID, A99.S19ID, A99.S20ID
		ORDER BY A00.InventoryID
	'
	PRINT(@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO