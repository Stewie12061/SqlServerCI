IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0051_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0051_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
















--- Created by Hải Long on 08/06/2016: Báo cáo tổng hợp doanh số NPP tổng hợp (CustomizeIndex = 57 ---- ANGEL)
--- Update by Huỳnh Thử on 27/07/2020: thêm tỉ lệ chiết khấu(SalesQuarter) vào cách tính % Doanh số. Không bỏ vào Ana03->Ana05
--- Update by Nhật Thanh on 25/01/2022: Bổ sung divisionID dùng chung khi join bảng
--- Modified by Nhật Thanh on 13/04/2022: Bổ sung điều kiện DivisionID khi lấy dữ liệu từ AT0161
/*
	exec AP0051	@DivisionID = 'ANG', @FromPeriod = 201601, @ToPeriod = 201601, @FromDate = '01/01/2016', @ToDate = '01/31/2016',
	@FromArea = 'HCM', @ToArea = 'MT', @FromInventoryTypeID = 'BB', @ToInventoryTypeID = 'XK', @FromObjectID = '00022', @ToObjectID = 'XOABO',
	@FromAna05ID = '00301', @ToAna05ID = 'NO005', @TimeMode = 0
 */
 

CREATE PROCEDURE [dbo].[AP0051_AG] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromArea NVARCHAR(50),
	@ToArea NVARCHAR(50),
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@FromAna02ID NVARCHAR(50),
	@ToAna02ID NVARCHAR(50),
	@FromAna03ID NVARCHAR(50),
	@ToAna03ID NVARCHAR(50),
	@FromAna04ID NVARCHAR(50),
	@ToAna04ID NVARCHAR(50),
	@FromAna05ID NVARCHAR(50),
	@ToAna05ID NVARCHAR(50),
	@TimeMode TINYINT,
	@Mode TINYINT -- 0: Đã khai báo target
				  -- 1: Chưa khai báo tagert
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
	IF @Mode = 0
		SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, #TEMP22.FromDate)*100 + DATEPART(month, #TEMP22.FromDate) AND DATEPART(year, #TEMP22.ToDate)*100 + DATEPART(month, #TEMP22.ToDate)'
	IF @Mode = 1
		SET @sWhere2 = @sWhere2 + 'AND #TEMP1.TranMonth + #TEMP1.TranYear * 100 BETWEEN DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate)'
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),@FromPeriod)+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+CONVERT(NVARCHAR(10),@ToPeriod)												
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + 'And (OT2001.OrderDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'
	--SET @sWhere2 = @sWhere2 + 'AND #TEMP1.OrderDate BETWEEN AT0161.FromDate AND AT0161.ToDate'
	SET @sWhere3 = @sWhere3 + 'AND DATEPART(year, AT0161.FromDate)*100 + DATEPART(month, AT0161.FromDate) >= '+Convert(Nvarchar(10),DATEPART(year,@FromDate)*100 + DATEPART(month,@FromDate))+' AND DATEPART(year, AT0161.ToDate)*100 + DATEPART(month, AT0161.ToDate) <= '+Convert(Nvarchar(10),DATEPART(year,@ToDate)*100 + DATEPART(month,@ToDate))+''										
END	

