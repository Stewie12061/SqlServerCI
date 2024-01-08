IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Tiểu Mai on 08/06/2016: In báo cáo đặc thù ANG_OR0083 (CustomizeIndex = 57 ---- ANGEL)
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
 * exec OP0083 'ANG', 201601, 201601, '01/01/2016', '01/31/2016', '', 'KPP.HAG.0001', 'KPP.HYE.0001', 'HMP', 'MPB' , 0
 */
 

CREATE PROCEDURE [dbo].[OP0083] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@O02ID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@FromInventoryTypeID NVARCHAR(50),
	@ToInventoryTypeID NVARCHAR(50),
	@TimeMode TINYINT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)
		
SET @sWhere = ''
IF @TimeMode = 0
	SET @sWhere = @sWhere + '
		AND OT2001.TranMonth + OT2001.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)
ELSE
	SET @sWhere = @sWhere + '
		And (OT2001.OrderDate  BETWEEN '+Convert(nvarchar(10),@FromDate,21)+' AND '+convert(nvarchar(10), @ToDate,21)+')'

------ Lấy số lượng hàng bán theo MPT đơn hàng bán		
SET @sSQL = '
SELECT OT2001.DivisionID, OT2001.ObjectID, A01.I08ID, 
		--SUM((ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
  --          - ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
  --          - OT2002.VATOriginalAmount)) AS OriginalAmountAfterVAT,
            
		SUM((OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - ISNULL(OT2002.DiscountSaleAmountDetail,0) 
			-  (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity 
			- OT2002.VATConvertedAmount)) AS ConvertedAmountAfterVAT,
		OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1302 A01 WITH (NOLOCK) ON A01.DivisionID IN (''@@@'', OT2002.DivisionID) AND OT2002.InventoryID = A01.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) <> 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND ISNULL(A01.I08ID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID + @sWhere +'''
GROUP BY OT2001.DivisionID, OT2001.ObjectID, A01.I08ID,
		OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID
'
--PRINT @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'OV0082')
	EXEC('CREATE VIEW OV0082  --tao boi OP0082
		as '+@sSQL)
ELSE
	EXEC('ALTER VIEW OV0082  --- tao boi OP0082
		as '+@sSQL)

---- Lấy số lượng target các cấp nhân viên
SET @sSQL1 = 'SELECT *
INTO #Target
FROM (
SELECT AT61.DivisionID, AT61.ObjectID, AT61.EmployeeID as Ana01ID, NULL as Ana02ID, NULL as Ana03ID, NULL as Ana04ID, NULL as Ana05ID, 
AT61.InventoryTypeID, AT61.SalesMonth 
FROM  AT0161 AT61 WITH (NOLOCK)
WHERE AT61.DivisionID = '''+@DivisionID+'''
	AND AT61.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND ISNULL(AT61.InventoryTypeID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND Isnull(EmployeeID,'''') IN (SELECT DISTINCT Isnull(Ana01ID,'''') FROM OV0082)
UNION ALL
SELECT AT61.DivisionID, AT61.ObjectID, NULL as Ana01ID, AT61.EmployeeID as Ana02ID, NULL as Ana03ID, NULL as Ana04ID, NULL as Ana05ID, 
AT61.InventoryTypeID, AT61.SalesMonth 
FROM  AT0161 AT61 WITH (NOLOCK)
WHERE AT61.DivisionID = '''+@DivisionID+'''
	AND AT61.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND ISNULL(AT61.InventoryTypeID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND Isnull(EmployeeID,'''') IN (SELECT DISTINCT Isnull(Ana02ID,'''') FROM OV0082)
UNION ALL
SELECT AT61.DivisionID, AT61.ObjectID, NULL as Ana01ID, NULL as Ana02ID, AT61.EmployeeID as Ana03ID, NULL as Ana04ID, NULL as Ana05ID, 
AT61.InventoryTypeID, AT61.SalesMonth 
FROM  AT0161 AT61 WITH (NOLOCK)
WHERE AT61.DivisionID = '''+@DivisionID+'''
	AND AT61.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND ISNULL(AT61.InventoryTypeID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND Isnull(EmployeeID,'''') IN (SELECT DISTINCT Isnull(Ana03ID,'''') FROM OV0082)
UNION ALL
SELECT AT61.DivisionID, AT61.ObjectID, NULL as Ana01ID, NULL as Ana02ID, NULL as Ana03ID, AT61.EmployeeID as Ana04ID, NULL as Ana05ID, AT61.InventoryTypeID, AT61.SalesMonth 
FROM  AT0161 AT61 WITH (NOLOCK)
WHERE AT61.DivisionID = '''+@DivisionID+'''
	AND AT61.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND ISNULL(AT61.InventoryTypeID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND Isnull(EmployeeID,'''') IN (SELECT DISTINCT Isnull(Ana04ID,'''') FROM OV0082)
UNION ALL
SELECT AT61.DivisionID, AT61.ObjectID, NULL as Ana01ID, NULL as Ana02ID, NULL as Ana03ID, NULL as Ana04ID, AT61.EmployeeID as Ana05ID, AT61.InventoryTypeID, AT61.SalesMonth 
FROM  AT0161 AT61 WITH (NOLOCK)
WHERE AT61.DivisionID = '''+@DivisionID+'''
	AND AT61.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+'''
	AND ISNULL(AT61.InventoryTypeID,'''') BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
	AND Isnull(EmployeeID,'''') IN (SELECT DISTINCT Isnull(Ana05ID,'''') FROM OV0082)
) A'

------ Lấy dòng 

----PRINT @sSQL
----PRINT @sSQL1
----PRINT @sSQL2
----PRINT @sSQL3
SET @sSQL2 = '
SELECT OV82.*, A6.AnaName as InventoryTypeName, A5.ObjectName, A5.O01ID, A7.AreaID, A7.AreaName, O01.AnaName as AnaName01, O02.AnaName as AnaName02, O03.AnaName as AnaName03, O04.AnaName as AnaName04, O05.AnaName as AnaName05, 
ISNULL(A1.SalesMonthAna02,0) AS SalesMonthAna02, ISNULL(A2.SalesMonthAna03,0) AS SalesMonthAna02, 
ISNULL(A3.SalesMonthAna04,0) AS SalesMonthAna04, ISNULL(A4.SalesMonthAna05,0) AS SalesMonthAna05, O06.UserName as UserName01, O07.UserName as UserName02, O08.UserName as UserName03, O09.UserName as UserName04, O10.UserName as UserName05
FROM OV0082 OV82 
LEFT JOIN (
SELECT V82.DivisionID,TG2.InventoryTypeID, V82.ObjectID,V82.Ana01ID, V82.Ana02ID, SUM(ISNULL(TG2.SalesMonth,0)) SalesMonthAna02 from OV0082 V82
Inner JOIN #Target TG2 ON TG2.DivisionID = V82.DivisionID AND V82.ObjectID = TG2.ObjectID 
AND TG2.InventoryTypeID = V82.I08ID 
AND ( ISNULL(TG2.Ana02ID,'''') = ISNULL(V82.Ana02ID,''''))
Group by V82.DivisionID,TG2.InventoryTypeID,V82.Ana01ID, V82.Ana02ID,V82.ObjectID
) A1 ON A1.DivisionID = OV82.DivisionID AND OV82.I08ID = A1.InventoryTypeID AND OV82.ObjectID = A1.ObjectID 
AND ISNULL(A1.Ana01ID,'''') = ISNULL(OV82.Ana01ID,'''') AND ISNULL(A1.Ana02ID,'''') = ISNULL(OV82.Ana02ID,'''')
LEFT JOIN (
SELECT V82.DivisionID,TG2.InventoryTypeID, V82.ObjectID,V82.Ana01ID, V82.Ana02ID, V82.Ana03ID, SUM(ISNULL(TG2.SalesMonth,0)) SalesMonthAna03 from OV0082 V82
Inner JOIN #Target TG2 ON TG2.DivisionID = V82.DivisionID AND V82.ObjectID = TG2.ObjectID 
AND TG2.InventoryTypeID = V82.I08ID 
AND (ISNULL(TG2.Ana02ID,'''') = ISNULL(V82.Ana02ID,'''') OR ISNULL(TG2.Ana03ID,'''') = ISNULL(V82.Ana03ID,''''))
Group by V82.DivisionID,TG2.InventoryTypeID,V82.Ana01ID, V82.Ana02ID,V82.ObjectID, V82.Ana03ID
) A2 ON A2.DivisionID = OV82.DivisionID AND OV82.I08ID = A2.InventoryTypeID AND OV82.ObjectID = A2.ObjectID AND ISNULL(A2.Ana01ID,'''') = ISNULL(OV82.Ana01ID,'''') 
AND ISNULL(A2.Ana02ID,'''') = ISNULL(OV82.Ana02ID,'''') AND ISNULL(A2.Ana03ID,'''') = ISNULL(OV82.Ana03ID,'''')
LEFT JOIN (
SELECT V82.DivisionID,TG2.InventoryTypeID, V82.ObjectID,V82.Ana01ID, V82.Ana02ID, V82.Ana03ID, V82.Ana04ID, SUM(ISNULL(TG2.SalesMonth,0)) SalesMonthAna04 from OV0082 V82
Inner JOIN #Target TG2 ON TG2.DivisionID = V82.DivisionID AND V82.ObjectID = TG2.ObjectID 
AND TG2.InventoryTypeID = V82.I08ID 
AND (ISNULL(TG2.Ana02ID,'''') = ISNULL(V82.Ana02ID,'''') OR ISNULL(TG2.Ana03ID,'''') = ISNULL(V82.Ana03ID,'''') OR ISNULL(TG2.Ana04ID,'''') = ISNULL(V82.Ana04ID,''''))
Group by V82.DivisionID,TG2.InventoryTypeID,V82.Ana01ID, V82.Ana02ID,V82.ObjectID, V82.Ana03ID, V82.Ana04ID	
) A3 ON A2.DivisionID = A3.DivisionID AND A3.InventoryTypeID = OV82.I08ID AND A3.ObjectID = OV82.ObjectID 
AND ISNULL(OV82.Ana01ID,'''') = ISNULL(A3.Ana01ID,'''') AND ISNULL(A3.Ana02ID,'''') = ISNULL(OV82.Ana02ID,'''') AND ISNULL(A3.Ana03ID,'''') = ISNULL(OV82.Ana03ID,'''')
AND ISNULL(A3.Ana04ID,'''') = ISNULL(OV82.Ana04ID,'''')
LEFT JOIN (
SELECT V82.DivisionID,TG2.InventoryTypeID, V82.ObjectID,V82.Ana01ID, V82.Ana02ID, V82.Ana03ID, V82.Ana04ID, V82.Ana05ID, SUM(ISNULL(TG2.SalesMonth,0)) SalesMonthAna05 from OV0082 V82
Inner JOIN #Target TG2 ON TG2.DivisionID = V82.DivisionID AND V82.ObjectID = TG2.ObjectID 
AND TG2.InventoryTypeID = V82.I08ID 
AND (ISNULL(TG2.Ana02ID,'''') = ISNULL(V82.Ana02ID,'''') OR ISNULL(TG2.Ana03ID,'''') = ISNULL(V82.Ana03ID,'''') OR ISNULL(TG2.Ana05ID,'''') = ISNULL(V82.Ana05ID,''''))
Group by V82.DivisionID,TG2.InventoryTypeID,V82.Ana01ID, V82.Ana02ID,V82.ObjectID, V82.Ana03ID, V82.Ana04ID, V82.Ana05ID            
) A4 ON A4.DivisionID = OV82.DivisionID AND OV82.I08ID = A4.InventoryTypeID AND OV82.ObjectID = A4.ObjectID AND ISNULL(A4.Ana01ID,'''') = ISNULL(OV82.Ana01ID,'''') 
AND ISNULL(A4.Ana02ID,'''') = ISNULL(OV82.Ana02ID,'''') AND ISNULL(A4.Ana03ID,'''') = ISNULL(OV82.Ana03ID,'''') AND ISNULL(A4.Ana04ID,'''') = ISNULL(OV82.Ana04ID,'''') 
AND ISNULL(A4.Ana05ID,'''') = ISNULL(OV82.Ana05ID,'''')'
SET @sSQL3 = '
LEFT JOIN AT1202 A5 WITH (NOLOCK) ON A5.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A5.ObjectID = OV82.ObjectID
LEFT JOIN AT1015 A6 WITH (NOLOCK) ON A6.AnaID = OV82.I08ID AND A6.AnaTypeID = ''I08''
LEFT JOIN AT1003 A7 WITH (NOLOCK) ON A7.AreaID = A5.AreaID
LEFT JOIN OT1002 O01 WITH (NOLOCK) ON OV82.DivisionID = O01.DivisionID AND O01.AnaID = OV82.Ana01ID AND O01.AnaTypeID = ''S01''
LEFT JOIN OT1002 O02 WITH (NOLOCK) ON OV82.DivisionID = O02.DivisionID AND O02.AnaID = OV82.Ana02ID AND O02.AnaTypeID = ''S02''
LEFT JOIN OT1002 O03 WITH (NOLOCK) ON OV82.DivisionID = O03.DivisionID AND O03.AnaID = OV82.Ana03ID AND O03.AnaTypeID = ''S03''
LEFT JOIN OT1002 O04 WITH (NOLOCK) ON OV82.DivisionID = O04.DivisionID AND O04.AnaID = OV82.Ana04ID AND O04.AnaTypeID = ''S04''
LEFT JOIN OT1002 O05 WITH (NOLOCK) ON OV82.DivisionID = O05.DivisionID AND O05.AnaID = OV82.Ana05ID AND O05.AnaTypeID = ''S05''
LEFT JOIN OT1005 O06 WITH (NOLOCK) ON O06.DivisionID = OV82.DivisionID AND O06.AnaTypeID LIKE ''S01''
LEFT JOIN OT1005 O07 WITH (NOLOCK) ON O07.DivisionID = OV82.DivisionID AND O07.AnaTypeID LIKE ''S02''
LEFT JOIN OT1005 O08 WITH (NOLOCK) ON O08.DivisionID = OV82.DivisionID AND O08.AnaTypeID LIKE ''S03''
LEFT JOIN OT1005 O09 WITH (NOLOCK) ON O09.DivisionID = OV82.DivisionID AND O09.AnaTypeID LIKE ''S04''
LEFT JOIN OT1005 O10 WITH (NOLOCK) ON O10.DivisionID = OV82.DivisionID AND O10.AnaTypeID LIKE ''S05''
ORDER BY OV82.ObjectID, OV82.I08ID'

--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC (@sSQL1 + @sSQL2 + @sSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
