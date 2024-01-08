IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0344]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0344]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Hải Long on 08/06/2016: In báo cáo tổng hợp doanh số đặt hàng
--- Modified by Tiểu Mai on 06/02/2017: Bổ sung điều kiện lọc MPT mặt hàng 04
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * exec AP0344 'ANG', 201603, 201603, '06/01/2016', '11/30/2016', '00022', 'XOABO', 'BBCN01', 'XOABO', 'BB01', 'TT01', 0
 */

CREATE PROCEDURE [dbo].[AP0344] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@FromInventory NVARCHAR(50),
	@ToInventory NVARCHAR(50),
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50),
	@FromI04ID NVARCHAR(50),
	@ToI04ID NVARCHAR(50),	
	@TimeMode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = '',
		@sWhere2 NVARCHAR(MAX) = '',
		@sWhere3 NVARCHAR(MAX) = ''
		
IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN ' + Convert(Nvarchar(10),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(10),@ToPeriod)	   	 		   
	SET @sWhere2 = @sWhere2 + '																   	 		   
	AND OT2001.TranMonth + OT2001.TranYear * 100 < ' + Convert(Nvarchar(10),@FromPeriod)
	SET @sWhere3 = @sWhere3 + '		
	AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN ' + Convert(Nvarchar(10),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(10),@ToPeriod)
END
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND AT9000.VoucherDate  BETWEEN ''' + Convert(nvarchar(10),@FromDate,21) + ''' AND ''' + convert(nvarchar(10), @ToDate,21) + ''''
	SET @sWhere2 = @sWhere2 + '
	AND OT2001.OrderDate  < ''' + Convert(nvarchar(10),@FromDate,21) + ''''	
	SET @sWhere3 = @sWhere3 + '		
	AND OT2001.OrderDate  BETWEEN ''' + Convert(nvarchar(10),@FromDate,21) + ''' AND ''' + convert(nvarchar(10), @ToDate,21) + ''''
END	
		

SET @sSQL = '
SELECT		AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,
			SUM(ISNULL(AT9000.ConvertedAmount, 0)) AS ConvertedAmount1,
			SUM(ISNULL(AT9000.DiscountAmount, 0)) AS DiscountAmount1,
			SUM(ISNULL(AT9000.DiscountSaleAmountDetail, 0)) AS DiscountSalesAmount1,
			SUM(ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0)) AS VATConvertedAmount1
