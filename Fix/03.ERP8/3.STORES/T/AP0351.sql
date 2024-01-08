IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0351]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0351]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo bán hàng khuy?n mãi theo nhóm sp – chi ti?t s?n ph?m 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/11/2016 by Hải Long
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>

-- exec AP0351 @DivisionID = 'ANG',  @FromMonth = 1, @ToMonth = 1, @FromYear = 2016, @ToYear = 2016, @FromDate = '01/01/2016', @ToDate = '09/30/2016', @FromObjectID = '00022', @ToObjectID = 'XOABO', @FromInventory = 'BBCN01', @ToInventory = 'VLVNST500', @FromI03ID = 'BPMUA1', @ToI03ID = 'VL', @FromAna01ID = '00167', @ToAna01ID = '2140', @IsDate = 0, @Mode = 1

CREATE PROCEDURE [dbo].[AP0351]      
			@DivisionID nvarchar(50),
		    @FromMonth int,
		    @FromYear int,
		    @ToMonth int,
		    @ToYear int,  
		    @FromDate as datetime,
		    @ToDate as Datetime,
		    @FromObjectID NVARCHAR(50),
			@ToObjectID NVARCHAR(50),
			@FromInventory NVARCHAR(50),
			@ToInventory NVARCHAR(50),
			@FromI03ID NVARCHAR(50),
			@ToI03ID NVARCHAR(50),
			@FromAna01ID NVARCHAR(50),
			@ToAna01ID NVARCHAR(50),
			@IsDate as TINYINT, ----0 theo kỳ, 1 theo ngày
		    @Mode AS TINYINT
	
				
AS
DECLARE @sSQL1 as nvarchar(4000),
		@sSQL2 as nvarchar(4000),
		@sSQL3 as nvarchar(4000),
		@sSQL4 as nvarchar(4000),
		@sSQL5 as nvarchar(4000),
		@sSQL6 as nvarchar(4000),
		@sSQL7 as nvarchar(4000),
		@sSQL8 as nvarchar(4000),
		@sSQL9 as nvarchar(4000),
		@sWhere AS nvarchar(4000) = '',
		@sWhere2 AS nvarchar(4000) = '',
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20)
		
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)	

-- 1. Nhóm theo SP – Chi tiết đối tượng
IF @Mode = 1
BEGIN
SET @sWhere2 = '
				AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + '''
				AND ISNULL(AT1302.I03ID, '''') BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID + ''''
END
ELSE
-- 2. Nhóm theo đối tượng – chi tiết SP
IF @Mode = 2
BEGIN
SET @sWhere2 = '
				AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + '''
				AND ISNULL(AT1302.InventoryID, '''') BETWEEN '''+@FromInventory+''' AND '''+@ToInventory + ''''
END
ELSE
-- 3. Nhóm theo nhân viên –chi tiết SP
IF @Mode = 3
BEGIN
SET @sWhere2 = '
				AND ISNULL(OT2001.Ana01ID, '''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID + '''
				AND ISNULL(AT1302.InventoryID, '''') BETWEEN '''+@FromInventory+''' AND '''+@ToInventory + ''''
END
ELSE
-- 4. Nhóm theo nhân viên –chi tiết đối tượng
IF @Mode = 4
BEGIN
SET @sWhere2 = '
				AND ISNULL(OT2001.Ana01ID, '''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID + '''
				AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + ''''
END	
		
IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN '+ @FromMonthYearText +' AND ' + @ToMonthYearText
END
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND (AT9000.VoucherDate BETWEEN '''+ Convert(nvarchar(10),@FromDate,21)+ ''' AND '''+ convert(nvarchar(10), @ToDate,21)+''')'			
END			

SET @sSQL1 = '
SELECT		AT9000.DivisionID, AT9000.InventoryID, AT1302.InventoryTypeID, AT1301.InventoryTypeName,
			AT1302.InventoryName, AT1302.UnitID, AT9000.ObjectID, AT1202.ObjectName,
			AT1302.I03ID, AT1015.AnaName AS I03ID_AnaName, AT9000.DParameter03,	
			AT1304.UnitName, AT9000.CurrencyID,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.Quantity, 0) ELSE 0 END) AS Quantity,			
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.OriginalAmount, 0) ELSE 0 END) AS OriginalAmount,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.ConvertedAmount, 0) ELSE 0 END) AS ConvertedAmount,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.DiscountAmount, 0) ELSE 0 END) AS DiscountAmount,
			ISNULL(AT9000.ExchangeRate, 1)*ISNULL(AT9000.DiscountSaleAmountDetail, 0) AS DiscountSalesAmount,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0) ELSE 0 END) AS VATConvertedAmount,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ROUND(ISNULL(A1.UnitPrice, 0)*ISNULL(AT9000.Quantity, 0)*ISNULL(A1.ExchangeRate, 1), 0) ELSE 0 END) AS PrimeConvertAmount,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ISNULL(AT9000.Quantity, 0) ELSE 0 END) AS QuantityPromo,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ROUND(ISNULL(A1.UnitPrice, 0)*ISNULL(AT9000.Quantity, 0)*ISNULL(A1.ExchangeRate, 1), 0) ELSE 0 END) AS PrimeConvertAmountPromo,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ISNULL(AT9000.ConvertedAmount, 0) ELSE 0 END) AS ConvertedAmountPromo,
			(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0) ELSE 0 END) AS VATConvertedAmountPromo
