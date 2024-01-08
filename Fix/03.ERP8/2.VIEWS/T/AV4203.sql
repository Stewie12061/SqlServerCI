IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV4203]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV4203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



------View chet
------Create By : Dang Le Bao Quynh; Date 04/07/2008
------Purpose: Phuc vu bao cao chi tiet cong no phai thu theo ma phan tich 1
---- Modified by on 05/05/2016 by Thị Phượng: Bổ sung With (Nolock) để tránh tình trạng deadlock
---- Modified by Bảo Thy on 24/05/2017: Sửa danh mục dùng chung
---- Modified by Kim Thư on 12/03/2019: Bổ sung OriginalAmount và ExchageRateCN
---- Modified by Văn Minh on 10/04/2020: Bổ sung OrderDate

CREATE VIEW [dbo].[AV4203] as 	


SELECT     AT9000.ObjectID, AT9000.Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, AT9000.DueDate, AT9000.DivisionID, DebitAccountID AS AccountID, InventoryID, 
                      SUM(isnull(OriginalAmount, 0)) AS OriginalAmount, SUM(isnull(ConvertedAmount, 0)) AS ConvertedAmount, 
					  SUM(isnull(OriginalAmountCN, 0)) AS OriginalAmountCN, AT9000.TranMonth, AT9000.TranYear, 
                      CreditAccountID AS CorAccountID, 'D' AS D_C, TransactionTypeID, ExchangeRateCN, OT2001.OrderDate
FROM         AT9000 with (NOLOCK) 
INNER JOIN AT1005 with (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT9000.DivisionID AND OT2001.VoucherNo = AT9000.OrderID
WHERE     DebitAccountID IS NOT NULL AND AT1005.GroupID IN ('G03', 'G04')
GROUP BY AT9000.ObjectID, AT9000.Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, AT9000.DueDate, AT9000.DivisionID, DebitAccountID, AT9000.TranMonth, AT9000.TranYear, 
								CreditAccountID,        TransactionTypeID, InventoryID, ExchangeRateCN,OT2001.OrderDate
UNION ALL
SELECT     (CASE WHEN TransactionTypeID = 'T99' THEN CreditObjectID ELSE AT9000.ObjectID END) AS ObjectID, AT9000.Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, 
                      AT9000.DueDate, AT9000.DivisionID, CreditAccountID AS AccountID, InventoryID, 
					  SUM(isnull(OriginalAmount, 0) * - 1) AS OriginalAmount, SUM(isnull(ConvertedAmount, 0) * - 1) AS ConvertedAmount, 
                      SUM(isnull(OriginalAmountCN, 0) * - 1) AS OriginalAmountCN, AT9000.TranMonth, AT9000.TranYear, 
					  DebitAccountID AS CorAccountID, 'C' AS D_C, TransactionTypeID, ExchangeRateCN,OT2001.OrderDate
FROM         AT9000 with (NOLOCK)
INNER JOIN  AT1005 with (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT9000.DivisionID AND OT2001.VoucherNo = AT9000.OrderID
WHERE     CreditAccountID IS NOT NULL AND AT1005.GroupID IN ('G03', 'G04')
GROUP BY (CASE WHEN TransactionTypeID = 'T99' THEN CreditObjectID ELSE AT9000.ObjectID END), AT9000.Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, AT9000.DueDate, 
                      AT9000.DivisionID, CreditAccountID, AT9000.TranMonth, AT9000.TranYear, DebitAccountID, TransactionTypeID, InventoryID, ExchangeRateCN,OT2001.OrderDate


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
