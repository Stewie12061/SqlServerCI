IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0350]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0350]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Ti?u Mai on 08/06/2016: In báo cáo d?c thù ANG_OR0083 (CustomizeIndex = 57 ---- ANGEL)
--- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Nhật Thanh on 13/04/2022: Bổ sung điều kiện DivisionID khi lấy dữ liệu từ AT0161
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
	exec AP0350 @DivisionID = 'ANG', @FromPeriod = 201701, @ToPeriod = 201701, @FromDate = '01/01/2016', @ToDate = '01/31/2016', @FromArea = 'HCM', @ToArea = 'MT',
	@InventoryTypeID = 'NH21', @FromObjectID = '00022', @ToObjectID = 'XOABO', @FromAna03ID = '00318', @ToAna03ID = 'NO003', @FromAna05ID = '00301', @ToAna05ID = 'NO005',
	@TimeMode = 0, @Mode = 1
 */
 

CREATE PROCEDURE [dbo].[AP0350] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromArea NVARCHAR(50),
	@ToArea NVARCHAR(50),
	@InventoryTypeID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@FromAna03ID NVARCHAR(50),
	@ToAna03ID NVARCHAR(50),
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
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT, 
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,   
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  ' + @sWhere +'
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, 
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT ISNULL(AT0161.DivisionID, #TEMP1.DivisionID) AS DivisionID, ISNULL(AT0161.ObjectID, #TEMP1.ObjectID) AS ObjectID, 
	AT1202.Note AS ObjectName, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth,
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
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND ISNULL(AT0161.InventoryTypeID, #TEMP1.I08ID) LIKE '''+@InventoryTypeID+'''
		  AND ISNULL(AT0161.ObjectID, #TEMP1.ObjectID) BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(AT0161.SOAna03ID, #TEMP1.Ana03ID) BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  AND ISNULL(AT0161.SOAna05ID, #TEMP1.Ana05ID) BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		  '+@sWhere3+'
	GROUP BY ISNULL(AT0161.DivisionID, #TEMP1.DivisionID), ISNULL(AT0161.ObjectID, #TEMP1.ObjectID), AT1202.Note, 
	ISNULL(AT0161.SOAna01ID, #TEMP1.Ana01ID), ISNULL(AT0161.SOAna02ID, #TEMP1.Ana02ID), ISNULL(AT0161.SOAna03ID, #TEMP1.Ana03ID), ISNULL(AT0161.SOAna04ID, #TEMP1.Ana04ID), ISNULL(AT0161.SOAna05ID, #TEMP1.Ana05ID),
	ISNULL(AT0161.InventoryTypeID, #TEMP1.I08ID)
	'

END
ELSE
BEGIN
	------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
	SET @sSQL = '
	SELECT OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID,            
		   SUM(ISNULL(OT2002.ConvertedAmount, 0)) AS ConvertedAmountAfterVAT, 
		   SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)) AS ConvertedAmountAfterVAT2,   
		   OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	INTO #TEMP1		
	FROM OT2002 WITH (NOLOCK)
	LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	WHERE OT2002.DivisionID = '''+@DivisionID+'''
		  AND ISNULL(OT2002.IsProInventoryID,0) <> 1
		  AND ISNULL(OT2001.OrderStatus,0) = 1
		  AND ISNULL(OT2001.OrderType,0) = 0
		  AND ISNULL(AT1202.O01ID,'''') BETWEEN '''+@FromArea+''' AND '''+@ToArea+'''
		  AND ISNULL(AT1302.I08ID,'''') LIKE '''+@InventoryTypeID+'''
		  AND ISNULL(OT2001.ObjectID,'''') BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
		  AND ISNULL(OT2001.Ana03ID,'''') BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''
		  AND ISNULL(OT2001.Ana05ID,'''') BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''
		  AND ISNULL(OT2001.Ana02ID, '''') <> ''''
		  ' + @sWhere +'
	GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, 
			 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
	'

	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note AS ObjectName, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth,
	SUM(#TEMP1.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP1.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID AS InventoryTypeID
	INTO #TEMP2
	FROM #TEMP1
	LEFT JOIN AT0161 WITH (NOLOCK) ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TEMP1.ObjectID
	WHERE AT0161.DivisionID IS NULL 
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.Note, #TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID, #TEMP1.I08ID
	'
END

SET @sSQL2 = '
SELECT #TEMP2.ObjectID, #TEMP2.ObjectName, SUM(ISNULL(#TEMP2.SalesMonth,0)) AS SalesMonth, 
SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2,
#TEMP2.InventoryTypeID, AT1015.AnaName as InventoryTypeName,
#TEMP2.Ana02ID, O02.AnaName as AnaName02, O07.UserName as UserName02
FROM #TEMP2
LEFT JOIN AT1015 ON AT1015.AnaID = #TEMP2.InventoryTypeID AND AT1015.AnaTypeID = ''I08''
LEFT JOIN OT1002 O02 ON #TEMP2.DivisionID = O02.DivisionID AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN OT1005 O07 ON O07.DivisionID = #TEMP2.DivisionID AND O07.AnaTypeID LIKE ''S02''
GROUP BY #TEMP2.Ana02ID, AT1015.AnaName, O02.AnaName, O07.UserName, #TEMP2.ObjectID, #TEMP2.ObjectName, #TEMP2.InventoryTypeID, AT1015.AnaName
ORDER BY #TEMP2.InventoryTypeID, #TEMP2.Ana02ID
'

SET @sSQL3 = '
SELECT #TEMP2.Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID,
O03.AnaName as AnaName03, NULL as AnaName04, NULL as AnaName05,  
O08.UserName as UserName03, NULL as UserName04, NULL as UserName05,
SUM(#TEMP2.SalesMonth) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O03 ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1005 O08 ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S03''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana03ID, O03.AnaName, O08.UserName
UNION ALL
SELECT NULL AS Ana03ID, #TEMP2.Ana04ID AS Ana04ID, NULL AS Ana05ID,
NULL as AnaName03, O04.AnaName as AnaName04, NULL as AnaName05,  
NULL as UserName03, O09.UserName as UserName04, NULL as UserName05,
SUM(#TEMP2.SalesMonth) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O04 ON #TEMP2.DivisionID = O04.DivisionID AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1005 O09 ON O09.DivisionID = #TEMP2.DivisionID AND O09.AnaTypeID LIKE ''S04''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana04ID, O04.AnaName, O09.UserName
UNION ALL
SELECT NULL AS Ana03ID, NULL AS Ana04ID, #TEMP2.Ana05ID,
NULL as AnaName03, NULL as AnaName04, O05.AnaName as AnaName05,  
NULL as UserName03, NULL as UserName04, O10.UserName as UserName05,
SUM(#TEMP2.SalesMonth) AS SalesMonth, SUM(#TEMP2.ConvertedAmountAfterVAT) AS ConvertedAmountAfterVAT, SUM(#TEMP2.ConvertedAmountAfterVAT2) AS ConvertedAmountAfterVAT2
FROM #TEMP2
LEFT JOIN OT1002 O05 ON #TEMP2.DivisionID = O05.DivisionID AND O05.AnaID = #TEMP2.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN OT1005 O10 ON O10.DivisionID = #TEMP2.DivisionID AND O10.AnaTypeID LIKE ''S05''
WHERE #TEMP2.Ana03ID IS NOT NULL
GROUP BY #TEMP2.Ana05ID, O05.AnaName, O10.UserName
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
