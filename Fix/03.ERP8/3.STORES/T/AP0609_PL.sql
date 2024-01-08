IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0609_PL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0609_PL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created on 23/07/2020 by Huỳnh Thử
---- Update AT9000 khi làm tròn giá 
-- <Example>
---- 
---- EXEC AP0609
----
CREATE PROCEDURE [dbo].[AP0609_PL]
AS

--IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE KindVoucherID IN (2,4,6,8,10,14,20))
--BEGIN
------- 2. Trường hợp xuất kho
---------- Không thay đổi TK có
--UPDATE T08
--SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
--		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
--		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)),
--		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0))
--FROM AT2008 T08 WITH (ROWLOCK)
--INNER JOIN (SELECT DivisionID
--					, TranMonth
--					, TranYear
--					, InventoryID
--					, CreditAccountID_New
--					, WareHouseID
--					, SUM(OldQuantity) AS OldQuantity
--					, SUM(NewQuantity) AS NewQuantity
--					, SUM(OldConvertedAmount) AS OldConvertedAmount
--					, SUM(NewConvertedAmount) AS NewConvertedAmount
--			From AT20071 WITH (NOLOCK) 
--			WHERE Isnull(TableID,'') <> 'AT0114' 
--					AND KindVoucherID IN (2,4,6,8,10,14,20) 
--					AND CreditAccountID_Old = CreditAccountID_New
--			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID) T07
--ON T08.DivisionID = T07.DivisionID 
--	AND T08.TranMonth = T07.TranMonth 
--	AND T08.TranYear = T07.TranYear
--	and T08.InventoryID = T07.InventoryID 
--	AND T08.WareHouseID =T07.WareHouseID 
--	AND T08.InventoryAccountID = T07.CreditAccountID_New
	
--END

--IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE KindVoucherID IN (3))
--BEGIN 
------- 3. Trường hợp chuyển kho
---------- 3a. Update cho kho nhập
------------- Không thay đổi TK nợ
--UPDATE T08
--SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
--		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0) - ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
--		T08.InDebitQuantity  = 	ISNULL(T08.InDebitQuantity,0) - ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
--		T08.InDebitAmount 	=	ISNULL(T08.InDebitAmount,0) - ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
--		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)) - ISNULL(T08.CreditQuantity,0),
--		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
--FROM AT2008 T08 WITH (ROWLOCK)
--INNER JOIN (SELECT	DivisionID
--					, TranMonth
--					, TranYear
--					, InventoryID
--					, DebitAccountID_New
--					, WareHouseID
--					, SUM(OldQuantity) AS OldQuantity
--					, SUM(NewQuantity) AS NewQuantity
--					, SUM(OldConvertedAmount) AS OldConvertedAmount
--					, SUM(NewConvertedAmount) AS NewConvertedAmount
--			FROM AT20071 WITH (NOLOCK) 
--			WHERE ISNULL(TableID,'') <> 'AT0114' 
--				AND KindVoucherID = 3 
--				AND DebitAccountID_Old = DebitAccountID_New
--			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
--			) T07
--ON T08.DivisionID = T07.DivisionID 
--	AND T08.TranMonth = T07.TranMonth 
--	AND T08.TranYear = T07.TranYear
--	and T08.InventoryID = T07.InventoryID 
--	AND T08.WareHouseID = T07.WareHouseID 
--	AND T08.InventoryAccountID = T07.DebitAccountID_New
	
----UPDATE T08
----SET 	T08.DebitQuantity 	=	ISNULL(T08.DebitQuantity,0)	+ ISNULL(T07.NewQuantity,0),
----		T08.DebitAmount 	=	ISNULL(T08.DebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0),
----		T08.InDebitQuantity =	ISNULL(T08.InDebitQuantity,0)	+ ISNULL(T07.NewQuantity,0),
----		T08.InDebitAmount 	=	ISNULL(T08.InDebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0),
----		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + (ISNULL(T08.DebitQuantity,0)	+ ISNULL(T07.NewQuantity,0)) - ISNULL(T08.CreditQuantity,0),
----		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + (ISNULL(T08.DebitAmount,0)	+ ISNULL(T07.NewConvertedAmount,0)) - ISNULL(T08.CreditAmount,0) 		
----FROM AT2008 T08 WITH (ROWLOCK)
----INNER JOIN (SELECT	DivisionID
----					, TranMonth
----					, TranYear
----					, InventoryID
----					, DebitAccountID_New
----					, WareHouseID
----					, SUM(NewQuantity) AS NewQuantity
----					, SUM(NewConvertedAmount) AS NewConvertedAmount
----			FROM AT20071 WITH (NOLOCK) 
----			WHERE ISNULL(TableID,'') <> 'AT0114' 
----					AND KindVoucherID = 3 
----					AND DebitAccountID_Old <> DebitAccountID_New
----			Group by DivisionID, TranMonth, TranYear, InventoryID, DebitAccountID_New, WareHouseID
----			) T07
----ON T08.DivisionID = T07.DivisionID 
----	AND T08.TranMonth = T07.TranMonth 
----	AND T08.TranYear = T07.TranYear
----	AND T08.InventoryID = T07.InventoryID 
----	AND T08.WareHouseID = T07.WareHouseID 
----	AND T08.InventoryAccountID = T07.DebitAccountID_New
--END

