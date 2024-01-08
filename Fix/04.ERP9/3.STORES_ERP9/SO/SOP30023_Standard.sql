IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30023_Standard]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].SOP30023_Standard
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--<summary>
--- In báo cáo chi tiết bán hàng theo loại sản phẩm theo CustomerIndex chuẩn
--<History>
--- Created on 31/01/2023 by Anh Đô
--<example>

CREATE PROC SOP30023_Standard
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
			O.DivisionID
			,A2.DivisionName
			,M.InventoryTypeID
			,M.InventoryTypeName
			,O.VoucherDate
			,O.VoucherNo
			,O.SalesManID
			,O.SalesManName
			,O.ObjectID
			,O.ObjectName
			,O.ShipDate
			,O.InventoryID
			,O.InventoryName
			,O.UnitID
			,O.UnitName
			,O.OrderQuantity
			,O.SalePrice
			,O.DiscountPercent
			,O.DiscountAmount
			,O.VATPercent
			,O.VATOriginalAmount
			,O.VATConvertedAmount
			,(O.OriginalAmount - O.DiscountAmount) AS TotalAmountBeforeVAT
			,O.TotalOriginalAmount AS TotalAmounAfterVAT
			,A1.VoucherTypeName
		FROM
		AT1301 M
		INNER JOIN OV2300 O ON O.InventoryTypeID = M.InventoryTypeID
		LEFT JOIN AT1007 A1 ON A1.VoucherTypeID = O.VoucherTypeID
		LEFT JOIN AT1101 A2 ON A2.DivisionID = O.DivisionID
		WHERE ISNULL(M.Disabled, 0) = 0 AND M.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		'+ @sWhere +'
		ORDER BY M.InventoryTypeID, O.VoucherDate, O.VoucherNo
	'

	PRINT(@sSql)
	EXEC(@sSql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
