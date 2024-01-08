IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0402]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created By Nguyen Thi Ngoc Minh, 30/09/2004
----- Purpose group cac phat sinh trong view AV0403 theo hoa don
---- Modified by Tiểu Mai on 23/06/2017: Bổ sung trường DebitBankAccountID, CreditBankAccountID
---- Modified on 26/04/2021 by Nhựt Trường: Bổ sung trường ExchangeRateNew.
---- Modified on 12/04/2022 by Nhựt Trường: Customize ANGEL - Không tính lại thành tiền quy đổi.
CREATE VIEW [dbo].[AV0402] as 

SELECT ISNULL(ExchangeRateNew,ExchangeRateCN) AS ExchangeRateNew, GiveUpID, VoucherID, BatchID, TableID, DivisionID, TranMonth, TranYear,
	ObjectID, CreditAccountID, CurrencyID, CurrencyIDCN, ObjectName,
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	CASE WHEN (SELECT TOP 1 CustomerName FROM CustomerIndex) = 57 /*ANGEL*/
		 THEN Sum(isnull(ConvertedAmount,0))
		 ELSE (CASE WHEN ISNULL(ExchangeRateNew,0) <> 0 THEN SUM(OriginalAmount * ExchangeRateNew) ELSE Sum(isnull(ConvertedAmount,0)) END)
	END as ConvertedAmount,
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	isnull(GivedOriginalAmount,0) as GivedOriginalAmount,
	isnull(GivedConvertedAmount,0) as GivedConvertedAmount,
	ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, BDescription,	Status, PaymentID, DueDays, DueDate, Ana01ID, DebitBankAccountID, CreditBankAccountID 
FROM AV0403
Group by GiveUpID, VoucherID, BatchID, TableID, DivisionID, TranMonth, TranYear, 
	ObjectID, CreditAccountID, CurrencyID, CurrencyIDCN, ObjectName, 
	GivedOriginalAmount, GivedConvertedAmount, 
	ExchangeRate,ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, BDescription, Status, PaymentID, DueDays, DueDate, Ana01ID, DebitBankAccountID, CreditBankAccountID, ExchangeRateNew

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

