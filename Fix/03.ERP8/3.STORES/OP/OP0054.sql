IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Hải Long on 08/02/2017: In thông báo điều chỉnh đơn hàng sản xuất (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
exec OP0054 @DivisionID=N'SC', @AdjustOrderID = 'BD_IO/16/11/012'
*/
 

CREATE PROCEDURE [dbo].[OP0054] 
(
	@DivisionID nvarchar(50),
	@AdjustOrderID nvarchar(50) -- Là ID đơn hàng điều chỉnh sản xuất
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = '',
		@OrderID NVARCHAR(50) = '',
		@Varchar02 NVARCHAR(500) = '',
		@ShipDate NVARCHAR(50) = ''
		
SELECT @OrderID	= ISNULL(AdjustSOrderID, ''),
	   @Varchar02 = ISNULL(Varchar02, ''),
	   @ShipDate = CASE WHEN ShipDate IS NOT NULL THEN Convert(NVARCHAR(10), ShipDate, 102) ELSE '' END 
FROM OT2001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND SOrderID = @AdjustOrderID

SET @sSQL = N'
SELECT OT2001.SOrderID, OT2001.ObjectID, AT1202.ObjectName, OT2002.InventoryID, AT1302.InventoryName, ISNULL(OT2002.OrderQuantity, 0) + ISNULL(TB.OrderQuantity, 0) AS AdjustOrderQuantity, 
ISNULL(OT2002.OrderQuantity, 0) AS OrderQuantity, OT2002.SalePrice, 
B02.Varchar01, B02.Varchar02, B02.Varchar03, B02.Varchar04, B02.Varchar05, B02.Varchar06, B02.Varchar07, B02.Varchar08, B02.Varchar09, B02.Varchar10,
B02.Varchar11, B02.Varchar12, B02.Varchar13, B02.Varchar14, B02.Varchar15, B02.Varchar16, B02.Varchar17, B02.Varchar18, B02.Varchar19, B02.Varchar20,
TB3.Varchar01 AS Varchar01_NEW, TB3.Varchar02, TB3.Varchar03, TB3.Varchar04, TB3.Varchar05, TB3.Varchar06, TB3.Varchar07, TB3.Varchar08, TB3.Varchar09, TB3.Varchar10,
TB3.Varchar11, TB3.Varchar12, TB3.Varchar13, TB3.Varchar14, TB3.Varchar15, TB3.Varchar16, TB3.Varchar17, TB3.Varchar18, TB3.Varchar19, TB3.Varchar20,
TB3.Ana01ID,
TB2.ShipDate AS ExportDate, B01.ShipDate AS ShipDate_3,
OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID,
OT2002.Ana06ID, OT2002.Ana07ID, OT2002.Ana08ID, OT2002.Ana09ID, OT2002.Ana10ID
FROM OT2001 WITH (NOLOCK) 
INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2001.ObjectID = AT1202.ObjectID  
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND OT2002.InventoryID = AT1302.InventoryID  
LEFT JOIN AT1304 WITH (NOLOCK) ON OT2002.UnitID = AT1304.UnitID  
-- Đơn hàng bán điều chỉnh
INNER JOIN OT2001 B01 WITH (NOLOCK) ON B01.DivisionID = OT2001.DivisionID AND B01.InheritSOrderID = OT2001.SOrderID AND B01.OrderType = 0 AND B01.OrderTypeID = 1
-- Đơn hàng sản xuất
INNER JOIN OT2001 B02 WITH (NOLOCK) ON B02.DivisionID = OT2001.DivisionID AND B02.InheritSOrderID = OT2001.SOrderID AND B02.OrderType = 1 AND ISNULL(B02.OrderTypeID, 0) = 0  
-- Lấy tổng số lượng đơn hàng bán điều chỉnh
INNER JOIN 
(	
	SELECT OT2001.DivisionID, OT2002.InheritVoucherID, OT2002.InheritTransactionID, OT2002.InheritTableID, SUM(OT2002.OrderQuantity) AS OrderQuantity
	FROM OT2002 WITH (NOLOCK)
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID AND OT2001.OrderType = 0 AND OT2001.OrderTypeID = 1
	GROUP BY OT2001.DivisionID, OT2002.InheritVoucherID, OT2002.InheritTransactionID, OT2002.InheritTableID
) TB ON TB.DivisionID = OT2002.DivisionID AND TB.InheritVoucherID = OT2002.SOrderID AND TB.InheritTransactionID = OT2002.TransactionID AND TB.InheritTableID = ''OT2001''
-- Lấy phiếu điều chỉnh đơn hàng sản xuất gần nhất
'
SET @sSQL1 = N'
INNER JOIN 
(	
	SELECT TOP 1 OT2001.DivisionID, OT2001.InheritSOrderID, OT2001.Varchar01, OT2001.Varchar02, OT01.ShipDate
	FROM OT2001 WITH (NOLOCK)
	LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = OT2001.DivisionID AND OT01.SOrderID = OT2001.AdjustSOrderID 
	WHERE OT2001.OrderType = 1 
	AND OT2001.OrderTypeID = 1
	ORDER BY OT2001.OrderDate DESC
) TB2 ON TB2.DivisionID = B02.DivisionID AND TB2.InheritSOrderID = B02.SOrderID
-- Phiếu điều chỉnh hiện tại
LEFT JOIN 
(
	SELECT	OT2001.DivisionID, OT2002.InventoryID, OT2001.Varchar01, OT2001.Varchar02, OT2001.Varchar03, OT2001.Varchar04, OT2001.Varchar05, OT2001.Varchar06, OT2001.Varchar07, OT2001.Varchar08, OT2001.Varchar09, OT2001.Varchar10,
			OT2001.Varchar11, OT2001.Varchar12, OT2001.Varchar13, OT2001.Varchar14, OT2001.Varchar15, OT2001.Varchar16, OT2001.Varchar17, OT2001.Varchar18, OT2001.Varchar19, OT2001.Varchar20,
			OT2002.Ana01ID
	FROM OT2001
	INNER JOIN OT2002 ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	WHERE OT2001.SOrderID = ''' + @AdjustOrderID + '''
	GROUP BY OT2001.DivisionID, OT2002.InventoryID, OT2001.Varchar01, OT2001.Varchar02, OT2001.Varchar03, OT2001.Varchar04, OT2001.Varchar05, OT2001.Varchar06, OT2001.Varchar07, OT2001.Varchar08, OT2001.Varchar09, OT2001.Varchar10,
	OT2001.Varchar11, OT2001.Varchar12, OT2001.Varchar13, OT2001.Varchar14, OT2001.Varchar15, OT2001.Varchar16, OT2001.Varchar17, OT2001.Varchar18, OT2001.Varchar19, OT2001.Varchar20,
	OT2002.Ana01ID
) TB3 ON OT2002.DivisionID = TB3.DivisionID AND OT2002.InventoryID = TB3.InventoryID

WHERE OT2001.DivisionID = ''' + @DivisionID + '''
AND B01.SOrderID = ''' + @OrderID + '''
ORDER BY OT2001.OrderDate, OT2001.SOrderID
'

PRINT @sSQL
PRINT @sSQL1
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