'
			
SET @sSQL2 = '
INTO #TEMP1								
FROM		AT9000 WITH(NOLOCK)
LEFT JOIN	AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
LEFT JOIN	AT1301 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1301.DivisionID,''@@@'') AND AT1302.InventoryTypeID = AT1301.InventoryTypeID 
LEFT JOIN	AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN	AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1302.I03ID = AT1015.AnaID AND AT1015.AnaTypeID = ''I03''
LEFT JOIN	OT2001 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.OrderID = OT2001.SOrderID
LEFT JOIN	OT1002 O01 WITH (NOLOCK) ON OT2001.DivisionID = O01.DivisionID AND O01.AnaID = OT2001.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN	OT1002 O02 WITH (NOLOCK) ON OT2001.DivisionID = O02.DivisionID AND O02.AnaID = OT2001.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN	OT1002 O03 WITH (NOLOCK) ON OT2001.DivisionID = O03.DivisionID AND O03.AnaID = OT2001.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN	OT1002 O04 WITH (NOLOCK) ON OT2001.DivisionID = O04.DivisionID AND O04.AnaID = OT2001.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN	OT1002 O05 WITH (NOLOCK) ON OT2001.DivisionID = O05.DivisionID AND O05.AnaID = OT2001.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN	AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN 
(
	SELECT AT0266_AG.DivisionID, AT0266_AG.VoucherID, MAX(AT2007.UnitPrice) AS UnitPrice, AT2007.InventoryID, MAX(AT2007.ExchangeRate) AS ExchangeRate
	FROM AT0266_AG WITH (NOLOCK) 
	LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.VoucherID = AT0266_AG.InheritVoucherID AND AT2007.TransactionID = AT0266_AG.InheritTransactionID
	GROUP BY AT0266_AG.DivisionID, AT0266_AG.VoucherID, AT2007.InventoryID
) A1 ON A1.DivisionID = AT9000.DivisionID AND A1.VoucherID = AT9000.VoucherID AND A1.InventoryID = AT9000.InventoryID
WHERE		AT9000.DivisionID = '''+@DivisionID+'''			
			AND AT9000.TransactionTypeID IN (''T04'', ''T40'')' + @sWhere2 + @sWhere + '
'

SET @sSQL3 = '
UNION ALL
SELECT		AT9000.DivisionID, AT9000.InventoryID, AT1302.InventoryTypeID, AT1301.InventoryTypeName,
			AT1302.InventoryName, AT1302.UnitID, AT9000.ObjectID, AT1202.ObjectName,
			AT1302.I03ID, AT1015.AnaName AS I03ID_AnaName, AT9000.DParameter03,	
			AT1304.UnitName, AT9000.CurrencyID,
			ISNULL(OT2001.Ana01ID, AT9000.SOAna01ID) AS Ana01ID, ISNULL(OT2001.Ana02ID, AT9000.SOAna02ID) AS Ana02ID, ISNULL(OT2001.Ana03ID, AT9000.SOAna03ID) AS Ana03ID, ISNULL(OT2001.Ana04ID, AT9000.SOAna04ID) AS Ana04ID, ISNULL(OT2001.Ana05ID, AT9000.SOAna05ID) AS Ana05ID,
			O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.Quantity, 0) ELSE 0 END) AS Quantity,			
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.OriginalAmount, 0) ELSE 0 END) AS OriginalAmount,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.ConvertedAmount, 0) ELSE 0 END) AS ConvertedAmount,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ISNULL(AT9000.DiscountAmount, 0) ELSE 0 END) AS DiscountAmount,
			-1*ISNULL(AT9000.ExchangeRate, 1)*ISNULL(AT9000.DiscountSaleAmountDetail, 0) AS DiscountSalesAmount,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0) ELSE 0 END) AS VATConvertedAmount,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 0 THEN ROUND(ISNULL(A27.UnitPrice, 0)*ISNULL(AT9000.Quantity, 0)*ISNULL(A27.ExchangeRate, 1), 0) ELSE 0 END) AS PrimeConvertAmount,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ISNULL(AT9000.Quantity, 0) ELSE 0 END) AS QuantityPromo,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ROUND(ISNULL(A27.UnitPrice, 0)*ISNULL(AT9000.Quantity, 0)*ISNULL(A27.ExchangeRate, 1), 0) ELSE 0 END) AS PrimeConvertAmountPromo,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ISNULL(AT9000.ConvertedAmount, 0) ELSE 0 END) AS ConvertedAmountPromo,
			-1*(CASE WHEN ISNULL(AT9000.IsProInventoryID, 0) = 1 THEN ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0) ELSE 0 END) AS VATConvertedAmountPromo
