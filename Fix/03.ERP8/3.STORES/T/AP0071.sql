IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



------ Created by Kim Thư, Date 15/05/2019.
------ Cập nhật trạng thái Debit Note là Hoàn tất sau khi lưu hóa đơn bán hàng có kế thừa Debit Note (Song Bình)

-- <Example> exec AP0071 @DivisionID='SB', @VoucherID='AV20190000010337'

CREATE PROCEDURE [dbo].[AP0071]
		@DivisionID AS VARCHAR(50),
		@VoucherID AS VARCHAR(50)
AS 

SELECT DISTINCT OrderID
INTO #SORDERID
FROM AT9000 WITH (NOLOCK)
WHERE AT9000.DivisionID = @DivisionID
AND AT9000.VoucherID = @VoucherID


Select OT2001.DivisionID, OT2002.SOrderID,  OT2001.OrderStatus,
	SUM(ISNULL(OrderQuantity, 0)- isnull(ActualQuantity, 0)) as EndQuantity
INTO #ENDQTY
From OT2002 WITH (NOLOCK) inner join OT2001 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
	left join 	(Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
					InventoryID, sum(Quantity) As ActualQuantity
				From AT9000  WITH (NOLOCK)
	          			 WHERE TransactionTypeID ='T04' AND isnull(AT9000.OrderID,'') <>''
				Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID
				) as G  --- (co nghia la Giao  hang)
					on 	OT2001.DivisionID = G.DivisionID AND OT2002.SOrderID = G.OrderID and
						OT2002.InventoryID = G.InventoryID AND OT2002.TransactionID = G.OTransactionID
WHERE OT2001.SOrderID IN  (SELECT * FROM #SORDERID)
GROUP BY OT2001.DivisionID, OT2002.SOrderID,  OT2001.OrderStatus

UPDATE T1
SET T1.OrderStatus=3
FROM OT2001 T1 WITH (NOLOCK) INNER JOIN #ENDQTY T2 ON T1.SOrderID = T2.SOrderID AND T2.OrderStatus<>3

-- Tìm những đơn hàng bán không có hóa đơn kế thừa để update lại OrderStatus=1
-- UPDATE O1
-- SET O1.OrderStatus=1
-- FROM OT2001 O1 WITH(NOLOCK)
-- WHERE O1.DivisionID = @DivisionID AND O1.OrderType=0 AND O1.Disabled=0 AND O1.OrderStatus NOT IN (9)
-- AND O1.SOrderID NOT IN (SELECT ISNULL(OrderID,'') FROM AT9000 WITH(NOLOCK) WHERE DivisionID = @DivisionID)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
