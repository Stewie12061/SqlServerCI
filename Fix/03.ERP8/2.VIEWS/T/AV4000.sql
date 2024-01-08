IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV4000]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV4000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Edit by: Dang Le Bao Quynh; Date: 26/11/2009
-- Purpose: Lay gia tri ObjectName cho truong Object_Address
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW [dbo].[AV4000] --view chet in so cai
AS
SELECT 	AT9000.DivisionID, VoucherID, TableID, BatchID, TransactionID,  Case When TransactionTypeID ='T14' then 'T04' else  TransactionTypeID End as TransactionTypeID,
		DebitAccountID AS AccountID, 
		isnull(CreditAccountID,'') AS CorAccountID, 
		'D' AS D_C, 
		DebitAccountID, 
		isnull(CreditAccountID,'') AS CreditAccountID, 
		VoucherDate,  
		VoucherTypeID, VoucherNo, 
		InvoiceDate, 
		isnull(InvoiceNo,'') as InvoiceNo, isnull(Serial,'') as Serial, 
		InventoryID,
		Quantity,
		ConvertedAmount, 
		OriginalAmount, 
		AT9000.CurrencyID, 
		ExchangeRate, ConvertedAmount as  SignAmount, 
		OriginalAmount as OSignAmount, 
		--ReportingAmount as SignReporting,
		TranMonth, TranYear,  
		AT9000.CreateUserID, AT9000.CreateDate,
		VDescription, BDescription, TDescription,
		AT9000.ObjectID,  AT9000.VATObjectID, AT9000.VATNo, VATObjectName, AT1202.ObjectName as Object_Address, 
		VATTypeID, VATGroupID,
		Ana01ID, Ana02ID, Ana03ID, ProductID
FROM AT9000
		Left Join AT1202 On AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.ObjectID = AT1202.ObjectID
WHERE DebitAccountID IS NOT NULL AND DebitAccountID <> ''

UNION ALL
SELECT 	AT9000.DivisionID, VoucherID, TableID, BatchID, TransactionID, Case When TransactionTypeID ='T14' then 'T04' else  TransactionTypeID End as TransactionTypeID,
		CreditAccountID AS AccountID, 
		isnull(DebitAccountID,'') AS CorAccountID, 'C' AS D_C, 
		isnull(DebitAccountID,'') as DebitAccountID, 
		CreditAccountID, 
		VoucherDate,  VoucherTypeID, VoucherNo, 
		InvoiceDate, isnull(InvoiceNo,'') as InvoiceNo, isnull(Serial,'') as Serial, 
		InventoryID,
		Quantity,
		ConvertedAmount , 
		OriginalAmount, 
		AT9000.CurrencyID, 
		ExchangeRate, (ConvertedAmount)*-1 AS SignAmount, OriginalAmount*-1 as OSignAmount, 		
		TranMonth, TranYear, 
		AT9000.CreateUserID, AT9000.CreateDate,		
		VDescription, BDescription, TDescription,
		AT9000.ObjectID,  AT9000.VATObjectID, AT9000.VATNo, VATObjectName, AT1202.ObjectName as Object_Address, 
		VATTypeID,   VATGroupID,
		Ana01ID, Ana02ID, Ana03ID, ProductID
FROM AT9000
		Left Join AT1202 On AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.ObjectID = AT1202.ObjectID
WHERE CreditAccountID IS NOT NULL AND CreditAccountID <> ''

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


