IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV4444]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV4444]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created by Nguyen Van Nhan.
----- View chet phuc vu viec tat toan cong trinh ( Chi hien th? các bút toán dã du?c xác d?nh cho mã phân tích 1)
----- Edit by: Nguyen Quoc Huy, Date: 28/03/2007
----- Modidied by Tiểu Mai on 01/06/2016: Bỏ left join AT1202 vì AV4301 đã bổ sung trường ObjectName
----- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
----- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW [dbo].[AV4444] as 
SELECT 	AV4301.DivisionID, VoucherID, '' as TransactionID, 	TransactionTypeID,  VoucherTypeID,
	AccountID, 	CorAccountID,	D_C, Quantity,
	ConvertedAmount, OriginalAmount, AV4301.CurrencyID, ExchangeRate, 
	TranMonth, TranYear, VoucherNo, VoucherDate, Serial, InvoiceNo, InvoiceDate, 
	Description, null as coefficientID,
	AV4301.ObjectID,
	InventoryID, UnitID,
	isnull(Ana01ID,'') as Ana01ID,
	isnull(Ana02ID,'') as Ana02ID,
	isnull(Ana03ID,'') as Ana03ID,
	isnull(Ana04ID,'') as Ana04ID,
	isnull(Ana05ID,'') as Ana05ID,
	isnull(Ana06ID,'') as Ana06ID,
	isnull(Ana07ID,'') as Ana07ID,
	isnull(Ana08ID,'') as Ana08ID,
	isnull(Ana09ID,'') as Ana09ID,
	isnull(Ana10ID,'') as Ana10ID,
	BudgetID,
	(Case When D_C ='D' then AccountID else CorAccountID end ) as DebitAccountID,
	(Case When D_C ='C' then AccountID else CorAccountID end ) as CreditAccountID,
	ObjectName,
	SignAmount AS SignAmount, 
	'AT9000' As TableID
FROM AV4301
Where isnull(Ana01ID,'')<>''

Union All

SELECT T91.DivisionID,VoucherID,  TransactionID, '' as TransactionTypeID,  VoucherTypeID,	
	DebitAccountID as AccountID, 	CreditAccountID as CorAccountID,	
	'D' as D_C, 0 as Quantity,
	ConvertedAmount, OriginalAmount, T91.CurrencyID, ExchangeRate, 
	TranMonth, TranYear, VoucherNo, VoucherDate, Serial, InvoiceNo, InvoiceDate, 
	Description,	coefficientID,
	T91.ObjectID,
	null as InventoryID, 
	null as UnitID,
	isnull(Ana01ID,'') as Ana01ID,
	isnull(Ana02ID,'') as Ana02ID,
	isnull(Ana03ID,'') as Ana03ID,
	isnull(Ana04ID,'') as Ana04ID,
	isnull(Ana05ID,'') as Ana05ID,
	isnull(Ana06ID,'') as Ana06ID,
	isnull(Ana07ID,'') as Ana07ID,
	isnull(Ana08ID,'') as Ana08ID,
	isnull(Ana09ID,'') as Ana09ID,
	isnull(Ana10ID,'') as Ana10ID,
	'AA' as BudgetID,
	DebitAccountID,
	CreditAccountID,
	ObjectName,
	Round(ConvertedAmount,2) AS SignAmount, 
	'AT9001' As TableID
FROM AT9001  T91  left join AT1202 on AT1202.DivisionID IN (T91.DivisionID, '@@@') AND AT1202.ObjectID =  T91.ObjectID
WHERE DebitAccountID IS NOT NULL AND DebitAccountID <> '' and
	 DebitAccountID in (Select AccountID From AT1005 Where GroupID in ('G06','G07') )

Union All

SELECT T91.DivisionID, VoucherID, TransactionID, '' as TransactionTypeID,  VoucherTypeID,	
	CreditAccountID as AccountID, 	DebitAccountID as CorAccountID,	
	'C' as D_C, 0 as Quantity,
	ConvertedAmount, OriginalAmount, T91.CurrencyID, ExchangeRate, 
	TranMonth, TranYear, VoucherNo, VoucherDate, Serial, InvoiceNo, InvoiceDate, 
	Description,	coefficientID,
	T91.ObjectID,
	null as InventoryID, 
	null as UnitID,
	isnull(Ana01ID,'') as Ana01ID,
	isnull(Ana02ID,'') as Ana02ID,
	isnull(Ana03ID,'') as Ana03ID,
	isnull(Ana04ID,'') as Ana04ID,
	isnull(Ana05ID,'') as Ana05ID,
	isnull(Ana06ID,'') as Ana06ID,
	isnull(Ana07ID,'') as Ana07ID,
	isnull(Ana08ID,'') as Ana08ID,
	isnull(Ana09ID,'') as Ana09ID,
	isnull(Ana10ID,'') as Ana10ID,
	'AA' as BudgetID,
	DebitAccountID,
	CreditAccountID,
	ObjectName,
	Round(ConvertedAmount,2) AS SignAmount, 
	'AT9001' As TableID
FROM AT9001  T91  left join AT1202 on AT1202.DivisionID IN (T91.DivisionID, '@@@') AND AT1202.ObjectID =  T91.ObjectID
WHERE  CreditAccountID IS NOT NULL AND CreditAccountID <> '' and
	 CreditAccountID in (Select AccountID From AT1005 Where GroupID in ('G06','G07') )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