INTO #TEMP1									
FROM		AT9000 WITH (NOLOCK)
LEFT JOIN	AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN	AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
INNER JOIN	OT2001 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.OrderID = OT2001.SOrderID
LEFT JOIN	OT1002 O01 WITH (NOLOCK) ON OT2001.DivisionID = O01.DivisionID AND O01.AnaID = OT2001.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN	OT1002 O02 WITH (NOLOCK) ON OT2001.DivisionID = O02.DivisionID AND O02.AnaID = OT2001.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN	OT1002 O03 WITH (NOLOCK) ON OT2001.DivisionID = O03.DivisionID AND O03.AnaID = OT2001.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN	OT1002 O04 WITH (NOLOCK) ON OT2001.DivisionID = O04.DivisionID AND O04.AnaID = OT2001.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN	OT1002 O05 WITH (NOLOCK) ON OT2001.DivisionID = O05.DivisionID AND O05.AnaID = OT2001.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
WHERE		AT9000.DivisionID = '''+@DivisionID+'''
			AND AT9000.TransactionTypeID IN (''T04'', ''T40'')
			--AND ISNULL(AT9000.IsProInventoryID,0) <> 1
			AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + '''
			AND ISNULL(AT9000.InventoryID,'''') BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+'''
			AND ISNULL(AT1302.I08ID, '''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
			AND ISNULL(AT1302.I04ID, '''') BETWEEN '''+@FromI04ID+''' AND '''+@ToI04ID+'''' + @sWhere + @sWhere2 + '
GROUP BY    AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName, O02.AnaName, O03.AnaName, O04.AnaName, O05.AnaName
'	

SET @sSQL1 = '
UNION ALL
SELECT AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,
			SUM(ISNULL(AT9000.ConvertedAmount, 0))*-1 AS ConvertedAmount1,
			SUM(ISNULL(AT9000.DiscountAmount, 0))*-1 AS DiscountAmount1,
			SUM(ISNULL(AT9000.DiscountSaleAmountDetail, 0))*-1 AS DiscountSalesAmount1,
			SUM(ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0))*-1 AS VATConvertedAmount1
FROM AT9000 WITH (NOLOCK)
LEFT JOIN	AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN	AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN	AT9000 A90 WITH (NOLOCK) ON AT9000.DivisionID = A90.DivisionID AND AT9000.VoucherID = A90.ReVoucherID
LEFT JOIN	OT2001 WITH (NOLOCK) ON AT1302.DivisionID IN (A90.DivisionID,''@@@'') AND A90.OrderID = OT2001.SOrderID
LEFT JOIN	OT1002 O01 WITH (NOLOCK) ON OT2001.DivisionID = O01.DivisionID AND O01.AnaID = OT2001.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN	OT1002 O02 WITH (NOLOCK) ON OT2001.DivisionID = O02.DivisionID AND O02.AnaID = OT2001.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN	OT1002 O03 WITH (NOLOCK) ON OT2001.DivisionID = O03.DivisionID AND O03.AnaID = OT2001.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN	OT1002 O04 WITH (NOLOCK) ON OT2001.DivisionID = O04.DivisionID AND O04.AnaID = OT2001.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN	OT1002 O05 WITH (NOLOCK) ON OT2001.DivisionID = O05.DivisionID AND O05.AnaID = OT2001.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
WHERE		AT9000.DivisionID = '''+@DivisionID+'''
			AND AT9000.TransactionTypeID = ''T24''
			AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + '''
			AND ISNULL(AT9000.InventoryID,'''') BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+'''
			AND ISNULL(AT1302.I08ID, '''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
			AND ISNULL(AT1302.I04ID, '''') BETWEEN '''+@FromI04ID+''' AND '''+@ToI04ID+'''' + @sWhere +'
GROUP BY    AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName, O02.AnaName, O03.AnaName, O04.AnaName, O05.AnaName
'	 		 

SET @sSQL2 = '		 		 
SELECT		AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,
			SUM(ISNULL(AT9000.ConvertedAmount, 0)) AS ConvertedAmount2,
			SUM(ISNULL(AT9000.DiscountAmount, 0)) AS DiscountAmount2,
			SUM(ISNULL(AT9000.DiscountSaleAmountDetail, 0)) AS DiscountSalesAmount2,
			SUM(ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0)) AS VATConvertedAmount2
INTO #TEMP2									
FROM		AT9000 WITH (NOLOCK)
LEFT JOIN	AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN	AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID
INNER JOIN	OT2001 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.OrderID = OT2001.SOrderID ' + @sWhere3 + '
LEFT JOIN	OT1002 O01 WITH (NOLOCK) ON OT2001.DivisionID = O01.DivisionID AND O01.AnaID = OT2001.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN	OT1002 O02 WITH (NOLOCK) ON OT2001.DivisionID = O02.DivisionID AND O02.AnaID = OT2001.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN	OT1002 O03 WITH (NOLOCK) ON OT2001.DivisionID = O03.DivisionID AND O03.AnaID = OT2001.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN	OT1002 O04 WITH (NOLOCK) ON OT2001.DivisionID = O04.DivisionID AND O04.AnaID = OT2001.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN	OT1002 O05 WITH (NOLOCK) ON OT2001.DivisionID = O05.DivisionID AND O05.AnaID = OT2001.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
WHERE		AT9000.DivisionID = '''+@DivisionID+'''
			AND AT9000.TransactionTypeID IN (''T04'', ''T40'')
			--AND ISNULL(AT9000.IsProInventoryID,0) <> 1
			AND ISNULL(AT9000.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + '''
			AND ISNULL(AT9000.InventoryID,'''') BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+'''
			AND ISNULL(AT1302.I08ID, '''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
			AND ISNULL(AT1302.I04ID, '''') BETWEEN '''+@FromI04ID+''' AND '''+@ToI04ID+'''' + @sWhere + '
GROUP BY    AT9000.DivisionID, AT9000.ObjectID, AT1202.ObjectName,
			OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID,
			O01.AnaName, O02.AnaName, O03.AnaName, O04.AnaName, O05.AnaName
'

SET @sSQL3 = '		
SELECT ISNULL(#TEMP1.DivisionID, #TEMP2.DivisionID) AS DivisionID, ISNULL(#TEMP1.ObjectID, #TEMP2.ObjectID) AS ObjectID, ISNULL(#TEMP1.ObjectName, #TEMP2.ObjectName) AS ObjectName, 
ISNULL(#TEMP1.Ana01ID, #TEMP2.Ana01ID) AS Ana01ID, ISNULL(#TEMP1.Ana02ID, #TEMP2.Ana02ID) AS Ana02ID, ISNULL(#TEMP1.Ana03ID, #TEMP2.Ana03ID) AS Ana03ID, 
ISNULL(#TEMP1.Ana04ID, #TEMP2.Ana04ID) AS Ana04ID, ISNULL(#TEMP1.Ana05ID, #TEMP2.Ana05ID) AS Ana05ID, 
ISNULL(#TEMP1.AnaName01, #TEMP2.AnaName01) AS AnaName01, ISNULL(#TEMP1.AnaName02, #TEMP2.AnaName02) AS AnaName02, ISNULL(#TEMP1.AnaName03, #TEMP2.AnaName03) AS AnaName03, 
ISNULL(#TEMP1.AnaName04, #TEMP2.AnaName04) AS AnaName04, ISNULL(#TEMP1.AnaName05, #TEMP2.AnaName05) AS AnaName05, 
#TEMP1.ConvertedAmount1, #TEMP1.DiscountAmount1, #TEMP1.DiscountSalesAmount1, #TEMP1.VATConvertedAmount1, 
#TEMP2.ConvertedAmount2, #TEMP2.DiscountAmount2, #TEMP2.DiscountSalesAmount2, #TEMP2.VATConvertedAmount2 
FROM #TEMP1
FULL JOIN #TEMP2 ON ISNULL(#TEMP1.DivisionID, '''') = ISNULL(#TEMP2.DivisionID, '''') AND ISNULL(#TEMP1.ObjectID, '''') = ISNULL(#TEMP2.ObjectID, '''')	 
				 AND ISNULL(#TEMP1.Ana01ID, '''') = ISNULL(#TEMP2.Ana01ID, '''') AND ISNULL(#TEMP1.Ana02ID, '''') = ISNULL(#TEMP2.Ana02ID, '''')
				 AND ISNULL(#TEMP1.Ana03ID, '''') = ISNULL(#TEMP2.Ana03ID, '''') AND ISNULL(#TEMP1.Ana04ID, '''') = ISNULL(#TEMP2.Ana04ID, '''')
				 AND ISNULL(#TEMP1.Ana05ID, '''') = ISNULL(#TEMP2.Ana05ID, '''') 	 	 
ORDER BY ISNULL(#TEMP1.Ana01ID, #TEMP2.Ana01ID), ISNULL(#TEMP1.Ana02ID, #TEMP2.Ana02ID), ISNULL(#TEMP1.Ana03ID, #TEMP2.Ana03ID),
ISNULL(#TEMP1.Ana04ID, #TEMP2.Ana04ID), ISNULL(#TEMP1.Ana05ID, #TEMP2.Ana05ID), ISNULL(#TEMP1.ObjectID, #TEMP2.ObjectID)			 
'
				 			 
PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO				 			 