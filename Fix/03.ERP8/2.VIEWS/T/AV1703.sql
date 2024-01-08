
/****** Object:  View [dbo].[AV1703]    Script Date: 12/16/2010 14:52:52 ******/
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1703]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1703]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Create by: Dang Le Bao Quynh; Date: 23/04/2007
---- Purpose:  View chet loc du lieu chi tiet cho khai bao phan bo 
---- Modified on 14/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK), thay IN bằng EXISTS

CREATE VIEW [dbo].[AV1703] as 

Select VoucherID,VoucherNo,VoucherDate,VDescription, 
	DebitAccountID as AccountID,
	TranMonth, TranYear, DivisionID,
	ObjectID,Serial,InvoiceNo,InvoiceDate,
	Sum(ConvertedAmount) as ConvertedAmount,
	'D' as D_C
From AT9000 WITH (NOLOCK)
Where  EXISTS (Select TOP 1 1 From AT0006 WITH (NOLOCK) Where D_C = 'D' AND AT9000.DebitAccountID = AccountID)
Group  by VoucherID,VoucherNo,VoucherDate,VDescription, 	TranMonth, TranYear, DivisionID, DebitAccountID, ObjectID,Serial,InvoiceNo,InvoiceDate
Union All
Select VoucherID,VoucherNo,VoucherDate,VDescription, 
	CreditAccountID as AccountID,
	TranMonth, TranYear, DivisionID,
	ObjectID,Serial,InvoiceNo,InvoiceDate,
	Sum(ConvertedAmount) as ConvertedAmount,
	'C' as D_C
From AT9000 WITH (NOLOCK)
Where  Exists (SELECT TOP 1 1 From AT0006 WITH (NOLOCK) Where D_C = 'C' AND  AT9000.CreditAccountID = AccountID)
Group  by VoucherID,VoucherNo,VoucherDate,VDescription, 	TranMonth, TranYear, DivisionID, CreditAccountID,ObjectID,Serial,InvoiceNo,InvoiceDate

GO