IF @Mode = 0
BEGIN
	------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID,-- OT2001.OrderDate, 
	OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,  --AT1302.I04ID,     
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT,   
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,    
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in (''@@@'',OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',OT2001.DivisionID) AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND AT1302.I08ID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND OT2001.Ana05ID BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		  AND OT2001.Ana04ID BETWEEN '''+@FromAna04ID+''' AND '''+@ToAna04ID+'''
		  AND OT2001.Ana03ID BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  AND OT2001.Ana02ID BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, --OT2001.OrderDate, 
	OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,  --AT1302.I04ID,
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT AT0161.DivisionID, AT0161.ObjectID, AT0161.FromDate, AT0161.ToDate,
	SUM(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02,
	(ISNULL(AT0161.SalesQuarter,0)) AS SalesQuarter,
	AT0161.SOAna01ID, AT0161.SOAna02ID, AT0161.SOAna03ID,AT0161.SOAna04ID, AT0161.SOAna05ID, 
	AT0161.InventoryTypeID
	INTO #TEMP22
	FROM AT0161 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',AT0161.DivisionID) AND AT1202.ObjectID = AT0161.ObjectID
	WHERE AT0161.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND AT0161.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND AT0161.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND AT0161.SOAna05ID BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		  AND AT0161.SOAna04ID BETWEEN '''+@FromAna04ID+''' AND '''+@ToAna04ID+'''
		  AND AT0161.SOAna03ID BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  AND AT0161.SOAna02ID BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''
	'+@sWhere3+'
	GROUP BY AT0161.DivisionID, AT0161.ObjectID, AT0161.FromDate, AT0161.ToDate, 
	AT0161.SOAna01ID, AT0161.SOAna02ID, AT0161.SOAna03ID,AT0161.SOAna04ID, AT0161.SOAna05ID, 
	AT0161.InventoryTypeID,AT0161.SalesQuarter

	SELECT ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID) AS DivisionID, ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID) AS ObjectID, 
	AT1202.Note AS ObjectName, MAX(ISNULL(#TEMP22.SalesMonth02,0)) AS SalesMonth02,MAX(ISNULL(#TEMP22.SalesQuarter,0)) AS SalesQuarter,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT2,0)) AS ConvertedAmountAfterVAT2,
	ISNULL(#TEMP22.SOAna01ID, #TEMP1.Ana01ID) AS Ana01ID, ISNULL(#TEMP22.SOAna02ID, #TEMP1.Ana02ID) AS Ana02ID, ISNULL(#TEMP22.SOAna03ID, #TEMP1.Ana03ID) AS Ana03ID, 
	ISNULL(#TEMP22.SOAna04ID, #TEMP1.Ana04ID) AS Ana04ID, ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID) AS Ana05ID, 
	ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID) AS InventoryTypeID
	INTO #TEMP2
	FROM #TEMP22
	LEFT JOIN #TEMP1 ON #TEMP22.DivisionID in (''@@@'',#TEMP1.DivisionID) AND #TEMP22.InventoryTypeID = #TEMP1.I08ID AND #TEMP22.ObjectID = #TEMP1.ObjectID 
	AND #TEMP22.SOAna01ID = #TEMP1.Ana01ID AND #TEMP22.SOAna02ID = #TEMP1.Ana02ID AND #TEMP22.SOAna03ID = #TEMP1.Ana03ID 
	AND #TEMP22.SOAna04ID = #TEMP1.Ana04ID AND #TEMP22.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID)) AND AT1202.ObjectID = ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID)
	WHERE ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID) BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID) BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID) BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
	GROUP BY ISNULL(#TEMP22.DivisionID, #TEMP1.DivisionID), ISNULL(#TEMP22.ObjectID, #TEMP1.ObjectID), AT1202.Note, 
	ISNULL(#TEMP22.SOAna01ID, #TEMP1.Ana01ID), ISNULL(#TEMP22.SOAna02ID, #TEMP1.Ana02ID), ISNULL(#TEMP22.SOAna03ID, #TEMP1.Ana03ID), 
	ISNULL(#TEMP22.SOAna04ID, #TEMP1.Ana04ID), ISNULL(#TEMP22.SOAna05ID, #TEMP1.Ana05ID),
	ISNULL(#TEMP22.InventoryTypeID, #TEMP1.I08ID)
	'

END
ELSE
BEGIN
	------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,        
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT,   
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,    
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in (''@@@'',OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',OT2001.DivisionID) AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND ISNULL(AT1302.I08ID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
		  AND ISNULL(OT2001.ObjectID,'''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(OT2001.Ana05ID,'''') BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		  --AND ISNULL(OT2001.Ana04ID,'''') BETWEEN '''+@FromAna04ID+''' AND '''+@ToAna04ID+'''
		  --AND ISNULL(OT2001.Ana03ID,'''') BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  --AND ISNULL(OT2001.Ana02ID,'''') BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note AS ObjectName, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02,MAX(ISNULL(AT0161.SalesQuarter,0)) AS SalesQuarter,
	SUM(#TEMP1.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP1.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID AS InventoryTypeID
	INTO #TEMP2
	FROM #TEMP1
	LEFT JOIN AT0161 WITH (NOLOCK) ON AT0161.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT1202.ObjectID = #TEMP1.ObjectID
	WHERE AT0161.DivisionID IS NULL 
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note, #TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID
	'
END

SET @sSQL2 = '
	SELECT #TEMP2.ObjectID, #TEMP2.ObjectName, SUM(ISNULL(#TEMP2.SalesMonth02,0)) AS SalesMonth02, (ISNULL(#TEMP2.SalesQuarter,0)) AS SalesQuarter,
	SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
	#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
	#TEMP2.Ana02ID, O02.AnaName as AnaName02, O07.UserName as UserName02
	FROM #TEMP2
	LEFT JOIN AT1015 ON AT1015.DivisionID = #TEMP2.DivisionID AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
	LEFT JOIN OT1002 O02 ON #TEMP2.DivisionID = O02.DivisionID AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
	LEFT JOIN OT1005 O07 ON O07.DivisionID in (''@@@'',#TEMP2.DivisionID) AND O07.AnaTypeID LIKE ''S02''
	GROUP BY #TEMP2.Ana02ID, AT1015.AnaName, O02.AnaName, O07.UserName, #TEMP2.ObjectID, #TEMP2.ObjectName, #TEMP2.InventoryTypeID, AT1015.AnaName, #TEMP2.SalesQuarter
	ORDER BY #TEMP2.InventoryTypeID, #TEMP2.Ana02ID
	'

SET @sSQL3 = '
SELECT #TEMP2.Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, 
O03.AnaName as AnaName03, NULL as AnaName04, NULL as AnaName05,  
O08.UserName as UserName03, NULL as UserName04, NULL as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O03 ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1005 O08 ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S03''
LEFT JOIN AT1015 ON AT1015.DivisionID = #TEMP2.DivisionID AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana03ID, O03.AnaName, O08.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName
UNION ALL
SELECT NULL AS Ana03ID, #TEMP2.Ana04ID AS Ana04ID, NULL AS Ana05ID, 
NULL as AnaName03, O04.AnaName as AnaName04, NULL as AnaName05,  
NULL as UserName03, O09.UserName as UserName04, NULL as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O04 ON #TEMP2.DivisionID = O04.DivisionID AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1005 O09 ON O09.DivisionID = #TEMP2.DivisionID AND O09.AnaTypeID LIKE ''S04''
LEFT JOIN AT1015 ON AT1015.DivisionID = #TEMP2.DivisionID AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana04ID, O04.AnaName, O09.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName
UNION ALL
SELECT NULL AS Ana03ID, NULL AS Ana04ID, #TEMP2.Ana05ID,
NULL as AnaName03, NULL as AnaName04, O05.AnaName as AnaName05,  
NULL as UserName03, NULL as UserName04, O10.UserName as UserName05, #TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
SUM(#TEMP2.SalesMonth02) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O05 ON #TEMP2.DivisionID = O05.DivisionID AND O05.AnaID = #TEMP2.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN OT1005 O10 ON O10.DivisionID = #TEMP2.DivisionID AND O10.AnaTypeID LIKE ''S05''
LEFT JOIN AT1015 ON AT1015.DivisionID = #TEMP2.DivisionID AND AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana05ID, O05.AnaName, O10.UserName, #TEMP2.InventoryTypeID, AT1015.AnaName
ORDER BY Ana03ID DESC, Ana04ID DESC, Ana05ID DESC
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
