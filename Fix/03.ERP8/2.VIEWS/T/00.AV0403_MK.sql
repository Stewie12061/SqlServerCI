IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0403_MK]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0403_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created on 09/06/2022 by Văn Tài: Đăng ký khởi tạo.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE VIEW [dbo].[AV0403_MK] as 

SELECT '' As GiveUpID, AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, 
	   AT90.CurrencyID, AT90.ObjectID, AT12.ObjectName,  AT90.CreditAccountID, AT90.ExchangeRate, 
	   ISNULL(AT90.OriginalAmount,0) AS OriginalAmount, 
       ISNULL(AT90.ConvertedAmount,0) AS ConvertedAmount,
       AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
       AT90.VDescription, AT90.BDescription, AT90.[Status], AT90.Ana01ID,        
       ISNULL(AT90.OriginalAmountCN,0) AS OriginalAmountCN,        
	   AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate,
      CASE WHEN (SELECT TOP 1 1 FROM dbo.CustomerIndex WHERE CustomerName IN (50,115)) = 1 THEN SUM(ISNULL(AT04.OriginalAmount,0))  ELSE (SUM(ISNULL(AT04.OriginalAmount,0)) - SUM(ISNULL(AT44.OriginalAmount,0))) END  AS GivedOriginalAmount, 
	  CASE WHEN (SELECT TOP 1 1 FROM dbo.CustomerIndex WHERE CustomerName IN (50,115)) = 1 THEN SUM(ISNULL(AT04.ConvertedAmount,0)) ELSE (SUM(ISNULL(AT04.ConvertedAmount,0)) - SUM(ISNULL(AT44.ConvertedAmount,0))) END  AS GivedConvertedAmount, 
      AT90.DebitBankAccountID, AT90.CreditBankAccountID,
	  AT90.InheritTableID
FROM
(
	SELECT AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID, 
		   AT90.CreditObjectID AS ObjectID, AT90.CreditAccountID, ISNULL(AT90.ExchangeRate,0) AS ExchangeRate, 
		   SUM(ISNULL(AT90.OriginalAmount,0)) AS OriginalAmount, 
		   SUM(ISNULL(AT90.ConvertedAmount,0)) AS ConvertedAmount,
		   AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
		   AT90.VDescription, AT90.VDescription AS BDescription, ISNULL(AT90.[Status],0) AS [Status], 
		   MAX(AT90.Ana01ID) AS Ana01ID,        
		   SUM(ISNULL(AT90.OriginalAmountCN,0)) AS OriginalAmountCN,        
		   ISNULL(AT90.ExchangeRateCN,0) AS ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate,
		   AT90.DebitBankAccountID, AT90.CreditBankAccountID,
		   AT90.InheritTableID 
	FROM AT9000 AT90
	INNER JOIN AT1005 AT15 ON AT15.AccountID = AT90.CreditAccountID 
			  AND AT15.GroupID = 'G04' AND ISNULL(AT15.IsObject,0) = 1
	WHERE AT90.TransactionTypeID = 'T99'
	GROUP BY AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID,
			 AT90.CreditObjectID, AT90.CreditAccountID,AT90.ExchangeRate, 
			 AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
			 AT90.VDescription, AT90.[Status], AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID,
			 AT90.InheritTableID

	UNION ALL 

	SELECT AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID, 
		   AT90.ObjectID AS ObjectID, AT90.CreditAccountID, ISNULL(AT90.ExchangeRate,0) AS ExchangeRate, 
		   SUM(ISNULL(AT90.OriginalAmount,0)) AS OriginalAmount, 
		   SUM(ISNULL(AT90.ConvertedAmount,0)) AS ConvertedAmount,
		   AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
		   AT90.VDescription, AT90.VDescription AS BDescription, ISNULL(AT90.[Status],0) AS [Status], 
		   MAX(AT90.Ana01ID) AS Ana01ID,        
		   SUM(ISNULL(AT90.OriginalAmountCN,0)) AS OriginalAmountCN,        
		   ISNULL(AT90.ExchangeRateCN,0) AS ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate,
		   AT90.DebitBankAccountID, AT90.CreditBankAccountID,
		   AT90.InheritTableID
	FROM AT9000 AT90
	INNER JOIN AT1005 AT15 ON AT15.AccountID = AT90.CreditAccountID 
			  AND AT15.GroupID = 'G04' AND ISNULL(AT15.IsObject,0) = 1
	WHERE AT90.TransactionTypeID <> 'T99' 
	GROUP BY AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID,
			 AT90.ObjectID, AT90.CreditAccountID,AT90.ExchangeRate, 
			 AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
			 AT90.VDescription, AT90.[Status], AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID,
			 AT90.InheritTableID
) AS AT90
LEFT JOIN AT0404 AT04 ON AT04.DivisionID = AT90.DivisionID AND AT04.ObjectID = AT90.ObjectID 
		  AND AT04.CreditVoucherID = AT90.VoucherID AND AT04.CreditBatchID = AT90.BatchID 
		  AND AT04.CreditTableID = AT90.TableID AND AT04.AccountID = AT90.CreditAccountID 
		  AND AT04.CurrencyID = AT90.CurrencyIDCN
LEFT JOIN AT0404 AT44 ON AT44.DivisionID = AT90.DivisionID AND AT44.ObjectID = AT90.ObjectID 
		  AND AT44.DebitVoucherID = AT90.VoucherID AND AT44.DebitBatchID = AT90.BatchID
		  AND AT44.DebitTableID = AT90.TableID AND AT44.AccountID = AT90.CreditAccountID 
		  AND AT44.CurrencyID = AT90.CurrencyIDCN
		  AND AT44.ConvertedAmount <> 0
LEFT JOIN AT1202 AT12 ON AT12.DivisionID IN (AT90.DivisionID, '@@@') AND AT12.ObjectID = AT90.ObjectID
GROUP BY AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID,
		 AT90.ObjectID, AT12.ObjectName, AT90.CreditAccountID,AT90.ExchangeRate, AT90.OriginalAmount, AT90.ConvertedAmount,
		 AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
         AT90.VDescription, AT90.BDescription, AT90.[Status], AT90.Ana01ID, AT90.OriginalAmountCN,
         AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID,
		 AT90.InheritTableID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

