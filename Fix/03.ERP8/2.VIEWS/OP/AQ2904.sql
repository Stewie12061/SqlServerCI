IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AQ2904]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AQ2904]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Created by: Bao Anh, date : 24/12/2009
--Purpose: So luong PO va so luong hang nhap kho (view tinh)
---- Modified on 08/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modify on 15/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modify on 05/03/2020 by Văn Minh: Thay đổi check số lượng tồn còn lại khi kế thừa PO
---- Modify on 21/04/2020 by Huỳnh Thử: Loại bỏ những đơn hàng mua đã kế thừa hết
---- Modify on 10/08/2021 by Huỳnh Thử: Phúc Long -- Loại bỏ những đơn hàng mua đã kế thừa hết
---- Modify on 26/09/2023 by Nhật Thanh:[Gree] Cập nhật điều kiện join không where theo OTransactionID

CREATE VIEW [dbo].[AQ2904] as
SELECT 
OT3001.DivisionID, 
OT3001.TranMonth, 
OT3001.TranYear, 
OT3001.POrderID, 
OT3001.OrderStatus, 
OT3001.Duedate, 
OT3001.Shipdate,
OT3001.PaymentTermID,

AT1208.Duedays,

OT3002.TransactionID, 
OT3002.InventoryID, 
ISNULL(OT3002.ConvertedQuantity, 0) AS ConvertedQuantity,
ISNULL(OT3002.OrderQuantity, 0) AS OrderQuantity,
ISNULL(G.ConvertedQuantity, 0) AS ActualConvertedQuantity, 
ISNULL(G.ActualQuantity, 0) AS ActualQuantity, 

CASE WHEN OT3002.Finish = 1 THEN 0 ELSE ISNULL(OT3002.ConvertedQuantity, 0)- ISNULL(G.ConvertedQuantity, 0) END AS EndConvertedQuantity,
CASE WHEN OT3002.Finish = 1 THEN 0 ELSE ISNULL(OT3002.OrderQuantity, 0)- ISNULL(G.ActualQuantity, 0) END AS EndQuantity,
CASE WHEN OT3002.Finish = 1 THEN 0 ELSE ISNULL(OT3002.OriginalAmount, 0) - ISNULL(G.ActualOriginalAmount, 0) END AS EndOriginalAmount,
CASE WHEN OT3002.Finish = 1 THEN 0 ELSE ISNULL(OT3002.ConvertedAmount, 0) - ISNULL(G.ConvertedQuantity, 0) END AS EndConvertedAmount

FROM OT3002  WITH (NOLOCK)
INNER JOIN OT3001 WITH (NOLOCK) ON OT3001.POrderID = OT3002.POrderID AND OT3001.DivisionID = OT3002.DivisionID 
LEFT JOIN AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT3001.PaymentTermID
LEFT JOIN 
(
			SELECT AT2007.DivisionID, AT2007.OrderID, OTransactionID,
				   InventoryID, sum(ActualQuantity) As ActualQuantity, sum(ConvertedQuantity) As ConvertedQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
				   , InheritTransactionID
			FROM AT2007 WITH (NOLOCK) inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID
			Where isnull(AT2007.OrderID,'') <>'' and AT2006.KindVoucherID = 1 
			GROUP BY AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID, InheritTransactionID
			UNION ALL 
			SELECT	WT0096.DivisionID, WT0096.OrderID, OTransactionID,
					InventoryID, SUM(ActualQuantity) AS ActualQuantity, SUM(ConvertedQuantity) AS ConvertedQuantity, SUM(ISNULL(OriginalAmount,0)) AS ActualOriginalAmount
					, InheritTransactionID
			FROM WT0096 WITH (NOLOCK) INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.VoucherID = WT0095.VoucherID
			WHERE ISNULL(WT0096.OrderID,'') <>'' AND WT0095.KindVoucherID = 1 
			Group by WT0096.DivisionID, WT0096.OrderID, InventoryID, OTransactionID, InheritTransactionID
) AS G --- (co nghia la Giao hang)
ON G.OrderID = OT3002.POrderID AND (((SELECT TOP 1 CustomerName from Customerindex) != 162 and G.OTransactionID = OT3002.TransactionID) OR G.InheritTransactionID = OT3002.TransactionID )
AND G.InventoryID = OT3002.InventoryID AND G.DivisionID = OT3002.DivisionID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
