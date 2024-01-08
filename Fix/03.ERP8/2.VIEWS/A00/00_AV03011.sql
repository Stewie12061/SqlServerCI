IF EXISTS
(
    SELECT *
    FROM sys.views
    WHERE object_id = OBJECT_ID(N'[dbo].[AV03011]')
)
    DROP VIEW [dbo].[AV03011];
GO



/****** Object:  View [dbo].[AV0301]    Script Date: 08/12/2013 11:17:06 ******/
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 01/07/2020: Bỏ Group theo Mã Phân tích A01->A05
---- Modified by Nhựt Trường on 26/04/2021: Bổ sung trường ExchangeRateNew.
---- Modified by Nhựt Trường on 13/05/2021: Bỏ điều kiện theo GivedConvertedAmount và GivedOriginalAmount khi join bảng T3.
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW [dbo].[AV03011]
AS
SELECT A.ExchangeRateNew,
	   A.GiveUpID,
       A.VoucherID,
       A.BatchID,
       A.TableID,
       A.DivisionID,
       A.TranMonth,
       A.TranYear,
       A.ObjectID,
       A.DebitAccountID,
       A.CurrencyID,
       A.CurrencyIDCN,
       A.ObjectName,
       A.OriginalAmount + A.VATOriginalAmount AS OriginalAmount,
       A.ConvertedAmount + A.VATConvertedAmount AS ConvertedAmount,
       A.OriginalAmountCN + A.VATOriginalAmount AS OriginalAmountCN,
       ISNULL(T3.GivedOriginalAmount, 0) AS GivedOriginalAmount,
       ISNULL(T3.GivedConvertedAmount, 0) AS GivedConvertedAmount,
       A.ExchangeRate,
       A.ExchangeRateCN,
       A.VoucherTypeID,
       A.VoucherNo,
       A.VoucherDate,
       A.InvoiceDate,
       A.InvoiceNo,
       A.Serial,
       A.VDescription,
       A.BDescription,
       A.Status,
       A.PaymentID,
       A.DueDays,
       A.DueDate
FROM
(
    SELECT 
		   (SELECT  TOP 1 AT90.ExchangeRate FROM AT9000 AT90  WITH (NOLOCK) 
											WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.TransactionTypeID = 'T09'
											AND AT90.ObjectID = AT9000.ObjectID AND AT90.CurrencyID = AT9000.CurrencyID AND (AT90.CreditAccountID = AT9000.DebitAccountID OR AT90.DebitAccountID = AT9000.DebitAccountID)
											AND AT9000.VoucherDate <= AT90.VoucherDate
											ORDER BY AT90.CreateDate DESC) ExchangeRateNew,
		   '' AS GiveUpID,
           VoucherID,
           BatchID,
           TableID,
           AT9000.DivisionID,
           TranMonth,
           TranYear,
           AT9000.ObjectID,
           DebitAccountID,
           AT9000.CurrencyID,
           CurrencyIDCN,
           AT1202.ObjectName,
           (
               SELECT MAX(IsMultiTax)
               FROM AT9000 T90
               WHERE T90.DivisionID = AT9000.DivisionID
                     AND T90.VoucherID = AT9000.VoucherID
           ) AS IsMultiTax,
           TransactionTypeID,
           SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount,
           SUM(ISNULL(VATOriginalAmount, 0)) AS VATOriginalAmount,
           SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount,
           SUM(ISNULL(VATConvertedAmount, 0)) AS VATConvertedAmount,
           SUM(ISNULL(OriginalAmountCN, 0)) AS OriginalAmountCN,
           ExchangeRate,
           ExchangeRateCN,
           VoucherTypeID,
           VoucherNo,
           VoucherDate,
           InvoiceDate,
           InvoiceNo,
           Serial,
           VDescription,
           VDescription AS BDescription,
           0 AS Status,
           AT9000.PaymentID,
           AT9000.DueDays,
           AT9000.DueDate
    FROM AT9000
        LEFT JOIN AT1202
            ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT1202.ObjectID = AT9000.ObjectID
    WHERE DebitAccountID IN
          (
              SELECT AccountID FROM AT1005 WHERE GroupID = 'G03' AND IsObject = 1
          )
    GROUP BY VoucherID,
             BatchID,
             TableID,
             AT9000.DivisionID,
             TranMonth,
             TranYear,
             AT9000.ObjectID,
             DebitAccountID,
             AT9000.CurrencyID,
             CurrencyIDCN,
             AT1202.ObjectName,
             ExchangeRate,
             ExchangeRateCN,
             VoucherTypeID,
             VoucherNo,
             VoucherDate,
             InvoiceDate,
             InvoiceNo,
             Serial,
             VDescription,
             AT9000.PaymentID,
             AT9000.DueDays,
             AT9000.DueDate,
             TransactionTypeID
) A
    LEFT JOIN
    (
        SELECT SUM(ISNULL(T03.ConvertedAmount, 0)) AS GivedConvertedAmount,
               SUM(ISNULL(T03.OriginalAmount, 0)) AS GivedOriginalAmount,
               T03.ObjectID,
               T03.DebitVoucherID,
               T03.DebitBatchID,
               T03.AccountID,
               T03.DivisionID
        FROM AT0303 T03
        GROUP BY T03.ObjectID,
                 T03.DebitVoucherID,
                 T03.DebitBatchID,
                 T03.AccountID,
                 T03.DivisionID
    ) T3
        ON T3.ObjectID = A.ObjectID
           AND T3.DebitVoucherID = A.VoucherID
           AND T3.DebitBatchID = A.BatchID
           AND T3.AccountID = A.DebitAccountID
           AND T3.DivisionID = A.DivisionID
           --AND T3.GivedConvertedAmount = A.ConvertedAmount + A.VATConvertedAmount
           --AND T3.GivedOriginalAmount = A.OriginalAmount + A.VATOriginalAmount
WHERE TransactionTypeID <> 'T14';


