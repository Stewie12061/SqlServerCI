IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0411]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0411]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--View chet
--Purpose Phat sinh cong no phai tra (Bao cao)
---- Modified on 01/08/2016 by Phuong Thao : Bo sung PaymentExchangeRate
---- Modified on 20/02/2020 by Văn Minh : Bổ sung CreateUserID
---- Modified on 04/05/2020 by Huỳnh Thử : Bổ sung Ana01ID -> Ana10ID
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE VIEW [dbo].[AV0411] as 
SELECT  '' As GiveUpID, VoucherID, BatchID,  TableID, AT9000.DivisionID,TranMonth,TranYear,
	AT9000.ObjectID, DebitAccountID,  AT9000.CurrencyID,  AT9000.CurrencyIDCN,
	AT1202.ObjectName,	
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,	
	ExchangeRate, ExchangeRateCN, PaymentExchangeRate,
	VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
	VDescription,VDescription as BDescription,	Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate,
	AT9000.CreateUserID,AT1405.UserName,
	MAX(AT9000.Ana01ID) AS Ana01ID, MAX(AT9000.Ana02ID) AS Ana02ID, MAX(AT9000.Ana03ID) AS Ana03ID, MAX(AT9000.Ana04ID) AS Ana04ID, MAX(AT9000.Ana05ID) AS Ana05ID,
	MAX(AT9000.Ana06ID) AS Ana06ID, MAX(AT9000.Ana07ID) AS Ana07ID, MAX(AT9000.Ana08ID) AS Ana08ID, MAX(AT9000.Ana09ID) AS Ana09ID, MAX(AT9000.Ana10ID) AS Ana10ID
FROM AT9000 
Left join AT1202 on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = AT9000.CreateUserID
WHERE DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G04' and  IsObject =1)
Group by VoucherID,BatchID,  TableID,AT9000.DivisionID,TranMonth,TranYear,
	AT9000.ObjectID, DebitAccountID,  AT9000.CurrencyID, AT9000.CurrencyIDCN, ExchangeRate,ExchangeRateCN,
	AT1202.ObjectName,
	VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
	VDescription,Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate, PaymentExchangeRate,
	AT9000.CreateUserID,AT1405.UserName
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
