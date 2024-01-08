IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Tiểu Mai on 08/06/2016: In báo cáo d?c thù ANG_OR0083 (CustomizeIndex = 57 ---- ANGEL)
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhật Thanh on 13/04/2022: Bổ sung điều kiện DivisionID khi lấy dữ liệu từ AT0161
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
exec OP0082 @DivisionID = 'ANG', @FromPeriod = 201701, @ToPeriod = 201701, @FromDate = '01/01/2016', @ToDate = '01/31/2016', 
@FromObjectID = '00022', @ToObjectID = 'XOABO', @FromInventoryTypeID = 'BB', @ToInventoryTypeID = 'XK', @FromO01ID = 'HCM', @ToO01ID = 'MT', @TimeMode = 0
 */
 

CREATE PROCEDURE [dbo].[OP0082] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50),
	@FromO01ID NVARCHAR(50),
	@ToO01ID NVARCHAR(50),
	@FromAna03ID NVARCHAR(50),
	@ToAna03ID NVARCHAR(50),
	@TimeMode TINYINT,
	@Mode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),		
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),
		@sWhere3 NVARCHAR(MAX)
		
SET @sWhere = ''
SET @sWhere2 = ''
SET @sWhere3 = ''

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + 'AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)
	SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate)'
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),@FromPeriod)+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+CONVERT(NVARCHAR(10),@ToPeriod)									
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + 'And (OT2001.OrderDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'
	SET @sWhere2 = @sWhere2 + 'AND #TEMP1.OrderDate BETWEEN AT0161.FromDate AND AT0161.ToDate'	
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),DATEPART(year,@FromDate)*100 + DATEPART(month,@FromDate))+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+Convert(Nvarchar(10),DATEPART(year,@ToDate)*100 + DATEPART(month,@ToDate))+''							
END	

