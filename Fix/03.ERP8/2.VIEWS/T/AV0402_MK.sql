IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0402_MK]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0402_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created By Nguyen Thi Ngoc Minh, 30/09/2004
----- Purpose group cac phat sinh trong view AV0403 theo hoa don
---- Modified by Tiểu Mai on 23/06/2017: Bổ sung trường DebitBankAccountID, CreditBankAccountID 
---- Modified by Văn Tài  on 27/01/2021: Tách view cho MEIKO
CREATE VIEW [dbo].[AV0402_MK] as 

SELECT GiveUpID
		, VoucherID
		, BatchID
		, TableID
		, DivisionID
		, TranMonth
		, TranYear
		, ObjectID
		, CreditAccountID
		, CurrencyID
		, CurrencyIDCN
		, ObjectName
		, SUM(ISNULL(OriginalAmount,0)) as OriginalAmount
		, SUM(ISNULL(ConvertedAmount,0)) as ConvertedAmount
		, SUM(ISNULL(OriginalAmountCN,0)) as OriginalAmountCN
		, ISNULL(GivedOriginalAmount,0) as GivedOriginalAmount
		, ISNULL(GivedConvertedAmount,0) as GivedConvertedAmount
		, ExchangeRate
		, ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, VDescription
		, BDescription
		, Status
		, PaymentID
		, DueDays
		, DueDate
		, Ana01ID
		, DebitBankAccountID
		, CreditBankAccountID
		, InheritTableID
FROM AV0403_MK
Group by GiveUpID
	, VoucherID
	, BatchID
	, TableID
	, DivisionID
	, TranMonth
	, TranYear
	, ObjectID
	, CreditAccountID
	, CurrencyID
	, CurrencyIDCN
	, ObjectName
	, GivedOriginalAmount
	, GivedConvertedAmount
	, ExchangeRate
	, ExchangeRateCN
	, VoucherTypeID
	, VoucherNo
	, VoucherDate
	, InvoiceDate
	, InvoiceNo
	, Serial
	, VDescription
	, BDescription
	, Status
	, PaymentID
	, DueDays
	, DueDate
	, Ana01ID
	, DebitBankAccountID
	, CreditBankAccountID 
	, InheritTableID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

