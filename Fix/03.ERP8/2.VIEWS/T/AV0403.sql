IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0403]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0403]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created By Nguyen Van Nhan, Sunday 09/11/2003.
----- Purpose Loc cac  hoa  don phat sinh Co cong no phat tra, group theo transactionTypeID
----- Cac truong nhan biet: VoucherID, BatchID,TableID,ObjectID,DebitAccountID,
----Edit By Thien Huynh (13/02/2012): Nhom cac dong cung Hoa don (BatchID) thanh 1 dong, 
----khong nhom theo cac tieu chi khac (Khoan muc, TransactionTypeID)
---- Modified on 06/02/2015 by Lê Thị Hạnh: Sửa trường hợp T99 bị hiển thị nhiều dòng trường hợp bút toán tổng hợp T99
---- Modified by Tiểu Mai on 23/06/2017: Bổ sung trường DebitBankAccountID, CreditBankAccountID 
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified on 15/03/2018 by Bảo Anh: Sửa lỗi số tiền giải trừ sai khi có phát sinh giải trừ cho phần chênh lệch tỷ giá
---- Modified on 17/07/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE
---- Modified on 26/04/2021 by Nhựt Trường: Bổ sung trường ExchangeRateNew.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE VIEW [dbo].[AV0403] as 
/*
SELECT '' As GiveUpID, VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	Case When MAX(TransactionTypeID) ='T99' then AT9000.CreditObjectID else AT9000.ObjectID End as ObjectID,
	CreditAccountID, AT9000.CurrencyID, CurrencyIDCN,
	Case when MAX(TransactionTypeID) = 'T99' then B.ObjectName else A.ObjectName end as ObjectName,
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID =  (Case when MAX(AT9000.TransactionTypeID) ='T99' then AT9000.CreditObjectID else AT9000.ObjectID end) and
										CreditVoucherID = AT9000.VoucherID and
										CreditBatchID = AT9000.BatchID and
										CreditTableID = At9000.TableID and
										AccountID = AT9000.CreditAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0)- isnull((Select Sum(isnull(OriginalAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID =  (Case when MAX(AT9000.TransactionTypeID) ='T99' then AT9000.CreditObjectID else AT9000.ObjectID end) and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.CreditAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0),
	GivedConvertedAmount = isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID =  (Case when MAX(AT9000.TransactionTypeID) ='T99' then AT9000.CreditObjectID else AT9000.ObjectID end) and
										CreditVoucherID = AT9000.VoucherID and
										CreditBatchID = AT9000.BatchID and
										CreditTableID = At9000.TableID and
										AccountID = AT9000.CreditAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0) -
							isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0404 Where 	DivisionID = AT9000.DivisionID and
										ObjectID =  (Case when MAX(AT9000.TransactionTypeID) ='T99' then AT9000.CreditObjectID else AT9000.ObjectID end) and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.CreditAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0),							
	ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, VDescription as BDescription,	Status, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate,
	MAX(Ana01ID) As Ana01ID
FROM AT9000  	
		Left join AT1202 A  on A.ObjectID = AT9000.ObjectID and A.DivisionID = AT9000.DivisionID
		Left join AT1202  B on B.ObjectID = AT9000.CreditObjectID and B.DivisionID = AT9000.DivisionID
WHERE CreditAccountID in (Select AccountID From AT1005 Where GroupID ='G04' and  IsObject =1)
Group by VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear, 
	AT9000.ObjectID, AT9000.CreditObjectID, CreditAccountID, AT9000.CurrencyID, CurrencyIDCN, A.ObjectName, B.ObjectName, 
	ExchangeRate,ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, Status, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate
*/

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
      AT90.DebitBankAccountID, AT90.CreditBankAccountID, AT90.ExchangeRateNew
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
	   AT90.DebitBankAccountID, AT90.CreditBankAccountID, NULL AS ExchangeRateNew 
FROM AT9000 AT90
INNER JOIN AT1005 AT15 ON AT15.AccountID = AT90.CreditAccountID 
	      AND AT15.GroupID = 'G04' AND ISNULL(AT15.IsObject,0) = 1
WHERE AT90.TransactionTypeID = 'T99'
GROUP BY AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID,
		 AT90.CreditObjectID, AT90.CreditAccountID,AT90.ExchangeRate, 
		 AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
         AT90.VDescription, AT90.[Status], AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID                 
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
	   AT90.DebitBankAccountID, AT90.CreditBankAccountID,(SELECT  TOP 1 ExchangeRate FROM AT9000  WITH (NOLOCK) 
														 WHERE DivisionID = AT90.DivisionID AND TransactionTypeID = 'T09'
														 AND ObjectID = AT90.ObjectID AND CurrencyID = AT90.CurrencyID AND (CreditAccountID = AT90.CreditAccountID OR DebitAccountID = AT90.CreditAccountID)
														 AND AT90.VoucherDate <= AT9000.VoucherDate
														 ORDER BY CreateDate DESC) ExchangeRateNew
FROM AT9000 AT90
INNER JOIN AT1005 AT15 ON AT15.AccountID = AT90.CreditAccountID 
	      AND AT15.GroupID = 'G04' AND ISNULL(AT15.IsObject,0) = 1
WHERE AT90.TransactionTypeID <> 'T99' 
GROUP BY AT90.DivisionID, AT90.VoucherID, AT90.BatchID, AT90.TableID, AT90.TranMonth, AT90.TranYear, AT90.CurrencyID,
		 AT90.ObjectID, AT90.CreditAccountID,AT90.ExchangeRate, 
		 AT90.VoucherDate, AT90.InvoiceDate, AT90.VoucherTypeID, AT90.VoucherNo, AT90.Serial, AT90.InvoiceNo,
         AT90.VDescription, AT90.[Status], AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID 
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
         AT90.ExchangeRateCN, AT90.CurrencyIDCN, AT90.DueDays, AT90.PaymentID, AT90.DueDate, AT90.DebitBankAccountID, AT90.CreditBankAccountID, AT90.ExchangeRateNew
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

