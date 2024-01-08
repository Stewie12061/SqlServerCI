IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by H?i Long on 08/06/2016: Báo cáo t?ng h?p doanh s? theo SKU (CustomizeIndex = 57 ---- ANGEL)
--- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * exec AP0052 'ANG', 201601, 201601, '01/01/2016', '01/31/2016', '', 'KPP.HAG.0001', 'KPP.HYE.0001', 'HMP', 'MPB' , 0
 */

CREATE PROCEDURE [dbo].[AP0052] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromAna01ID NVARCHAR(50),
	@ToAna01ID NVARCHAR(50),
	@FromAna02ID NVARCHAR(50),
	@ToAna02ID NVARCHAR(50),
	@FromAna03ID NVARCHAR(50),
	@ToAna03ID NVARCHAR(50),
	@FromAna04ID NVARCHAR(50),
	@ToAna04ID NVARCHAR(50),
	@FromAna05ID NVARCHAR(50),
	@ToAna05ID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),	
	@ToObjectID NVARCHAR(50),
	@FromI04ID NVARCHAR(50),
	@ToI04ID NVARCHAR(50),
	@TimeMode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),
		@sWhere3 NVARCHAR(MAX),
		@CustomerName int

SET @CustomerName = (Select top 1 CustomerName from CustomerIndex)
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


------ L?y s? lu?ng hàng bán theo MPT don hàng bán		
SET @sSQL = '
SELECT	OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, AT1302.I04ID,   
		SUM(ISNULL(OT2002.ConvertedAmount, 0) + ISNULL(OT2002.VATConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0) - ISNULL(DiscountSaleAmountDetail, 0)) AS ConvertedAmountAfterVAT,
		OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
INTO #TEMP1		
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) <> 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND AT1302.I04ID BETWEEN '''+@FromI04ID+''' AND '''+@ToI04ID+''''
	+ CASE WHEN (@FromAna01ID <> '' OR @ToAna01ID <> '') THEN ' AND ISNULL(OT2001.Ana01ID, '''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''' ELSE '' END  
	+ CASE WHEN (@FromAna02ID <> '' OR @ToAna02ID <> '') THEN ' AND ISNULL(OT2001.Ana02ID, '''') BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''' ELSE '' END  
	+ CASE WHEN (@FromAna03ID <> '' OR @ToAna03ID <> '') THEN ' AND ISNULL(OT2001.Ana03ID, '''') BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''' ELSE '' END
	+ CASE WHEN (@FromAna04ID <> '' OR @ToAna04ID <> '') THEN ' AND ISNULL(OT2001.Ana04ID, '''') BETWEEN '''+@FromAna04ID+''' AND '''+@ToAna04ID+'''' ELSE '' END
	+ CASE WHEN (@FromAna05ID <> '' OR @ToAna05ID <> '') THEN ' AND ISNULL(OT2001.Ana05ID, '''') BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''' ELSE '' END + '
	'+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.OrderDate, OT2001.TranMonth, OT2001.TranYear, OT2001.ObjectID, AT1302.I08ID, AT1302.I04ID,   
		 OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
'	

IF @CustomerName = 57 
	SET @sSQL1 = '
	SELECT ISNULL(#TEMP1.DivisionID,AT0161.DivisionID) AS DivisionID, ISNULL(#TEMP1.ObjectID, AT0161.ObjectID) AS ObjectID,
	ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2) AS I04ID, ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID) AS I08ID,
	MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth01, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth02, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth03, 
	MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth04, MAX(ISNULL(AT0161.Amount,0)) AS SalesMonth05,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, 
	ISNULL(#TEMP1.Ana01ID, AT0161.SOAna01ID) AS Ana01ID, 
	ISNULL(#TEMP1.Ana02ID, AT0161.SOAna02ID) AS Ana02ID, 
	ISNULL(#TEMP1.Ana03ID, AT0161.SOAna03ID) AS Ana03ID, 
	ISNULL(#TEMP1.Ana04ID, AT0161.SOAna04ID) AS Ana04ID, 
	ISNULL(#TEMP1.Ana05ID, AT0161.SOAna05ID) AS Ana05ID
	INTO #TEMP2
	FROM #TEMP1 WITH (NOLOCK)
	FULL JOIN (SELECT DivisionID, SUM(SalesMonth) AS Amount, InventoryTypeID, InventoryTypeID2, ObjectID, 
				SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				DATEPART(month, AT0161.FromDate) AS MonthFromDate, DATEPART(year, AT0161.FromDate) AS YearFromDate,
				DATEPART(month, AT0161.ToDate) AS MonthToDate, DATEPART(year, AT0161.ToDate) AS YearToDate,
				AT0161.FromDate, AT0161.ToDate
				FROM AT0161 
				WHERE DivisionID = '''+@DivisionID+'''
				AND ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
				AND InventoryTypeID2 BETWEEN '''+@FromI04ID+''' AND '''+@ToI04ID+''''
				+ CASE WHEN (@FromAna01ID <> '' OR @ToAna01ID <> '') THEN ' AND ISNULL(SOAna01ID, '''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''' ELSE '' END  
				+ CASE WHEN (@FromAna02ID <> '' OR @ToAna02ID <> '') THEN ' AND ISNULL(SOAna02ID, '''') BETWEEN '''+@FromAna02ID+''' AND '''+@ToAna02ID+'''' ELSE '' END  
				+ CASE WHEN (@FromAna03ID <> '' OR @ToAna03ID <> '') THEN ' AND ISNULL(SOAna03ID, '''') BETWEEN '''+@FromAna03ID+''' AND '''+@ToAna03ID+'''' ELSE '' END
				+ CASE WHEN (@FromAna04ID <> '' OR @ToAna04ID <> '') THEN ' AND ISNULL(SOAna04ID, '''') BETWEEN '''+@FromAna04ID+''' AND '''+@ToAna04ID+'''' ELSE '' END
				+ CASE WHEN (@FromAna05ID <> '' OR @ToAna05ID <> '') THEN ' AND ISNULL(SOAna05ID, '''') BETWEEN '''+@FromAna05ID+''' AND '''+@ToAna05ID+'''' ELSE '' END + '
				'+ @sWhere3 +'
				GROUP BY DivisionID, InventoryTypeID, InventoryTypeID2, ObjectID, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID, FromDate, AT0161.ToDate) AT0161 ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.InventoryTypeID2 = #TEMP1.I04ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TEMP1.ObjectID
	GROUP BY ISNULL(#TEMP1.DivisionID,AT0161.DivisionID), 
	ISNULL(#TEMP1.ObjectID, AT0161.ObjectID),
	ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2), 
	ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID),
	ISNULL(#TEMP1.Ana01ID, AT0161.SOAna01ID),
	ISNULL(#TEMP1.Ana02ID, AT0161.SOAna02ID),
	ISNULL(#TEMP1.Ana03ID, AT0161.SOAna03ID),
	ISNULL(#TEMP1.Ana04ID, AT0161.SOAna04ID),
	ISNULL(#TEMP1.Ana05ID, AT0161.SOAna05ID)
	ORDER BY ISNULL(#TEMP1.I04ID, AT0161.InventoryTypeID2), ISNULL(#TEMP1.I08ID, AT0161.InventoryTypeID)
	'
ELSE
	SET @sSQL1 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID,
	#TEMP1.I04ID, #TEMP1.I08ID,
	MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth01, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth02, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth03, 
	MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth04, MAX(ISNULL(AT0161.SalesMonth,0)) AS SalesMonth05,
	SUM(ISNULL(#TEMP1.ConvertedAmountAfterVAT,0)) AS ConvertedAmountAfterVAT, 
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID
	INTO #TEMP2
	FROM #TEMP1 WITH (NOLOCK)
	LEFT JOIN AT0161 ON AT0161.DivisionID = #TEMP1.DivisionID AND AT0161.InventoryTypeID = #TEMP1.I08ID AND AT0161.InventoryTypeID2 = #TEMP1.I04ID AND AT0161.ObjectID = #TEMP1.ObjectID 
	AND AT0161.SOAna01ID = #TEMP1.Ana01ID AND AT0161.SOAna02ID = #TEMP1.Ana02ID AND AT0161.SOAna03ID = #TEMP1.Ana03ID AND AT0161.SOAna04ID = #TEMP1.Ana04ID AND AT0161.SOAna05ID = #TEMP1.Ana05ID 
	'+@sWhere2+'
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TEMP1.ObjectID
	--WHERE '+@sWhere3+'
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID,
	#TEMP1.I04ID, #TEMP1.I08ID,
	#TEMP1.Ana01ID, #TEMP1.Ana02ID, #TEMP1.Ana03ID, #TEMP1.Ana04ID, #TEMP1.Ana05ID
	'

SET @sSQL2 = '
SELECT #TEMP2.*,  
A1.ObjectName, A4.AnaName as InventoryTypeName, A5.AnaName as InventoryTypeName2,
O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05,  
O06.UserName as UserName01, O07.UserName as UserName02, O08.UserName as UserName03, O09.UserName as UserName04, O10.UserName as UserName05
FROM #TEMP2
LEFT JOIN AT1202 A1 ON A1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND #TEMP2.ObjectID = A1.ObjectID
LEFT JOIN AT1015 A4 ON #TEMP2.I04ID = A4.AnaID AND A4.AnaTypeID = ''I04''
LEFT JOIN AT1015 A5 ON #TEMP2.I08ID = A5.AnaID AND A5.AnaTypeID = ''I08''
LEFT JOIN OT1002 O01 ON #TEMP2.DivisionID = O01.DivisionID AND O01.AnaID = #TEMP2.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN OT1002 O02 ON #TEMP2.DivisionID = O02.DivisionID AND O02.AnaID = #TEMP2.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN OT1002 O03 ON #TEMP2.DivisionID = O03.DivisionID AND O03.AnaID = #TEMP2.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1002 O04 ON #TEMP2.DivisionID = O04.DivisionID AND O04.AnaID = #TEMP2.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1002 O05 ON #TEMP2.DivisionID = O05.DivisionID AND O05.AnaID = #TEMP2.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN OT1005 O06 ON O06.DivisionID = #TEMP2.DivisionID AND O06.AnaTypeID LIKE ''S01''
LEFT JOIN OT1005 O07 ON O07.DivisionID = #TEMP2.DivisionID AND O07.AnaTypeID LIKE ''S02''
LEFT JOIN OT1005 O08 ON O08.DivisionID = #TEMP2.DivisionID AND O08.AnaTypeID LIKE ''S03''
LEFT JOIN OT1005 O09 ON O09.DivisionID = #TEMP2.DivisionID AND O09.AnaTypeID LIKE ''S04''
LEFT JOIN OT1005 O10 ON O10.DivisionID = #TEMP2.DivisionID AND O10.AnaTypeID LIKE ''S05''
ORDER BY #TEMP2.I08ID, #TEMP2.I04ID
'


PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