'
			
SET @sSQL4 = '					
FROM		AT9000 WITH(NOLOCK)
LEFT JOIN	AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
LEFT JOIN	AT1301 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1301.DivisionID,''@@@'') AND AT1302.InventoryTypeID = AT1301.InventoryTypeID 
LEFT JOIN	AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN	AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1302.I03ID = AT1015.AnaID AND AT1015.AnaTypeID = ''I03''
LEFT JOIN	AT9000 A90 WITH (NOLOCK) ON A90.DivisionID = AT9000.DivisionID AND A90.VoucherID = AT9000.ReVoucherID AND A90.TransactionID = AT9000.ReTransactionID
LEFT JOIN	OT2001 WITH (NOLOCK) ON A90.DivisionID = OT2001.DivisionID AND A90.OrderID = OT2001.SOrderID
LEFT JOIN	AT2007 A27 WITH (NOLOCK) ON A27.DivisionID = AT9000.DivisionID AND A27.VoucherID = AT9000.VoucherID AND A27.TransactionID = AT9000.TransactionID
LEFT JOIN	OT1002 O01 WITH (NOLOCK) ON OT2001.DivisionID = O01.DivisionID AND O01.AnaID = OT2001.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN	OT1002 O02 WITH (NOLOCK) ON OT2001.DivisionID = O02.DivisionID AND O02.AnaID = OT2001.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN	OT1002 O03 WITH (NOLOCK) ON OT2001.DivisionID = O03.DivisionID AND O03.AnaID = OT2001.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN	OT1002 O04 WITH (NOLOCK) ON OT2001.DivisionID = O04.DivisionID AND O04.AnaID = OT2001.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN	OT1002 O05 WITH (NOLOCK) ON OT2001.DivisionID = O05.DivisionID AND O05.AnaID = OT2001.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN	AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
WHERE		AT9000.DivisionID = '''+@DivisionID+'''			
			AND AT9000.TransactionTypeID = ''T24''' + @sWhere2 + @sWhere + '
'


--SET @sSQL3 = '
--SELECT * FROM #TEMP1
--select * from #TEMP2
--'

-- 1. Nhóm theo SP – Chi tiết đối tượng
IF @Mode = 1
BEGIN
SET @sSQL5 = '
SELECT #TEMP1.InventoryTypeID AS GroupID, #TEMP1.InventoryTypeName AS GroupName, #TEMP1.I03ID AS SubGroupID, #TEMP1.I03ID_AnaName AS SubGroupName, #TEMP1.ObjectID AS GroupDetailID, #TEMP1.ObjectName AS GroupDetailName,
NULL AS UnitID, NULL AS UnitName, #TEMP1.DParameter03, SUM(#TEMP1.Quantity) AS Quantity, SUM(#TEMP1.PrimeConvertAmount) AS PrimeConvertAmount, 
SUM(#TEMP1.ConvertedAmount) AS ConvertedAmount, SUM(#TEMP1.VATConvertedAmount) AS VATConvertedAmount,
SUM(#TEMP1.DiscountAmount) AS DiscountAmount, SUM(#TEMP1.DiscountSalesAmount) AS DiscountSalesAmount, SUM(#TEMP1.QuantityPromo) AS QuantityPromo, 
SUM(#TEMP1.PrimeConvertAmountPromo) AS PrimeConvertAmountPromo, SUM(#TEMP1.ConvertedAmountPromo) AS ConvertedAmountPromo, SUM(#TEMP1.VATConvertedAmountPromo) AS VATConvertedAmountPromo
FROM #TEMP1	
GROUP BY #TEMP1.InventoryTypeID, #TEMP1.InventoryTypeName, #TEMP1.I03ID, #TEMP1.I03ID_AnaName, #TEMP1.ObjectID, #TEMP1.ObjectName, #TEMP1.DParameter03 
'	
END
ELSE
-- 2. Nhóm theo đối tượng – chi tiết SP
IF @Mode = 2
BEGIN
SET @sSQL5 = '
SELECT #TEMP1.ObjectID AS GroupID, #TEMP1.ObjectName AS GroupName, #TEMP1.InventoryID AS GroupDetailID, #TEMP1.InventoryName AS GroupDetailName,
#TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.DParameter03, SUM(#TEMP1.Quantity) AS Quantity, SUM(#TEMP1.PrimeConvertAmount) AS PrimeConvertAmount, 
SUM(#TEMP1.ConvertedAmount) AS ConvertedAmount, SUM(#TEMP1.VATConvertedAmount) AS VATConvertedAmount,
SUM(#TEMP1.DiscountAmount) AS DiscountAmount, SUM(#TEMP1.DiscountSalesAmount) AS DiscountSalesAmount, SUM(#TEMP1.QuantityPromo) AS QuantityPromo, 
SUM(#TEMP1.PrimeConvertAmountPromo) AS PrimeConvertAmountPromo, SUM(#TEMP1.ConvertedAmountPromo) AS ConvertedAmountPromo, SUM(#TEMP1.VATConvertedAmountPromo) AS VATConvertedAmountPromo
FROM #TEMP1	 
GROUP BY #TEMP1.ObjectID, #TEMP1.ObjectName, #TEMP1.InventoryID, #TEMP1.InventoryName, #TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.DParameter03 
'		
END
ELSE
-- 3. Nhóm theo nhân viên –chi tiết SP	
IF @Mode = 3
BEGIN
SET @sSQL5 = '
SELECT #TEMP1.Ana01ID AS GroupID, #TEMP1.AnaName01 AS GroupName, #TEMP1.InventoryID AS GroupDetailID, #TEMP1.InventoryName AS GroupDetailName,
#TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.DParameter03, SUM(#TEMP1.Quantity) AS Quantity, SUM(#TEMP1.PrimeConvertAmount) AS PrimeConvertAmount, 
SUM(#TEMP1.ConvertedAmount) AS ConvertedAmount, SUM(#TEMP1.VATConvertedAmount) AS VATConvertedAmount,
SUM(#TEMP1.DiscountAmount) AS DiscountAmount, SUM(#TEMP1.DiscountSalesAmount) AS DiscountSalesAmount, SUM(#TEMP1.QuantityPromo) AS QuantityPromo, 
SUM(#TEMP1.PrimeConvertAmountPromo) AS PrimeConvertAmountPromo, SUM(#TEMP1.ConvertedAmountPromo) AS ConvertedAmountPromo, SUM(#TEMP1.VATConvertedAmountPromo) AS VATConvertedAmountPromo
FROM #TEMP1	 
GROUP BY #TEMP1.Ana01ID, #TEMP1.AnaName01, #TEMP1.InventoryID, #TEMP1.InventoryName, #TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.DParameter03 
'	
END
ELSE
-- 4. Nhóm theo nhân viên –chi tiết đối tượng
IF @Mode = 4
BEGIN
SET @sSQL5 = '
SELECT #TEMP1.Ana01ID AS GroupID, #TEMP1.AnaName01 AS GroupName, #TEMP1.ObjectID AS GroupDetailID, #TEMP1.ObjectName AS GroupDetailName,
NULL AS UnitID, NULL AS UnitName, #TEMP1.DParameter03, SUM(#TEMP1.Quantity) AS Quantity, SUM(#TEMP1.PrimeConvertAmount) AS PrimeConvertAmount, 
SUM(#TEMP1.ConvertedAmount) AS ConvertedAmount, SUM(#TEMP1.VATConvertedAmount) AS VATConvertedAmount,
SUM(#TEMP1.DiscountAmount) AS DiscountAmount, SUM(#TEMP1.DiscountSalesAmount) AS DiscountSalesAmount, SUM(#TEMP1.QuantityPromo) AS QuantityPromo, 
SUM(#TEMP1.PrimeConvertAmountPromo) AS PrimeConvertAmountPromo, SUM(#TEMP1.ConvertedAmountPromo) AS ConvertedAmountPromo, SUM(#TEMP1.VATConvertedAmountPromo) AS VATConvertedAmountPromo
FROM #TEMP1	
GROUP BY #TEMP1.Ana01ID, #TEMP1.AnaName01, #TEMP1.ObjectID, #TEMP1.ObjectName, #TEMP1.DParameter03 
'		
END
 

		
print @sSQL1
print @sSQL2
print @sSQL3
print @sSQL4
print @sSQL5
EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
							