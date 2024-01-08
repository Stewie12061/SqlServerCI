IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[AV03012]'))
DROP VIEW [dbo].[AV03012]
GO



/****** Object:  View [dbo].[AV0301]    Script Date: 08/12/2013 11:17:06 ******/
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Nhựt Trường on 23/04/2021: Bổ sung trường ExchangeRateNew.
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AV03012] AS

SELECT 
	(SELECT  TOP 1 ExchangeRate FROM AT9000  WITH (NOLOCK) 
								WHERE DivisionID = AT90.DivisionID AND TransactionTypeID = 'T09'
								AND ObjectID = AT90.ObjectID AND CurrencyID = AT90.CurrencyID AND (CreditAccountID = AT90.DebitAccountID OR DebitAccountID = AT90.DebitAccountID)
								AND AT90.VoucherDate <= AT9000.VoucherDate
								ORDER BY CreateDate DESC) AS ExchangeRateNew,
	'' AS GiveUpID, VoucherID, BatchID, TableID, AT90.DivisionID, TranMonth, TranYear,
	AT90.ObjectID, DebitAccountID, AT90.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	Max(isnull(Ana01ID,'')) As Ana01ID, Max(isnull(Ana02ID,'')) As Ana02ID, Max(isnull(Ana03ID,'')) As Ana03ID, Max(isnull(Ana04ID,'')) As Ana04ID, Max(isnull(Ana05ID,'')) As Ana05ID, 
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0303 Where 	DivisionID = AT90.DivisionID and
										ObjectID = AT90.ObjectID and
										DebitVoucherID = AT90.VoucherID and
										DebitBatchID = AT90.BatchID and
										DebitTableID = AT90.TableID and
										AccountID = AT90.DebitAccountID and
										CurrencyID = AT90.CurrencyIDCN),0),
	GivedConvertedAmount =isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0303 Where 	DivisionID = AT90.DivisionID and
										ObjectID = AT90.ObjectID and
										DebitVoucherID = AT90.VoucherID and
										DebitBatchID = AT90.BatchID and
										DebitTableID = AT90.TableID and
										AccountID = AT90.DebitAccountID and
										CurrencyID = AT90.CurrencyIDCN),0),
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, VDescription AS BDescription, 0 AS Status,
	AT90.PaymentID, AT90.DueDays, AT90.DueDate
FROM AT9000 AT90 Left join AT1202 on AT1202.DivisionID IN (AT90.DivisionID, '@@@') AND AT1202.ObjectID = AT90.ObjectID
WHERE DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G03' and  IsObject =1)
Group by VoucherID, BatchID, TableID, AT90.DivisionID, TranMonth, TranYear,
	AT90.ObjectID, DebitAccountID, AT90.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, AT90.PaymentID, AT90.DueDays, AT90.DueDate


