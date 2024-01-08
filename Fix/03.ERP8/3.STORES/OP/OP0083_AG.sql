IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0083_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0083_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--- Created by Tiểu Mai on 18/08/2016: In báo cáo đặc thù OR0083_ANG (CustomizeIndex = 57 ---- ANGEL)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường Notes (Diễn giải)
---- Modified by Nhật Thanh on 29/03/2022: Bổ sung điều kiện divisionID @@@ khi join bảng
/*
 * exec OP0083_AG @DivisionID = 'ANG', @FromPeriod = 201601, @ToPeriod = 201601, @FromDate = '01/15/2016', @ToDate = '01/15/2016', @FromO01ID = 'HCM', @ToO01ID = 'MT', @FromO05ID = 'KH01', @ToO05ID = 'KH06', @FromI02ID = 'BPMUA', @ToI02ID = 'SIL', @TimeMode = 0
 */

CREATE PROCEDURE [dbo].[OP0083_AG] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromO01ID NVARCHAR(50),
	@ToO01ID NVARCHAR(50),
	@FromO05ID NVARCHAR(50),
	@ToO05ID NVARCHAR(50),
	@FromI02ID NVARCHAR(50),
	@ToI02ID NVARCHAR(50),	
	@FromSOrderID NVARCHAR(50),
	@ToSOrderID NVARCHAR(50),		
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
		And (Convert(nvarchar(10),OT2001.OrderDate,112)  BETWEEN '+Convert(nvarchar(10),@FromDate,112)+' AND '+convert(nvarchar(10), @ToDate,112)+')'

------ Lấy số lượng hàng bán		
SET @sSQL = '
SELECT OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity, 0 AS [Type], AT1202.O05ID, AT1302.I02ID, OT2001.Notes
INTO #Temp1
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1202 WITH (NOLOCK) ON OT2001.DivisionID in ( OT2002.DivisionID,''@@@'')  AND OT2001.ObjectID = AT1202.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in ( OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) <> 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND AT1202.O01ID BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+'''
	AND AT1202.O05ID BETWEEN '''+@FromO05ID+'''	AND '''+@ToO05ID+'''
	AND AT1302.I02ID BETWEEN '''+@FromI02ID+''' AND '''+@ToI02ID+''' 
	AND OT2001.SOrderID BETWEEN '''+@FromSOrderID+''' AND '''+@ToSOrderID+''''+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, AT1202.O05ID, AT1302.I02ID, OT2001.Notes
'
------ Lấy số lượng hàng khuyến mãi
SET @sSQL1 = '
SELECT OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity,  1 AS [Type], AT1202.O05ID, AT1302.I02ID, OT2001.Notes
INTO #Temp2
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1202 WITH (NOLOCK) ON OT2001.DivisionID in ( OT2002.DivisionID,''@@@'')  AND OT2001.ObjectID = AT1202.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in ( OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) = 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND AT1202.O01ID BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+'''
	AND AT1202.O05ID BETWEEN '''+@FromO05ID+''' AND '''+@ToO05ID+'''
	AND AT1302.I02ID BETWEEN '''+@FromI02ID+''' AND '''+@ToI02ID+'''
	AND OT2001.SOrderID BETWEEN '''+@FromSOrderID+''' AND '''+@ToSOrderID+''''+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, AT1202.O05ID, AT1302.I02ID, OT2001.Notes
'
------ Lấy dòng tổng cộng
SET @sSQL2 = '
SELECT OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity,  2 AS [Type], AT1202.O05ID, AT1302.I02ID, OT2001.Notes
INTO #Temp3
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1202 WITH (NOLOCK) ON OT2001.DivisionID in ( OT2002.DivisionID,''@@@'')  AND OT2001.ObjectID = AT1202.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in ( OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND AT1202.O01ID BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+'''
	AND AT1202.O05ID BETWEEN '''+@FromO05ID+''' AND '''+@ToO05ID+'''
	AND AT1302.I02ID BETWEEN '''+@FromI02ID+''' AND '''+@ToI02ID+'''
	AND OT2001.SOrderID BETWEEN '''+@FromSOrderID+''' AND '''+@ToSOrderID+''''+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.VoucherNo, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, AT1202.O05ID, AT1302.I02ID, OT2001.Notes
'

----- Trả ra dữ liệu cho report
SET @sSQL3 = '
SELECT A.*, AT1202.ObjectName, AT1202.Address, AT1302.InventoryName, AT1302.InventoryTypeID, AT1301.InventoryTypeName,
A02.AnaID as O05ID, A02.AnaName as O05Name, 
A03.AnaID as I02ID, A03.AnaName as I02Name, A04.AnaID as I04ID, A04.AnaName as I04Name
  FROM (
	SELECT *
	FROM #Temp1
	UNION ALL
	SELECT *
	FROM #Temp2
	UNION ALL
	SELECT *
	FROM #Temp3
) A
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in ( A.DivisionID,''@@@'')  AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID in ( A.DivisionID,''@@@'')  AND A.InventoryID = AT1302.InventoryID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.DivisionID = AT1302.DivisionID AND AT1301.InventoryTypeID = AT1302.InventoryTypeID
LEFT JOIN AT1015 A02 WITH (NOLOCK) ON A02.DivisionID = '''+@DivisionID+''' AND A02.AnaTypeID = ''O05'' AND A02.AnaID = AT1202.O05ID
LEFT JOIN AT1015 A03 WITH (NOLOCK) ON A03.DivisionID = '''+@DivisionID+''' AND A03.AnaTypeID = ''I02'' AND A03.AnaID = AT1302.I02ID
LEFT JOIN AT1015 A04 WITH (NOLOCK) ON A04.DivisionID = A.DivisionID AND A04.AnaID = AT1302.I04ID AND A04.AnaTypeID = ''I04''
--WHERE
--A01.AnaID BETWEEN '''+@FromO01ID+''' AND '''+@ToO01ID+''' AND
--A02.AnaID BETWEEN '''+@FromO05ID+''' AND '''+@ToO05ID+''' AND
--A03.AnaID BETWEEN '''+@FromI02ID+''' AND '''+@ToI02ID+'''
ORDER BY A.O05ID, A03.AnaID, A04.AnaID, A.InventoryID, A.VoucherNo, A.[Type]
'
PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3


EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3 )





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
