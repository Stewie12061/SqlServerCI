IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0055]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0055]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Hải Long on 08/02/2017: Đổ dữ liệu ở cho lưới, lấy chi tiết từng dòng của đơn hàng điều chỉnh (CustomizeIndex = 71 ---- HHP)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
/*
exec OP0055 @DivisionID=N'SC',	@SOrderID = 'NL-03-mini23'
*/
 

CREATE PROCEDURE [dbo].[OP0055] 
(
	@DivisionID nvarchar(50),
	@SOrderID nvarchar(50)		-- Là ID truyền trên master xuống Detail của màn hình kế thừa đơn hàng 

)
AS
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT OT2001.DivisionID, OT2001.SOrderID AS InheritVoucherID, OT2002.TransactionID AS InheritTransactionID, 
OT2001.ObjectID, OT2001.Notes AS NotesM, OT2001.VoucherNo, A02.InventoryID, AT1302.InventoryName, A02.UnitID, 
B02.SOrderID, B02.OrderDate, A02.OrderQuantity, A02.ConvertedQuantity, A02.SalePrice, A02.ConvertedSalePrice, A02.ConvertedAmount, A02.DiscountPercent, A02.VATPercent, 
A02.Description, A02.Notes, A02.Notes01, A02.Notes02, A02.SOrderID AS AdjustSOrderID, A02.TransactionID AS AdjustTransactionID,
A02.Ana01ID, A02.Ana02ID, A02.Ana03ID, A02.Ana04ID, A02.Ana05ID, A02.Ana06ID, A02.Ana07ID, A02.Ana08ID, A02.Ana09ID, A02.Ana10ID,
A02.nvarchar01, A02.nvarchar02, A02.nvarchar03, A02.nvarchar04, A02.nvarchar05, A02.nvarchar06, A02.nvarchar07, A02.nvarchar08, A02.nvarchar09, A02.nvarchar10,
A02.Varchar01, A02.Varchar02, A02.Varchar03, A02.Varchar04, A02.Varchar05, A02.Varchar06, A02.Varchar07, A02.Varchar08, A02.Varchar09, A02.Varchar10
FROM OT2001 WITH (NOLOCK) 
INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
INNER JOIN OT2002 A01 WITH (NOLOCK) ON A01.DivisionID = OT2002.DivisionID AND A01.SOrderID = OT2002.RefSOrderID AND A01.TransactionID = OT2002.RefSTransactionID
INNER JOIN OT2001 B01 WITH (NOLOCK) ON A01.DivisionID = B01.DivisionID AND A01.SOrderID = B01.SOrderID AND B01.OrderType = 0
INNER JOIN OT2002 A02 WITH (NOLOCK) ON A02.DivisionID = A01.DivisionID AND A02.InheritVoucherID = A01.SOrderID AND A02.InheritTransactionID = A01.TransactionID AND A02.InheritTableID = ''OT2001''
INNER JOIN OT2001 B02 WITH (NOLOCK) ON A02.DivisionID = B02.DivisionID AND A02.SOrderID = B02.SOrderID AND B02.OrderType = 0 AND B02.OrderTypeID = 1
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', A02.DivisionID) AND AT1302.InventoryID = A02.InventoryID
WHERE B02.DivisionID = ''' + @DivisionID + '''
AND B02.SOrderID = ''' + @SOrderID + '''
ORDER BY A02.Orders

'
PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

