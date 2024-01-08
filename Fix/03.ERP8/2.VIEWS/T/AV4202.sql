IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV4202]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV4202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---Text                                                                                                                                                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


-----View chet
----- Phuc vu cong no
---- Modified by on 15/10/2014 by Huỳnh Tấn Phú : Bổ sung điều kiện lọc theo 10 mã phân tích. 0022751: [VG] In số dư đầu kỳ lên sai dẫn đến số dư cuối kỳ sai.
---- Modified by on 05/05/2016 by Thị Phượng: Bổ sung With (Nolock) để tránh tình trạng deadlock
---- Modified by Bảo Thy on 24/05/2017: Sửa danh mục dùng chung
---- Modified by Kim Thư on 12/03/2019: Bổ sung thêm OriginalAmount và ExchangeRateCN
---- Modified by Văn Minh on 10/01/2020: Bổ sung OrderDate
---- Modified by Nhựt Trường on 02/11/2021: Bổ sung ISNULL() khi lấy mã phân tích.

CREATE VIEW [dbo].[AV4202] as 	
SELECT 	AT9000.ObjectID,  		---- PHAT SINH NO
		CurrencyIDCN,VoucherDate, InvoiceDate, AT9000.DueDate,
		AT9000.DivisionID, DebitAccountID AS AccountID, InventoryID,
		sum(isnull(OriginalAmount,0)) AS OriginalAmount,
		SUM(isnull(ConvertedAmount,0)) AS ConvertedAmount, 
		sum(isnull(OriginalAmountCN,0)) AS OriginalAmountCN,
		ExchangeRateCN,
		AT9000.TranMonth,AT9000.TranYear, 
		CreditAccountID AS CorAccountID,   -- tai khoan doi ung
		'D' AS D_C, TransactionTypeID,
		ISNULL(AT9000.Ana01ID,'') AS Ana01ID,ISNULL(AT9000.Ana02ID,'') AS Ana02ID,ISNULL(AT9000.Ana03ID,'') AS Ana03ID,ISNULL(AT9000.Ana04ID,'') AS Ana04ID,ISNULL(AT9000.Ana05ID,'') AS Ana05ID,
		ISNULL(AT9000.Ana06ID,'') AS Ana06ID,ISNULL(AT9000.Ana07ID,'') AS Ana07ID,ISNULL(AT9000.Ana08ID,'') AS Ana08ID,ISNULL(AT9000.Ana09ID,'') AS Ana09ID,ISNULL(AT9000.Ana10ID,'') AS Ana10ID,
		OT2001.OrderDate
FROM AT9000 with (NOLOCK) 
inner join AT1005 on AT1005.AccountID = AT9000.DebitAccountID
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT9000.DivisionID AND OT2001.SOrderID = AT9000.OrderID
WHERE DebitAccountID IS NOT NULL and AT1005.GroupID  in ('G03', 'G04')
GROUP BY AT9000.ObjectID,AT9000.Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, AT9000.DueDate, AT9000.DivisionID, DebitAccountID, 
	AT9000.TranMonth, AT9000.TranYear, CreditAccountID, TransactionTypeID, InventoryID
		,AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID
	,AT9000.ExchangeRateCN	,OT2001.OrderDate

UNION ALL

------------------- So phat sinh co, lay am
SELECT				---- PHAT SINH CO 
	(Case when TransactionTypeID ='T99' then CreditObjectID else AT9000.ObjectID end) as ObjectID, 
	CurrencyIDCN,VoucherDate, InvoiceDate, AT9000.DueDate,
	AT9000.DivisionID, CreditAccountID AS AccountID, InventoryID,
	sum(isnull(OriginalAmount,0)*-1) AS OriginalAmount,
	SUM(isnull(ConvertedAmount,0)*-1) AS ConvertedAmount, 
	sum(isnull(OriginalAmountCN,0)*-1) AS OriginalAmountCN,
	ExchangeRateCN,
	AT9000.TranMonth, AT9000.TranYear, 
	DebitAccountID AS CorAccountID, 
	'C' AS D_C, TransactionTypeID,
	ISNULL(AT9000.Ana01ID,'') AS Ana01ID,ISNULL(AT9000.Ana02ID,'') AS Ana02ID,ISNULL(AT9000.Ana03ID,'') AS Ana03ID,ISNULL(AT9000.Ana04ID,'') AS Ana04ID,ISNULL(AT9000.Ana05ID,'') AS Ana05ID,
	ISNULL(AT9000.Ana06ID,'') AS Ana06ID,ISNULL(AT9000.Ana07ID,'') AS Ana07ID,ISNULL(AT9000.Ana08ID,'') AS Ana08ID,ISNULL(AT9000.Ana09ID,'') AS Ana09ID,ISNULL(AT9000.Ana10ID,'') AS Ana10ID,
	OT2001.OrderDate
FROM AT9000 with (NOLOCK) 
inner join AT1005 on AT1005.AccountID = AT9000.CreditAccountID
LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = AT9000.DivisionID AND OT2001.SOrderID = AT9000.OrderID
WHERE CreditAccountID IS NOT NULL  and AT1005.GroupID in ('G03', 'G04')
GROUP BY (Case when TransactionTypeID ='T99' then CreditObjectID else AT9000.ObjectID end), AT9000.Ana01ID,
	CurrencyIDCN, VoucherDate, InvoiceDate, AT9000.DueDate, AT9000.DivisionID, CreditAccountID, 
	AT9000.TranMonth, AT9000.TranYear, DebitAccountID, TransactionTypeID, InventoryID,
	AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID
	,AT9000.ExchangeRateCN		,OT2001.OrderDate


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