---------- 3b. Update cho kho xuất
------------- Không thay đổi TK có
--UPDATE T08
--SET 	T08.CreditQuantity 	=	ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
--		T08.CreditAmount 	=	ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
--		T08.InCreditQuantity =	ISNULL(T08.InCreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0),
--		T08.InCreditAmount 	=	ISNULL(T08.InCreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0),
--		T08.EndQuantity		=	ISNULL(T08.BeginQuantity,0) + ISNULL(T08.DebitQuantity,0) - (ISNULL(T08.CreditQuantity,0)	- ISNULL(T07.OldQuantity,0) +  ISNULL(T07.NewQuantity,0)),
--		T08.EndAmount		=	ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	- ISNULL(T07.OldConvertedAmount,0) + ISNULL(T07.NewConvertedAmount,0))
--FROM AT2008 T08 WITH (ROWLOCK)
--INNER JOIN (SELECT	DivisionID
--			, TranMonth
--			, TranYear
--			, InventoryID
--			, CreditAccountID_New
--			, WareHouseID2
--			, SUM(OldQuantity) AS OldQuantity
--			, SUM(NewQuantity) AS NewQuantity
--			, SUM(OldConvertedAmount) AS OldConvertedAmount
--			, SUM(NewConvertedAmount) AS NewConvertedAmount
--			FROM AT20071 WITH (NOLOCK) 
--			WHERE ISNULL(TableID,'') <> 'AT0114' 
--					AND KindVoucherID = 3 
--					AND CreditAccountID_Old = CreditAccountID_New
--			Group by DivisionID, TranMonth, TranYear, InventoryID, CreditAccountID_New, WareHouseID2) T07
--ON T08.DivisionID = T07.DivisionID 
--	AND T08.TranMonth = T07.TranMonth 
--	AND T08.TranYear = T07.TranYear
--	AND T08.InventoryID = T07.InventoryID 
--	AND T08.WareHouseID = T07.WareHouseID2 
--	AND T08.InventoryAccountID = T07.CreditAccountID_New

WITH T90 AS
		(SELECT TransactionID, VoucherID, TableID, VoucherDate, VoucherNo, VoucherTypeID, ObjectID, VDescription, BDescription, LastModifyDate, LastModifyUserID,
				CurrencyID, ExchangeRate, InventoryID, UnitID, UnitPrice, Quantity, ConvertedAmount, OriginalAmount, OriginalAmountCN, CurrencyIDCN, ExchangeRateCN,
				DebitAccountID, CreditAccountID, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
				TDescription, OrderID, PeriodID, ProductID, OTransactionID, MOrderID, SOrderID,
				UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, MarkQuantity, ConvertedQuantity
		FROM AT9000 WITH (NOLOCK)
		WHERE TableID IN ('AT2006', 'MT0810', 'AT0112')
		AND EXISTS (Select * From AT20071 WITH (NOLOCK) where TableID IN ('AT2006', 'MT0810', 'AT0112') AND KindVoucherID Not In (3,10)
					And DivisionID = AT9000.DivisionID And TranMonth = AT9000.TranMonth And TranYear = AT9000.TranYear
					And RDVoucherID = AT9000.VoucherID And TransactionID = AT9000.TransactionID And TableID = AT9000.TableID
					)
		)

		UPDATE T90
		SET VoucherDate = T07.RDVoucherDate, VoucherNo = T07.RDVoucherNo, VoucherTypeID = T07.VoucherTypeID, 
				ObjectID = T07.ObjectID, VDescription = T07.Description, BDescription = T07.Description, 
				LastModifyDate = T07.LastModifyDate, LastModifyUserID = T07.LastModifyUserID, 
				CurrencyID = T07.CurrencyID, ExchangeRate = T07.ExchangeRate, 
				InventoryID = T07.InventoryID, UnitID = T07.UnitID,
				Quantity = T07.NewQuantity, 

				UnitPrice = T07.UnitPrice, 
				ConvertedAmount = T07.NewConvertedAmount, 
				OriginalAmount = T07.OriginalAmount, 
				OriginalAmountCN = T07.OriginalAmount, 

				CurrencyIDCN = T07.CurrencyID, ExchangeRateCN = T07.ExchangeRate, 
				DebitAccountID = T07.DebitAccountID_New, CreditAccountID = T07.CreditAccountID_New, 
				Ana01ID = T07.Ana01ID, Ana02ID = T07.Ana02ID, Ana03ID = T07.Ana03ID, Ana04ID = T07.Ana04ID, Ana05ID = T07.Ana05ID, 
				Ana06ID = T07.Ana06ID, Ana07ID = T07.Ana07ID, Ana08ID = T07.Ana08ID, Ana09ID = T07.Ana09ID, Ana10ID = T07.Ana10ID, 
				TDescription = T07.Notes, 
				OrderID = T07.OrderID, 
				PeriodID = (CASE WHEN ISNULL(T07.OldPeriodID, '') = ISNULL(T07.NewPeriodID, '') THEN T90.PeriodID ELSE T07.NewPeriodID END), 
				ProductID = (CASE WHEN ISNULL(T07.OldProductID, '') = ISNULL(T07.NewProductID, '') THEN T90.ProductID ELSE T07.NewProductID END),    
				OTransactionID = T07.OTransactionID, 
				MOrderID = T07.MOrderID,
				SOrderID = T07.SOrderID,
				UParameter01 = T07.Parameter01, UParameter02 = T07.Parameter02, UParameter03 = T07.Parameter03, UParameter04 = T07.Parameter04, UParameter05 = T07.Parameter05,
				MarkQuantity = T07.NewMarkQuantity, ConvertedQuantity = T07.NewConvertedQuantity
		FROM (Select * from AT20071 WITH (NOLOCK) Where TableID IN ('AT2006', 'MT0810', 'AT0112') AND KindVoucherID Not In (3,10)) T07
		INNER JOIN T90 ON T90.TransactionID = T07.TransactionID AND T90.VoucherID = T07.RDVoucherID AND T90.TableID = T07.TableID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
