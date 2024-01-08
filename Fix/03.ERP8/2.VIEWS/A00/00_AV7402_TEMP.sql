IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7402]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7402]    Script Date: 18/07/2020 11:17:06 ******/
---- Modified by Văn Tài on 18/07/2020: Chỉnh sửa danh mục dùng chung
---- Modified by Nhựt Trường on 30/06/2021: Fix lỗi Ambiguous column name 'VoucherDate'.
 CREATE VIEW AV7402 -- Được tạo từ Store AP7402, fix ban đầu để chạy tools
 AS 
	SELECT TransactionID
		, BatchID
		, VoucherID
		, TableID
		, D3.DivisionID
		, TranMonth
		, TranYear
		, '00' AS RPTransactionType
		, TransactionTypeID
		, D3.ObjectID
		, DebitAccountID
		, CreditAccountID
		, DebitAccountID AS AccountID
		, VoucherNo
		, VoucherTypeID
		, D3.VoucherDate
		, InvoiceNo
		, ISNULL(InvoiceDate, D3.VoucherDate) AS InvoiceDate
		, Serial
		, VDescription
		, BDescription
		, TDescription
		, (CASE WHEN ISNULL(D3.CurrencyIDCN, '') = '' THEN A00.CurrencyID ELSE D3.CurrencyIDCN END) AS CurrencyID
		, ExchangeRate
		, OriginalAmountCN AS OriginalAmount
		, ConvertedAmount
		, OriginalAmountCN AS SignOriginalAmount
		, ConvertedAmount AS SignConvertedAmount
		, Status
	FROM AT9000 D3 WITH (NOLOCK) 
	LEFT JOIN AT0000 A00 WITH (NOLOCK) ON ISNULL(D3.DivisionID, '') = ISNULL(A00.DefDivisionID, '')
	INNER JOIN AT1005 WITH (NOLOCK) ON ISNULL(AT1005.AccountID, '') = ISNULL(D3.DebitAccountID, '')
	LEFT JOIN AT0401_CBD AT04 WITH (NOLOCK) ON ISNULL(AT04.ObjectID, '') != ''
												AND ISNULL(AT04.ID, '') = '3cd2dcca-00e8-47d8-b5ce-f443eb9694fd' 
												AND ISNULL(AT04.ObjectID, '') = ISNULL(D3.ObjectID, '') 
	LEFT JOIN AT0401_CBD AT042 WITH (NOLOCK) ON ISNULL(AT042.AccountID, '') != ''
												AND ISNULL(AT042.ID, '') = '3cd2dcca-00e8-47d8-b5ce-f443eb9694fd' 
												AND ISNULL(AT042.AccountID, '') = ISNULL(D3.DebitAccountID, '') 
	WHERE ISNULL(AT04.ObjectID, '') <> ''
		AND ISNULL(AT042.AccountID, '')  <> ''
		AND ISNULL(AT1005.GroupID, '') = 'G03'
		AND ISNULL(D3.DivisionID, '')  IN ('CBD') 
		AND (CASE WHEN ISNULL(D3.CurrencyIDCN, '') = ''
					THEN A00.CurrencyID 
					ELSE D3.CurrencyIDCN 
				END) LIKE 'VND'
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
