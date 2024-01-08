IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30020_Standard]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP30020_Standard]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu cho báo cáo tổng hợp bán hàng theo loại sản phẩm theo CustomerIndex chuẩn.
--<History>
---- Create by Anh Đô on 30/01/2023

CREATE PROC SOP30020_Standard
			 @DivisionID		VARCHAR(50)
			,@IsDate			TINYINT
			,@FromDate			DATETIME
			,@ToDate			DATETIME
			,@PeriodList		VARCHAR(MAX)
			,@ObjectID			VARCHAR(MAX)
			,@SalesManID		VARCHAR(MAX)
			,@InventoryID		VARCHAR(MAX)
			,@InventoryTypeID	VARCHAR(MAX)
AS
BEGIN
	DECLARE	 @sSql				NVARCHAR(MAX)
			,@sWhere			NVARCHAR(MAX) = N''
	-- Lọc theo thời gian
	IF ISNULL(@IsDate, 1) = 1
	BEGIN
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, O.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, O.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, O.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere+' AND (CASE WHEN  MONTH(O.VoucherDate) <10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(O.VoucherDate))))+''/''+LTRIM(RTRIM(STR(YEAR(O.VoucherDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(O.VoucherDate))))+''/''+LTRIM(RTRIM(STR(YEAR(O.VoucherDate)))) END) IN ('''+@PeriodList+''')'
	END

	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND O.ObjectID IN (SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '',''))'
	IF ISNULL(@SalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND O.SalesManID IN (SELECT Value FROM [dbo].StringSplit('''+ @SalesManID +''', '',''))'
	IF ISNULL(@InventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND O.InventoryID IN (SELECT Value FROM [dbo].StringSplit('''+ @InventoryID +''', '',''))'
	IF ISNULL(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND M.InventoryTypeID IN ('''+ @InventoryTypeID +''')'


	SET @sSql = N'
		SELECT
			ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS Row
			,M.InventoryTypeID
			,M.InventoryTypeName
			,SUM(O.OrderQuantity) AS OrderQuantity
			,SUM(O.DiscountAmount) AS DiscountAmount
			,SUM(O.OriginalAmount - O.DiscountAmount) AS OriginalAmountBeforeVAT
			,SUM(O.ConvertedAmount - O.DiscountAmount * O.ExchangeRate) AS ConvertedAmountBeforeVAT
			,SUM(O.VATConvertedAmount) AS VATConvertedAmount
			,SUM(O.ConvertedAmount - O.DiscountAmount * O.ExchangeRate + O.VATConvertedAmount) AS TotalAmountAfterVAT
		INTO #tmp
		FROM AT1301 M
		INNER JOIN OV2300 O ON O.InventoryTypeID = M.InventoryTypeID
		WHERE M.DivisionID IN ('''+ @DivisionID +''', ''@@@'') '+ @sWhere +'
		GROUP BY M.InventoryTypeID ,M.InventoryTypeName

		SELECT * FROM #tmp

		SELECT
			 SUM(OrderQuantity) AS TotalOrderQuantity
			,SUM(OriginalAmountBeforeVAT) AS TotalOriginalAmountBeforeVAT
			,SUM(ConvertedAmountBeforeVAT) AS TotalConvertedAmountBeforeVAT
			,SUM(VATConvertedAmount) AS TotalVATConvertedAmount
			,SUM(TotalAmountAfterVAT) AS TotalAmountAfterVAT
			,SUM(DiscountAmount) AS TotalDiscountAmount
		FROM #tmp
	'
	PRINT(@sSql)
	EXEC(@sSql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
