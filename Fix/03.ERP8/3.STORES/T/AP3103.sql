IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- In phiếu Yêu cầu thanh toán (GODREJ)
--- Created by Bảo Thy on 26/06/2017
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
EXEC AP3103 @DivisionID=N'CAG',@Tranmonth=2,@Tranyear=2017,@VoucherID=N'AVe9b4947a-b3fc-43de-9a16-7283ef2176e1'
*/
CREATE PROCEDURE [dbo].[AP3103] 
				 @DivisionID as VARCHAR(50),
				 @TranMonth as INT,
				 @TranYear as INT,
				 @VoucherID as VARCHAR(50)
	
AS
DECLARE @InheritTypeID VARCHAR(50) = '',
		@sSQL VARCHAR(MAX) = '',
		@sSelect VARCHAR(MAX) = '',
		@sJoin VARCHAR(MAX) = '',
		@sGroup VARCHAR(MAX) = '',
		@sWhere VARCHAR(MAX) = ''

SELECT TOP 1 @InheritTypeID = ISNULL(InheritTypeID,'') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

IF @InheritTypeID = 'HDMH'
BEGIN
	SET @sSelect = ', A90.VoucherNo AS OrderNo, A26.VoucherNo AS ImOrderNo, A90.ObjectID, A02.ObjectName, A90.InventoryID, A03.InventoryName, A90.UnitID, A04.UnitName,
	A90.Quantity, A90.UnitPrice, A90.ConvertedAmount'
	SET @sJoin = 'LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A90.DivisionID = A91.DivisionID AND A90.VoucherID = A91.InheritVoucherID
	LEFT JOIN AT2006 A26 WITH (NOLOCK) ON A90.WOrderID = A26.VoucherID AND A90.DivisionID = A26.DivisionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (A90.DivisionID,''@@@'') AND A90.InventoryID = A03.InventoryID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A90.UnitID = A04.UnitID'
	SET @sGroup = ', A90.VoucherNo, A26.VoucherNo, A90.ObjectID, A02.ObjectName, A90.InventoryID, A03.InventoryName, A90.UnitID, A04.UnitName,
	A90.Quantity, A90.UnitPrice, A90.ConvertedAmount'
	SET @sWhere = 'AND A90.TransactionTypeID = ''T03'''
END
ELSE 
IF @InheritTypeID = 'DHM'
BEGIN
	SET @sSelect = ', A90.VoucherNo AS OrderNo, '''' AS ImOrderNo, A90.ObjectID, A02.ObjectName, O32.InventoryID, A03.InventoryName, O32.UnitID, A04.UnitName,
	O32.OrderQuantity AS Quantity, O32.PurchasePrice AS UnitPrice, O32.ConvertedAmount'
	SET @sJoin = 'LEFT JOIN OT3001 A90 WITH (NOLOCK) ON A90.DivisionID = A91.DivisionID AND A90.POrderID = A91.InheritVoucherID
	INNER JOIN OT3002 O32 WITH (NOLOCK) ON A90.DivisionID = O32.DivisionID AND A90.POrderID = O32.POrderID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (O32.DivisionID,''@@@'') AND O32.InventoryID = A03.InventoryID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON O32.UnitID = A04.UnitID'
	SET @sGroup = ', A90.VoucherNo, A90.ObjectID, A02.ObjectName, O32.InventoryID, A03.InventoryName, O32.UnitID, A04.UnitName, O32.OrderQuantity,
	O32.PurchasePrice, O32.ConvertedAmount'
END
ELSE
IF @InheritTypeID = 'NK'
BEGIN
	SET @sSelect = ', A27.OrderID AS OrderNo, A90.VoucherNo AS ImOrderNo, A90.ObjectID, A02.ObjectName, A27.InventoryID, A03.InventoryName, A27.UnitID, A04.UnitName,
	A27.ActualQuantity AS Quantity, A27.UnitPrice, A27.ConvertedAmount'
	SET @sJoin = 'LEFT JOIN AT2006 A90 WITH (NOLOCK) ON A90.DivisionID = A91.DivisionID AND A90.VoucherID = A91.InheritVoucherID
	INNER JOIN AT2007 A27 WITH (NOLOCK) ON A90.DivisionID = A27.DivisionID AND A90.VoucherID = A27.VoucherID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (A27.DivisionID,''@@@'') AND A27.InventoryID = A03.InventoryID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A27.UnitID = A04.UnitID'
	SET @sGroup = ', A27.OrderID, A90.VoucherNo, A90.ObjectID, A02.ObjectName, A27.InventoryID, A03.InventoryName, A27.UnitID, A04.UnitName,
	A27.ActualQuantity, A27.UnitPrice, A27.ConvertedAmount'
END

SET @sSQL = '
SELECT A91.VoucherNo, A91.VoucherDate, A91.VDescription'+@sSelect+'
FROM AT9010 A91 WITH (NOLOCK)
'+@sJoin+'
WHERE A91.DivisionID = '''+@DivisionID+'''
AND A91.VoucherID = '''+@VoucherID+'''
'+@sWhere+'
GROUP BY A91.VoucherNo, A91.VoucherDate, A91.VDescription'+@sGroup+'
'
--PRINT(@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO