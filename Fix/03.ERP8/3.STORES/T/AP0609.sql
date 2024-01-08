IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0609]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0609]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created on 26/02/2018 by Bảo Anh
---- Cập nhật AT9000 và AT2008 khi Update AT2007 (thay cho phần xử lý cập nhật ở trigger AZ2007 để cải tiến tốc độ)
---- Modified by Kim Thư on 12/12/2018: Sửa lỗi cập nhật số dư thực tế đích danh cho phiếu xuất bị sai KindVoucherID, cột DeQuantity là số lượng xuất mới nhất
---- Modified by Bảo Anh on 21/01/2019: Sửa lỗi cập nhật lại PeriodID = '' sau khi đã tập hợp chi phí nhưng tính lại giá xuất kho
---- Modified by Kim Thư on 27/03/2019: Bổ sung cập nhật số lượng cho phiếu nhập cũ và mới - trường hợp update phiếu xuất có thay đổi chứng từ nhập, lô nhập, mặt hàng
---- Modified by Huỳnh Thử on 28/08/2020: Update lại SL xuất và tồn cuối cho phiếu xuất chuyển trong AT0114
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- 
---- EXEC AP0609
----
CREATE PROCEDURE [dbo].[AP0609]
AS

--- I. Update AT9000
WITH T90 AS
(SELECT TransactionID
	, VoucherID
	, TableID
	, VoucherDate
	, VoucherNo
	, VoucherTypeID
	, ObjectID
	, VDescription
	, BDescription
	, LastModifyDate
	, LastModifyUserID
	, CurrencyID
	, ExchangeRate
	, InventoryID
	, UnitID
	, UnitPrice
	, Quantity
	, ConvertedAmount
	, OriginalAmount
	, OriginalAmountCN
	, CurrencyIDCN
	, ExchangeRateCN
	, DebitAccountID
	, CreditAccountID
	, Ana01ID
	, Ana02ID
	, Ana03ID
	, Ana04ID
	, Ana05ID
	, Ana06ID
	, Ana07ID
	, Ana08ID
	, Ana09ID
	, Ana10ID
	, TDescription
	, OrderID
	, PeriodID
	, ProductID
	, OTransactionID
	, MOrderID
	, SOrderID
	, UParameter01
	, UParameter02
	, UParameter03
	, UParameter04
	, UParameter05
	, MarkQuantity
	, ConvertedQuantity
FROM AT9000 WITH (NOLOCK)
WHERE TableID IN ('AT2006', 'MT0810', 'AT0112')
AND EXISTS (
			SELECT 1 
			FROM AT20071 WITH (NOLOCK) 
			WHERE 
				DivisionID = AT9000.DivisionID 
			AND TranYear = AT9000.TranYear
			AND TranMonth = AT9000.TranMonth 
			AND TableID IN ('AT2006', 'MT0810', 'AT0112') 
			AND KindVoucherID NOT IN (3,10)
			And RDVoucherID = AT9000.VoucherID 
			AND TransactionID = AT9000.TransactionID 
			AND TableID = AT9000.TableID
			)
)

UPDATE T90
SET VoucherDate = T07.RDVoucherDate
		, VoucherNo = T07.RDVoucherNo
		, VoucherTypeID = T07.VoucherTypeID
		, ObjectID = T07.ObjectID
		, VDescription = T07.Description
		, BDescription = T07.Description
		, LastModifyDate = T07.LastModifyDate
		, LastModifyUserID = T07.LastModifyUserID
		, CurrencyID = T07.CurrencyID
		, ExchangeRate = T07.ExchangeRate
		, InventoryID = T07.InventoryID
		, UnitID = T07.UnitID
		, UnitPrice = T07.UnitPrice
		, Quantity = T07.NewQuantity
		, ConvertedAmount = T07.NewConvertedAmount
		, OriginalAmount = T07.OriginalAmount
		, OriginalAmountCN = T07.OriginalAmount
		, CurrencyIDCN = T07.CurrencyID
		, ExchangeRateCN = T07.ExchangeRate
		, DebitAccountID = T07.DebitAccountID_New
		, CreditAccountID = T07.CreditAccountID_New
		, Ana01ID = T07.Ana01ID
		, Ana02ID = T07.Ana02ID
		, Ana03ID = T07.Ana03ID
		, Ana04ID = T07.Ana04ID
		, Ana05ID = T07.Ana05ID
		, Ana06ID = T07.Ana06ID
		, Ana07ID = T07.Ana07ID
		, Ana08ID = T07.Ana08ID
		, Ana09ID = T07.Ana09ID
		, Ana10ID = T07.Ana10ID
		, TDescription = T07.Notes
		, OrderID = T07.OrderID
		, PeriodID = (CASE WHEN ISNULL(T07.OldPeriodID, '') = ISNULL(T07.NewPeriodID, '') THEN T90.PeriodID ELSE T07.NewPeriodID END)
		, ProductID = (CASE WHEN ISNULL(T07.OldProductID, '') = ISNULL(T07.NewProductID, '') THEN T90.ProductID ELSE T07.NewProductID END)
		, OTransactionID = T07.OTransactionID
		, MOrderID = T07.MOrderID
		, SOrderID = T07.SOrderID
		, UParameter01 = T07.Parameter01
		, UParameter02 = T07.Parameter02
		, UParameter03 = T07.Parameter03
		, UParameter04 = T07.Parameter04
		, UParameter05 = T07.Parameter05
		, MarkQuantity = T07.NewMarkQuantity
		, ConvertedQuantity = T07.NewConvertedQuantity
FROM (
		SELECT * from AT20071 WITH (NOLOCK) 
		WHERE 
			TableID IN ('AT2006', 'MT0810', 'AT0112') 
			AND KindVoucherID NOT IN (3,10)
	) T07
INNER JOIN T90 ON T90.TransactionID = T07.TransactionID 
					AND T90.VoucherID = T07.RDVoucherID 
					AND T90.TableID = T07.TableID

--- II. Cập nhật AT0114 cho trường hợp TTĐD, FIFO, quản lý theo lô, ngày hết hạn
----- Cập nhật số dư thực tế đích danh cho phiếu xuất
IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE ReVoucherID_OLD <> ReVoucherID)-- Trường hợp update chọn lại chứng từ nhập
BEGIN
	-- Cập nhật số dư thực tế đích danh cho phiếu nhập cũ
	UPDATE T14
	SET 
	DeQuantity = ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0),
	EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0))
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.ReVoucherID_OLD
						, AT20071.ReTransactionID_OLD
						, AT20071.SourceNo
						, AT20071.OldQuantity				
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				WHERE AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
						AND (AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1 OR AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.ReVoucherID_OLD 
		AND T14.ReTransactionID = T07.ReTransactionID_OLD

	-- Cập nhật số dư thực tế đích danh cho phiếu nhập mới
	UPDATE T14
	SET 
	DeQuantity = ISNULL(DeQuantity,0) + ISNULL(T07.NewQuantity,0),
	EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) + ISNULL(T07.NewQuantity,0))
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT	AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.ReVoucherID
						, AT20071.ReTransactionID
						, AT20071.SourceNo
						, AT20071.NewQuantity				
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				WHERE AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
							AND (AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1 OR AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.ReVoucherID 
		AND T14.ReTransactionID = T07.ReTransactionID			   	
END
ELSE
IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE ReVoucherID_OLD = ReVoucherID AND (ReTransactionID <> ReTransactionID_OLD))-- Trường hợp update chọn lại lô nhập, mặt hàng
BEGIN
	-- Cập nhật lại số lượng cho lô nhập cũ
	UPDATE T14
	SET 
	DeQuantity = ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0),
	EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0))	
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT	AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.ReVoucherID
						, AT20071.ReTransactionID
						, AT20071.ReTransactionID_OLD
						, AT20071.SourceNo
						, AT20071.SourceNo_OLD
						, AT20071.NewQuantity
						, AT20071.OldQuantity				
				FROM AT20071 WITH (NOLOCK)
				Inner Join AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				WHERE AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
						AND (AT1302.IsSource = 1 
						OR AT1302.IsLimitDate = 1 
						OR AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.ReVoucherID 
		AND T14.ReTransactionID = T07.ReTransactionID_OLD
	
	-- Cập nhật số lượng cho lô nhập mới
	UPDATE T14
	SET 
	DeQuantity = ISNULL(DeQuantity,0) + ISNULL(T07.NewQuantity,0),
	EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) + ISNULL(T07.NewQuantity,0))	
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (Select	AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.ReVoucherID
						, AT20071.ReTransactionID
						, AT20071.ReTransactionID_OLD
						, AT20071.SourceNo
						, AT20071.SourceNo_OLD
						, AT20071.NewQuantity
						, AT20071.OldQuantity				
				From AT20071 WITH (NOLOCK)
				Inner Join AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				Where AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
							AND (AT1302.IsSource = 1 Or AT1302.IsLimitDate = 1 or AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.ReVoucherID 
		AND T14.ReTransactionID = T07.ReTransactionID
END
ELSE
BEGIN
	UPDATE T14
	SET 
	DeQuantity = ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0) + ISNULL(T07.NewQuantity,0),
	--ReQuantity = T07.NewQuantity, 
	--EndQuantity = ISNULL(T07.NewQuantity, 0) - ISNULL(DeQuantity, 0),
	EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0) + ISNULL(T07.NewQuantity,0))--,
	--DeMarkQuantity = T07.NewMarkQuantity, 
	--EndMarkQuantity = ISNULL(T07.NewMarkQuantity, 0) - ISNULL(DeMarkQuantity, 0),
	--EndMarkQuantity = ISNULL(ReMarkQuantity, 0) - ISNULL(T07.NewMarkQuantity, 0),
	--UnitPrice = T07.UnitPrice, 
	--ReVoucherDate = T07.ReVoucherDate, 
	--ReVoucherNo = T07.ReVoucherNo,
	--ReTransactionID = T07.ReTransactionID,
	--ReSourceNo = T07.SourceNo
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT	AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.ReVoucherID
						, AT20071.ReTransactionID
						, AV7000.VoucherNo AS ReVoucherNo
						, AV7000.VoucherDate AS ReVoucherDate
						, AT20071.RDVoucherDate
						, AT20071.RDVoucherNo
						, AT20071.SourceNo
						, AT20071.NewQuantity
						, AT20071.OldQuantity
						, AT20071.NewMarkQuantity
						, AT20071.UnitPrice					
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				LEFT JOIN AV7000 ON AT20071.ReVoucherID = AV7000.VoucherID
				Where AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
						AND (AT1302.IsSource = 1 Or AT1302.IsLimitDate = 1 or AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.ReVoucherID 
		AND T14.ReTransactionID = T07.ReTransactionID

	--- Huỳnh Thử [28/08/2020]: Update lại SL xuất và tồn cuối cho phiếu nhập trong AT0114
	UPDATE T14 SET T14.DeQuantity =  ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0) + ISNULL(T07.NewQuantity,0),
			       T14.EndQuantity = ISNULL(ReQuantity, 0) - (ISNULL(DeQuantity,0) - ISNULL(T07.OldQuantity,0) + ISNULL(T07.NewQuantity,0))
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT	AT20071.DivisionID
						, AT20071.WareHouseID
						, AT20071.WareHouseID2
						, AT20071.ReVoucherID
						, AT20071.ReTransactionID
						, AV7000.VoucherNo AS ReVoucherNo
						, AV7000.VoucherDate AS ReVoucherDate
						, AT20071.RDVoucherDate
						, AT20071.RDVoucherNo
						, AT20071.SourceNo
						, AT20071.NewQuantity
						, AT20071.OldQuantity
						, AT20071.NewMarkQuantity
						, AT20071.UnitPrice					
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				LEFT JOIN AV7000 ON AT20071.ReVoucherID = AV7000.VoucherID
				Where AT20071.KindVoucherID IN (2,3,4,6,8,10,14,20) 
						AND (AT1302.IsSource = 1 Or AT1302.IsLimitDate = 1 or AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID2
		AND T14.ReVoucherID = T07.ReVoucherID 
		AND T14.ReTransactionID = T07.ReTransactionID
END
----- Cập nhật số dư thực tế đích danh cho phiếu nhập
--UPDATE T14
--SET DeQuantity = ISNULL(DeQuantity, 0) - ISNULL(T07.OldQuantity, 0) + ISNULL(T07.NewQuantity, 0), 
--	EndQuantity = ISNULL(EndQuantity, 0) + ISNULL(T07.OldQuantity, 0) - ISNULL(T07.NewQuantity, 0),
--	DeMarkQuantity = ISNULL(DeMarkQuantity, 0) - ISNULL(T07.OldMarkQuantity, 0) + ISNULL(T07.NewMarkQuantity, 0), 
--	EndMarkQuantity = ISNULL(EndMarkQuantity, 0) + ISNULL(T07.OldMarkQuantity, 0) - ISNULL(T07.NewMarkQuantity, 0)
--FROM AT0114 T14 WITH (ROWLOCK)
--INNER JOIN (Select AT20071.DivisionID, WareHouseID2, ReVoucherID, ReTransactionID, OldQuantity, NewQuantity, OldMarkQuantity, NewMarkQuantity 			
--			From AT20071 WITH (NOLOCK)
--			Inner Join AT1302 WITH (NOLOCK) On AT20071.InventoryID = AT1302.InventoryID AND AT20071.DivisionID = AT1302.DivisionID
--			Where AT20071.KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) And (AT1302.IsSource = 1 Or AT1302.IsLimitDate = 1 or AT1302.MethodID IN (1, 2, 3))
--			) T07
--ON T14.DivisionID = T07.DivisionID AND T14.WareHouseID = T07.WareHouseID2 AND T14.ReVoucherID = T07.ReVoucherID AND T14.ReTransactionID = T07.ReTransactionID

IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE InventoryID = InventoryID_OLD) -- Phiếu nhập không thay đổi mặt hàng
	UPDATE T14
	SET ReQuantity = ISNULL(T07.NewQuantity, 0), 
		EndQuantity = ISNULL(T07.NewQuantity, 0) - ISNULL(T14.DeQuantity,0),
		UnitPrice = ISNULL(T07.UnitPrice,0),
		T14.ReSourceNo = T07.SourceNo
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT AT20071.DivisionID
						, WareHouseID
						, RDVoucherID
						, TransactionID
						, OldQuantity
						, NewQuantity
						, UnitPrice
						, SourceNo		
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID 
				WHERE AT20071.KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) 
						AND (AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1 OR AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.RDVoucherID 
		AND T14.ReTransactionID = T07.TransactionID
ELSE --- Thay đổi mặt hàng
	UPDATE T14
	SET T14.InventoryID = T07.InventoryID,
		T14.ReQuantity = ISNULL(T07.NewQuantity, 0),
		T14.DeQuantity = 0, 
		T14.EndQuantity = ISNULL(T07.NewQuantity, 0),
		T14.UnitPrice = ISNULL(T07.UnitPrice,0),
		T14.ReSourceNo = T07.SourceNo
	FROM AT0114 T14 WITH (ROWLOCK)
	INNER JOIN (SELECT AT20071.DivisionID
						, WareHouseID
						, RDVoucherID
						, TransactionID
						, AT1302.InventoryID
						, NewQuantity
						, UnitPrice
						, SourceNo		
				FROM AT20071 WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT20071.DivisionID,'@@@') AND AT20071.InventoryID = AT1302.InventoryID
				WHERE AT20071.KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) 
						AND (AT1302.IsSource = 1 Or AT1302.IsLimitDate = 1 or AT1302.MethodID IN (1, 2, 3))
				) T07
	ON T14.DivisionID = T07.DivisionID 
		AND T14.WareHouseID = T07.WareHouseID 
		AND T14.ReVoucherID = T07.RDVoucherID 
		AND T14.ReTransactionID = T07.TransactionID

--- III. XL thay AP0600
----- 1. Trường hợp nhập kho
-------- Không thay đổi TK nợ
UPDATE T08
SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)) - ISNULL(T08.CreditQuantity,0),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_New
					, WareHouseID
					, SUM(OldQuantity) as OldQuantity
					, SUM(NewQuantity) as NewQuantity
					, SUM(OldConvertedAmount) as OldConvertedAmount
					, SUM(NewConvertedAmount) as NewConvertedAmount
			From AT20071 WITH (NOLOCK) 
			WHERE Isnull(TableID,'') <> 'AT0114' 
					AND KindVoucherID in (1,5,7,9,15,17) 
					AND DebitAccountID_Old = DebitAccountID_New
			GROUP BY DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	and T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_New
	
-------- Có thay đổi TK nợ
UPDATE T08
SET 	T08.DebitQuantity 	=	isnull(T08.DebitQuantity,0)	- isnull(T07.OldQuantity,0),
		T08.DebitAmount 	=	isnull(T08.DebitAmount,0)	- Isnull(T07.OldConvertedAmount,0),
		T08.EndQuantity		=	isnull(T08.BeginQuantity,0) + (isnull(T08.DebitQuantity,0)	- isnull(T07.OldQuantity,0)) - isnull(T08.CreditQuantity,0),
		T08.EndAmount		=	isnull(T08.BeginAmount,0) + (isnull(T08.DebitAmount,0)	- Isnull(T07.OldConvertedAmount,0)) - isnull(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (Select	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_Old
					, WareHouseID
					, SUM(OldQuantity) as OldQuantity
					, SUM(OldConvertedAmount) as OldConvertedAmount	
			FROM AT20071 WITH (NOLOCK) 
			WHERE Isnull(TableID,'') <> 'AT0114' 
				AND KindVoucherID in (1,5,7,9,15,17) And DebitAccountID_Old <> DebitAccountID_New
			GROUP BY DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_Old, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID =T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_Old
	
UPDATE T08
SET 	T08.DebitQuantity 	=	isnull(T08.DebitQuantity,0)	+ isnull(T07.NewQuantity,0),
		T08.DebitAmount 	=	isnull(T08.DebitAmount,0)	+ Isnull(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	isnull(T08.BeginQuantity,0) + (isnull(T08.DebitQuantity,0)	+ isnull(T07.NewQuantity,0)) - isnull(T08.CreditQuantity,0),
		T08.EndAmount		=	isnull(T08.BeginAmount,0) + (isnull(T08.DebitAmount,0)	+ Isnull(T07.NewConvertedAmount,0)) - isnull(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (Select	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_New
					, WareHouseID
					, SUM(NewQuantity) AS NewQuantity
					, SUM(NewConvertedAmount) as NewConvertedAmount
			From AT20071 WITH (NOLOCK) 
			WHERE Isnull(TableID,'') <> 'AT0114' 
					AND KindVoucherID in (1,5,7,9,15,17) 
					AND DebitAccountID_Old <> DebitAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_New

INSERT AT2008 
(
	InventoryID
	, WareHouseID
	, TranMonth
	, TranYear
	, DivisionID
	, InventoryAccountID
	, BeginQuantity
	, BeginAmount
	, DebitQuantity
	, DebitAmount
	, CreditQuantity
	, CreditAmount
	, EndQuantity
	, EndAmount
)
SELECT	InventoryID
		, WareHouseID
		, TranMonth
		, TranYear
		, DivisionID
		, DebitAccountID_New
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
FROM AT20071 WITH (NOLOCK)
WHERE Isnull(TableID,'') <> 'AT0114' 
		AND KindVoucherID in (1,5,7,9,15,17) 
		AND DebitAccountID_Old <> DebitAccountID_New
AND NOT EXISTS (
				SELECT 1 
				FROM AT2008 WITH (NOLOCK) 
				WHERE DivisionID = AT20071.DivisionID 
						AND TranMonth = AT20071.TranMonth 
						AND TranYear = AT20071.TranYear
						AND InventoryID = AT20071.InventoryID 
						AND WareHouseID = AT20071.WareHouseID 
						AND InventoryAccountID = AT20071.DebitAccountID_New
				)
GROUP BY InventoryID, WareHouseID,TranMonth,TranYear, DivisionID, DebitAccountID_New

----- 2. Trường hợp xuất kho
-------- Không thay đổi TK có
UPDATE T08
SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0))
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, CreditAccountID_New
					, WareHouseID
					, SUM(OldQuantity) AS OldQuantity
					, SUM(NewQuantity) AS NewQuantity
					, SUM(OldConvertedAmount) AS OldConvertedAmount
					, SUM(NewConvertedAmount) AS NewConvertedAmount
			From AT20071 WITH (NOLOCK) 
			WHERE Isnull(TableID,'') <> 'AT0114' 
					AND KindVoucherID IN (2,4,6,8,10,14,20) 
					AND CreditAccountID_Old = CreditAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	and T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID =T07.WareHouseID 
	AND T08.InventoryAccountID = T07.CreditAccountID_New

-------- Có thay đổi TK có
UPDATE T08
SET 	T08.CreditQuantity 	=	isnull(T08.CreditQuantity,0)+ isnull(T07.OldQuantity,0),
		T08.CreditAmount 	=	isnull(T08.CreditAmount,0)	+ Isnull(T07.OldConvertedAmount,0),
		T08.EndQuantity		=	isnull(T08.BeginQuantity,0) + isnull(T08.DebitQuantity,0) - (isnull(T08.CreditQuantity,0)	+ isnull(T07.OldQuantity,0)),
		T08.EndAmount		=	isnull(T08.BeginAmount,0) + isnull(T08.DebitAmount,0) - (isnull(T08.CreditAmount,0)	+ Isnull(T07.OldConvertedAmount,0))		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
			, TranMonth
			, TranYear
			, InventoryID
			, CreditAccountID_Old
			, WareHouseID
			, SUM(OldQuantity) AS OldQuantity
			, SUM(OldConvertedAmount) AS OldConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID in (2,4,6,8,10,14,20) 
					AND CreditAccountID_Old <> CreditAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_Old, WareHouseID) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.CreditAccountID_Old
	
UPDATE T08
SET 	T08.CreditQuantity 	=	isnull(T08.CreditQuantity,0)	- isnull(T07.NewQuantity,0),
		T08.CreditAmount 	=	isnull(T08.CreditAmount,0)	- Isnull(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	isnull(T08.BeginQuantity,0) + isnull(T08.DebitQuantity,0) - (isnull(T08.CreditQuantity,0)	- isnull(T07.NewQuantity,0)),
		T08.EndAmount		=	isnull(T08.BeginAmount,0) + isnull(T08.DebitAmount,0) - (isnull(T08.CreditAmount,0)	- Isnull(T07.NewConvertedAmount,0)) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, CreditAccountID_New
					, WareHouseID
					, SUM(NewQuantity) AS NewQuantity
					, SUM(NewConvertedAmount) AS NewConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID IN (2,4,6,8,10,14,20) 
					AND CreditAccountID_Old <> CreditAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.CreditAccountID_New

INSERT AT2008 
(
	InventoryID
	, WareHouseID
	, TranMonth
	, TranYear
	, DivisionID
	, InventoryAccountID
	, BeginQuantity
	, BeginAmount
	, DebitQuantity
	, DebitAmount
	, CreditQuantity
	, CreditAmount
	, EndQuantity
	, EndAmount
)
SELECT InventoryID
		, WareHouseID
		, TranMonth
		, TranYear
		, DivisionID
		, CreditAccountID_New
		, 0
		, 0
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, -SUM(NewQuantity)
		, -SUM(NewConvertedAmount)
FROM AT20071 WITH (NOLOCK)
WHERE Isnull(TableID,'') <> 'AT0114' 
		AND KindVoucherID IN (2,4,6,8,10,14,20) 
		AND CreditAccountID_Old <> CreditAccountID_New
		AND NOT EXISTS (
						SELECT 1 
						FROM AT2008 WITH (NOLOCK) 
						WHERE DivisionID = AT20071.DivisionID 
								AND TranMonth = AT20071.TranMonth 
								AND TranYear = AT20071.TranYear
								AND InventoryID = AT20071.InventoryID 
								AND WareHouseID = AT20071.WareHouseID 
								AND InventoryAccountID = AT20071.CreditAccountID_New
						)
GROUP BY InventoryID
			, WareHouseID
			, TranMonth
			, TranYear
			, DivisionID
			, CreditAccountID_New

----- 3. Trường hợp chuyển kho
-------- 3a. Update cho kho nhập
----------- Không thay đổi TK nợ
UPDATE T08
SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0) - ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.InDebitQuantity  = 	ISNULL(T08.InDebitQuantity,0) - ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.InDebitAmount 	=	ISNULL(T08.InDebitAmount,0) - ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)) - ISNULL(T08.CreditQuantity,0),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_New
					, WareHouseID
					, SUM(OldQuantity) AS OldQuantity
					, SUM(NewQuantity) AS NewQuantity
					, SUM(OldConvertedAmount) AS OldConvertedAmount
					, SUM(NewConvertedAmount) AS NewConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
				AND KindVoucherID = 3 
				AND DebitAccountID_Old = DebitAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	and T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_New
	
----------- Có thay đổi TK nợ
UPDATE T08
SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0),
		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0),
		T08.InDebitQuantity =	ISNULL(T08.InDebitQuantity,0) - ISNULL(T07.OldQuantity,0),
		T08.InDebitAmount 	=	ISNULL(T08.InDebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0)) - ISNULL(T08.CreditQuantity,0),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_Old
					, WareHouseID
					, SUM(OldQuantity) AS OldQuantity
					, SUM(OldConvertedAmount) AS OldConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID = 3 
					AND DebitAccountID_Old <> DebitAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_Old, WareHouseID) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_Old
	
UPDATE T08
SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	+ ISNULL(T07.NewQuantity,0),
		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0),
		T08.InDebitQuantity =	ISNULL(T08.InDebitQuantity,0)	+ ISNULL(T07.NewQuantity,0),
		T08.InDebitAmount 	=	ISNULL(T08.InDebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	+ ISNULL(T07.NewQuantity,0)) - ISNULL(T08.CreditQuantity,0),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, DebitAccountID_New
					, WareHouseID
					, SUM(NewQuantity) AS NewQuantity
					, SUM(NewConvertedAmount) AS NewConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID = 3 
					AND DebitAccountID_Old <> DebitAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID 
	AND T08.InventoryAccountID = T07.DebitAccountID_New

INSERT AT2008 
(
	InventoryID
	, WareHouseID
	, TranMonth
	, TranYear
	, DivisionID
	, InventoryAccountID
	, BeginQuantity
	, BeginAmount
	, DebitQuantity
	, DebitAmount
	, CreditQuantity
	, CreditAmount
	, InDebitQuantity
	, InDebitAmount
	, EndQuantity
	, EndAmount
)
SELECT InventoryID
		, WareHouseID
		, TranMonth
		, TranYear
		, DivisionID
		, DebitAccountID_New
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
FROM AT20071 WITH (NOLOCK)
WHERE ISNULL(TableID,'') <> 'AT0114' 
		AND KindVoucherID = 3 
		AND DebitAccountID_Old <> DebitAccountID_New
AND NOT EXISTS (Select 1 
				FROM AT2008 WITH (NOLOCK) 
				WHERE DivisionID = AT20071.DivisionID 
						AND TranMonth = AT20071.TranMonth 
						AND TranYear = AT20071.TranYear
						AND InventoryID = AT20071.InventoryID 
						AND WareHouseID = AT20071.WareHouseID 
						AND InventoryAccountID = AT20071.DebitAccountID_New
				)
GROUP BY InventoryID, WareHouseID,TranMonth,TranYear, DivisionID, DebitAccountID_New

-------- 3b. Update cho kho xuất
----------- Không thay đổi TK có
UPDATE T08
SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.InCreditQuantity =	ISNULL(T08.InCreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
		T08.InCreditAmount 	=	ISNULL(T08.InCreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0))
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT	DivisionID
			, TranMonth
			, TranYear
			, InventoryID
			, CreditAccountID_New
			, WareHouseID2
			, SUM(OldQuantity) AS OldQuantity
			, SUM(NewQuantity) AS NewQuantity
			, SUM(OldConvertedAmount) AS OldConvertedAmount
			, SUM(NewConvertedAmount) AS NewConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID = 3 
					AND CreditAccountID_Old = CreditAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID2) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID2 
	AND T08.InventoryAccountID = T07.CreditAccountID_New

----------- Có thay đổi TK có
UPDATE T08
SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)+ ISNULL(T07.OldQuantity,0),
		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	+ ISNULL(T07.OldConvertedAmount,0),
		T08.InCreditQuantity =	ISNULL(T08.InCreditQuantity,0)+ ISNULL(T07.OldQuantity,0),
		T08.InCreditAmount 	=	ISNULL(T08.InCreditAmount,0)+ ISNULL(T07.OldConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	+ ISNULL(T07.OldQuantity,0)),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	+ ISNULL(T07.OldConvertedAmount,0))		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, CreditAccountID_Old
					, WareHouseID2
					, SUM(OldQuantity) AS OldQuantity
					, SUM(OldConvertedAmount) AS OldConvertedAmount
			From AT20071 WITH (NOLOCK) 
			WHERE Isnull(TableID,'') <> 'AT0114' 
					AND KindVoucherID = 3 
					AND CreditAccountID_Old <> CreditAccountID_New
			GROUP BY DivisionID
						, TranMonth
						, TranYear
						, InventoryID
						, CreditAccountID_Old
						, WareHouseID2
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID =T07.WareHouseID2 
	AND T08.InventoryAccountID = T07.CreditAccountID_Old
	
UPDATE T08
SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.NewQuantity,0),
		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	- ISNULL(T07.NewConvertedAmount,0),
		T08.InCreditQuantity 	=	ISNULL(T08.InCreditQuantity,0)	- ISNULL(T07.NewQuantity,0),
		T08.InCreditAmount 	=	ISNULL(T08.InCreditAmount,0)	- ISNULL(T07.NewConvertedAmount,0),
		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.NewQuantity,0)),
		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	- ISNULL(T07.NewConvertedAmount,0)) 		
FROM AT2008 T08 WITH (ROWLOCK)
INNER JOIN (SELECT DivisionID
					, TranMonth
					, TranYear
					, InventoryID
					, CreditAccountID_New
					, WareHouseID2
					, SUM(NewQuantity) AS NewQuantity
					, SUM(NewConvertedAmount) AS NewConvertedAmount
			FROM AT20071 WITH (NOLOCK) 
			WHERE ISNULL(TableID,'') <> 'AT0114' 
					AND KindVoucherID = 3 
					AND CreditAccountID_Old <> CreditAccountID_New
			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID2
			) T07
ON T08.DivisionID = T07.DivisionID 
	AND T08.TranMonth = T07.TranMonth 
	AND T08.TranYear = T07.TranYear
	AND T08.InventoryID = T07.InventoryID 
	AND T08.WareHouseID = T07.WareHouseID2 
	AND T08.InventoryAccountID = T07.CreditAccountID_New

INSERT AT2008 
(
	InventoryID
	, WareHouseID
	, TranMonth
	, TranYear
	, DivisionID
	, InventoryAccountID
	, BeginQuantity
	, BeginAmount
	, DebitQuantity
	, DebitAmount
	, CreditQuantity
	, CreditAmount
	, InCreditQuantity
	, InCreditAmount
	, EndQuantity
	, EndAmount
)
SELECT InventoryID
		, WareHouseID2
		, TranMonth
		, TranYear
		, DivisionID
		, CreditAccountID_New
		, 0
		, 0
		, 0
		, 0
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, SUM(NewQuantity)
		, SUM(NewConvertedAmount)
		, -SUM(NewQuantity)
		, -SUM(NewConvertedAmount)
FROM AT20071 WITH (NOLOCK)
WHERE Isnull(TableID,'') <> 'AT0114' 
		AND KindVoucherID = 3 
		AND CreditAccountID_Old <> CreditAccountID_New
		AND NOT EXISTS (SELECT 1 
						FROM AT2008 WITH (NOLOCK) 
						WHERE DivisionID = AT20071.DivisionID 
								AND TranMonth = AT20071.TranMonth 
								AND TranYear = AT20071.TranYear
								AND InventoryID = AT20071.InventoryID 
								AND WareHouseID = AT20071.WareHouseID2 
								AND InventoryAccountID = AT20071.CreditAccountID_New
						)
GROUP BY InventoryID, WareHouseID2,TranMonth,TranYear, DivisionID, CreditAccountID_New
				

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
