IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Tiểu Mai on 08/06/2016: In báo cáo đặc thù ANG_OR0081 (CustomizeIndex = 57 ---- ANGEL)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- EXEC OP0081 'AS','OP_LMX_DHB/2014/03/03'
/*
 * exec OP0081 'ANG', 201601, 201601, '01/15/2016', '01/15/2016', '', 'KPP.BDU.0001', 'KPP.DNA.0001', 1
 */

CREATE PROCEDURE [dbo].[OP0081] 
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@O02ID NVARCHAR(50),
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
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

------ Lấy số lượng hàng bán		
SET @sSQL = '
SELECT OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity, 0 AS [Type]
INTO #Temp1
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) <> 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' ' + @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID
'
------ Lấy số lượng hàng khuyến mãi
SET @sSQL1 = '
SELECT OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity,  1 AS [Type]
INTO #Temp2
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2002.IsProInventoryID,0) = 1
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID
'
------ Lấy dòng tổng cộng
SET @sSQL2 = '
SELECT OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID, SUM(ISNULL(OrderQuantity,0)) AS OrderQuantity,  2 AS [Type]
INTO #Temp3
FROM OT2002 WITH (NOLOCK)
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
WHERE OT2002.DivisionID = '''+@DivisionID+'''
	AND ISNULL(OT2001.OrderStatus,0) = 1
	AND ISNULL(OT2001.OrderType,0) = 0
	AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '+ @sWhere +'
GROUP BY OT2001.DivisionID, OT2001.ObjectID, OT2002.InventoryID, OT2002.UnitID
'
----- Trả ra dữ liệu cho report
SET @sSQL3 = '
SELECT A.*, AT1202.ObjectName, AT1202.Address, AT1302.InventoryName, AT1302.InventoryTypeID, AT1301.InventoryTypeName
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
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', A.DivisionID) AND A.InventoryID = AT1302.InventoryID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.DivisionID = AT1302.DivisionID AND AT1301.InventoryTypeID = AT1302.InventoryTypeID
ORDER BY AT1202.ObjectID, A.[Type]
'
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3 )


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