IF @Mode = 0
BEGIN
------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,            
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2, 
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0) - ISNULL(DiscountSaleAmountDetail, 0) + ISNULL(DiscountConvertedAmount, 0)*(1 + ISNULL(OT2002.VATPercent/100, 0))) AS ConvertedAmountAfterVAT,   
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana01ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, 
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT ISNULL(AT0161.DivisionID, #TEMP1.DivisionID) AS DivisionID, ISNULL(AT0161.ObjectID, #TEMP1.ObjectID) AS ObjectID,
	AT1202.Note AS ObjectName, AT1202.O01ID, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth01,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT2,0)) AS ConvertedAmountAfterVAT2,
	ISNULL(AT0161.SOAna01ID, #TEMP1.Ana01ID) AS Ana01ID, ISNULL(AT0161.SOAna02ID, #TEMP1.Ana02ID) AS Ana02ID, ISNULL(AT0161.SOAna03ID, #TEMP1.Ana03ID) AS Ana03ID, ISNULL(AT0161.SOAna04ID, #TEMP1.Ana04ID) AS Ana04ID, ISNULL(AT0161.SOAna05ID, #TEMP1.Ana05ID) AS Ana05ID, 
	ISNULL(AT0161.InventoryTypeID, #TEMP1.I08ID) AS InventoryTypeID
	INTO #TEMP2
	FROM AT0161 WITH (NOLOCK)
	FULL JOIN #TEMP1 ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = ISNULL(AT0161.ObjectID, #TEMP1.ObjectID)
	WHERE AT0161.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(AT0161.ObjectID, #TEMP1.ObjectID) BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(AT0161.InventoryTypeID, #TEMP1.I08ID) BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+'''
		  AND ISNULL(AT0161.SOAna03ID, #TEMP1.Ana03ID) BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  '+@sWhere3+'
	GROUP BY ISNULL(AT0161.DivisionID, #TEMP1.DivisionID), ISNULL(AT0161.ObjectID, #TEMP1.ObjectID), AT1202.Note, AT1202.O01ID, 
	ISNULL(AT0161.SOAna01ID, #TEMP1.Ana01ID), ISNULL(AT0161.SOAna02ID, #TEMP1.Ana02ID), ISNULL(AT0161.SOAna03ID, #TEMP1.Ana03ID), ISNULL(AT0161.SOAna04ID, #TEMP1.Ana04ID), ISNULL(AT0161.SOAna05ID, #TEMP1.Ana05ID),
	ISNULL(AT0161.InventoryTypeID, #TEMP1.I08ID)
	'
	
END
ELSE
BEGIN
------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,            
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2, 
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0) - ISNULL(DiscountSaleAmountDetail, 0) + ISNULL(DiscountConvertedAmount, 0)*(1 + ISNULL(OT2002.VATPercent/100, 0))) AS ConvertedAmountAfterVAT,   
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(OT2001.ObjectID, '''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(AT1302.I08ID, '''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND ISNULL(AT1202.O01ID, '''') BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+'''
		  AND ISNULL(OT2001.Ana03ID, '''') BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  AND ISNULL(OT2001.Ana01ID, '''') <> ''''
		  ' + @sWhere +'
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, 
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note AS ObjectName, AT1202.O01ID,
	MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth01,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT2,0)) AS ConvertedAmountAfterVAT2,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID AS InventoryTypeID
	INTO #TEMP2
	FROM #TEMP1
	LEFT JOIN AT0161 WITH (NOLOCK) ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TEMP1.ObjectID
	WHERE AT0161.DivisionID IS NULL 
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note, AT1202.O01ID, 
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID
	'
END

SET @sSQL2 = '
SELECT #TEMP2.ObjectID, #TEMP2.O01ID, #TEMP2.ObjectName, SUM(ISNULL(#TEMP2.SalesMonth01,0)) AS SalesMonth01, 
SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
#TEMP2.Ana01ID, #TEMP2.Ana02ID, #TEMP2.Ana04ID, 
O01.AnaName as AnaName01, O02.AnaName as AnaName02, O04.AnaName as AnaName04, 
O06.UserName as UserName01, O07.UserName as UserName02, O09.UserName as UserName04
FROM #TEMP2
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
LEFT JOIN OT1002 O01 WITH (NOLOCK) ON #TEMP2.DivisionID = O01.DivisionID AND O01.AnaID = #TEMP2.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN OT1002 O02 WITH (NOLOCK) ON #TEMP2.DivisionID = O02.DivisionID AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN OT1002 O04 WITH (NOLOCK) ON #TEMP2.DivisionID = O04.DivisionID AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1005 O06 WITH (NOLOCK) ON O06.DivisionID = #TEMP2.DivisionID AND O06.AnaTypeID LIKE ''S01''
LEFT JOIN OT1005 O07 WITH (NOLOCK) ON O07.DivisionID = #TEMP2.DivisionID AND O07.AnaTypeID LIKE ''S02''
LEFT JOIN OT1005 O09 WITH (NOLOCK) ON O09.DivisionID = #TEMP2.DivisionID AND O09.AnaTypeID LIKE ''S04''
GROUP BY #TEMP2.Ana01ID, #TEMP2.Ana02ID, #TEMP2.Ana04ID, AT1015.AnaName, 
O01.AnaName, O02.AnaName, O04.AnaName, O06.UserName, O07.UserName, O09.UserName, 
#TEMP2.ObjectID, #TEMP2.O01ID, #TEMP2.ObjectName, #TEMP2.InventoryTypeID, AT1015.AnaName
ORDER BY #TEMP2.InventoryTypeID, #TEMP2.Ana01ID, #TEMP2.Ana02ID, #TEMP2.Ana04ID
'	

SET @sSQL3 = '
SELECT #TEMP2.Ana03ID, O03.AnaName as AnaName03, O08.UserName as UserName03, #TEMP2.O01ID + '' - '' + O09.AnaName AS O01ID,
#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName, 
SUM(#TEMP2.SalesMonth01) AS SalesMonth01, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
LEFT JOIN OT1002 O03 WITH (NOLOCK) ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1005 O08 WITH (NOLOCK) ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S03''
LEFT JOIN AT1015 O09 WITH (NOLOCK) ON O09.AnaID = #TEMP2.O01ID AND O09.AnaTypeID = ''O01''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana03ID, O03.AnaName, O08.UserName, #TEMP2.O01ID, O09.AnaName, #TEMP2.InventoryTypeID, AT1015.AnaName
UNION ALL
SELECT #TEMP2.Ana05ID AS Ana03ID, O03.AnaName as AnaName03, O08.UserName as UserName03, #TEMP2.O01ID + '' - '' + O09.AnaName AS O01ID,
#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName, 
SUM(#TEMP2.SalesMonth01) AS SalesMonth01, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
LEFT JOIN OT1002 O03 WITH (NOLOCK) ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana05ID AND O03.AnaTypeID = ''S05''
LEFT JOIN OT1005 O08 WITH (NOLOCK) ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S05''
LEFT JOIN AT1015 O09 WITH (NOLOCK) ON O09.AnaID = #TEMP2.O01ID AND O09.AnaTypeID = ''O01''
WHERE #TEMP2.Ana05ID IS NOT NULL
GROUP BY #TEMP2.Ana05ID , O03.AnaName, O08.UserName, #TEMP2.O01ID, O09.AnaName, #TEMP2.InventoryTypeID, AT1015.AnaName
'

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
EXEC (@sSQL+ @sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
