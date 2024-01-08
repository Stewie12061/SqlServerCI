﻿IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[AV03012_MK]'))
DROP VIEW [dbo].[AV03012_MK]
GO



/****** Object:  View [dbo].[AV0301]    Script Date: 08/12/2013 11:17:06 ******/
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AV03012_MK] AS

SELECT '' AS GiveUpID
		, VoucherID
		, BatchID
		, TableID
		, AT9000.DivisionID
		, TranMonth
		, TranYear
		, AT9000.ObjectID
		, DebitAccountID
		, AT9000.CurrencyID
		, CurrencyIDCN
		, AT1202.ObjectName
		, MAX(ISNULL(Ana01ID,'')) As Ana01ID
		, MAX(ISNULL(Ana02ID,'')) As Ana02ID
		, MAX(ISNULL(Ana03ID,'')) As Ana03ID
		, MAX(ISNULL(Ana04ID,'')) As Ana04ID
		, MAX(ISNULL(Ana05ID,'')) As Ana05ID
		, Sum(isnull(OriginalAmount,0)) as OriginalAmount
		, Sum(isnull(ConvertedAmount,0)) as ConvertedAmount
		, Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN
		, GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0303 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN), 
										0)
		, GivedConvertedAmount = isnull((Select Sum(isnull(ConvertedAmount,0)) From AT0303 Where DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),
										0)
		, ExchangeRate
		, ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, VDescription
		, VDescription AS BDescription
		, 0 AS Status
		, AT9000.PaymentID
		, AT9000.DueDays
		, AT9000.DueDate
		, AT9000.InheritTableID
FROM AT9000 LEFT JOIN AT1202 on AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
WHERE DebitAccountID in (Select AccountID From AT1005 Where GroupID ='G03' and  IsObject =1)
Group by VoucherID
		, BatchID
		, TableID
		, AT9000.DivisionID
		, TranMonth
		, TranYear
		, AT9000.ObjectID
		, DebitAccountID
		, AT9000.CurrencyID
		, CurrencyIDCN
		, AT1202.ObjectName
		, ExchangeRate
		, ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, VDescription
		, AT9000.PaymentID
		, AT9000.DueDays
		, AT9000.DueDate
		, AT9000.InheritTableID


