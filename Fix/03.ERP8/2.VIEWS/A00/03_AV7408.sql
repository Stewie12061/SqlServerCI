-- <Summary>
---- Script view d?ng AV7408.
-- <History>
---- Create on 10/09/2020 by Van Tài
---- Modified on ... by ...
---- <Example>
IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[AV7408]')
          AND OBJECTPROPERTY(id, N'IsView') = 1
)
    DROP VIEW [dbo].[AV7408];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO
CREATE VIEW AV7408 --Created by AP7408
AS
SELECT V18.GroupID,
       V18.BatchID,
       V18.VoucherID,
       V18.TableID,
       V18.Status,
       V18.DivisionID,
       V18.TranMonth,
       V18.TranYear,
       V18.RPTransactionType,
       V18.TransactionTypeID,
       V18.ObjectID,
       V18.ObjectName,
       V18.Address,
       VATNo,
       S1,
       S2,
       S3,
       Tel,
       Fax,
       Email,
       O01ID,
       O02ID,
       O03ID,
       O04ID,
       O05ID,
       V18.DebitAccountID,
       V18.CreditAccountID,
       V18.AccountID,
       AccountName,
       (
           SELECT TOP 1
                  AccountNameE
           FROM AT1005
           WHERE DivisionID = V18.DivisionID
                 AND AccountID = V18.AccountID
       ) AccountNameE,
       V18.VoucherTypeID,
       V18.VoucherNo,
       V18.VoucherDate,
       V18.InvoiceNo,
       V18.InvoiceDate,
       V18.Serial,
       V18.VDescription,
       V18.BDescription,
       V18.TDescription,
       V18.Ana01ID,
       V18.Ana02ID,
       V18.Ana03ID,
       V18.Ana04ID,
       V18.Ana05ID,
       V18.Ana06ID,
       V18.Ana07ID,
       V18.Ana08ID,
       V18.Ana09ID,
       V18.Ana10ID,
       V18.Ana01Name,
       V18.Ana02Name,
       V18.Ana03Name,
       V18.Ana04Name,
       V18.Ana05Name,
       V18.Ana06Name,
       V18.Ana07Name,
       V18.Ana08Name,
       V18.Ana09Name,
       V18.Ana10Name,
       V18.CurrencyID,
       V18.ExchangeRate,
       SUM(ISNULL(V18.DebitOriginalAmount, 0)) AS DebitOriginalAmount,
       SUM(ISNULL(V18.CreditOriginalAmount, 0)) AS CreditOriginalAmount,
       SUM(ISNULL(V18.DebitConvertedAmount, 0)) AS DebitConvertedAmount,
       SUM(ISNULL(V18.CreditConvertedAmount, 0)) AS CreditConvertedAmount,
       OpeningOriginalAmount,
       V18.OpeningConvertedAmount,
       SUM(ISNULL(V18.SignConvertedAmount, 0)) AS SignConvertedAmount,
       SUM(ISNULL(V18.SignOriginalAmount, 0)) AS SignOriginalAmount,
       V18.ClosingOriginalAmount,
       V18.ClosingConvertedAmount,
       CAST(V18.TranMonth AS NVARCHAR) + '/' + CAST(V18.TranYear AS NVARCHAR) AS MonthYear,
       CONVERT(VARCHAR(20), V18.Duedate, 103) AS duedate,
       '11/08/2020' AS Fromdate,
       (CASE
            WHEN 4 = 4 THEN
                '30/7/2020'
            ELSE
                '11/08/2020'
        END
       ) AS Todate,
       V18.Parameter01,
       V18.Parameter02,
       V18.Parameter03,
       V18.Parameter04,
       V18.Parameter05,
       V18.Parameter06,
       V18.Parameter07,
       V18.Parameter08,
       V18.Parameter09,
       V18.Parameter10,
       V18.Amount01Ana04ID,
	   '' AS Note
FROM AV7418 V18
WHERE V18.DebitOriginalAmount <> 0
      OR V18.CreditOriginalAmount <> 0
      OR V18.DebitConvertedAmount <> 0
      OR V18.CreditConvertedAmount <> 0
      OR V18.OpeningOriginalAmount <> 0
      OR V18.OpeningConvertedAmount <> 0
GROUP BY V18.GroupID,
         V18.BatchID,
         V18.VoucherID,
         V18.TableID,
         V18.Status,
         V18.DivisionID,
         V18.TranMonth,
         V18.TranYear,
         V18.RPTransactionType,
         V18.TransactionTypeID,
         V18.ObjectID,
         V18.ObjectName,
         V18.Address,
         VATNo,
         S1,
         S2,
         S3,
         Tel,
         Fax,
         Email,
         O01ID,
         O02ID,
         O03ID,
         O04ID,
         O05ID,
         V18.DebitAccountID,
         V18.CreditAccountID,
         V18.AccountID,
         V18.VoucherTypeID,
         V18.VoucherNo,
         V18.VoucherDate,
         V18.OpeningOriginalAmount,
         V18.OpeningConvertedAmount,
         V18.InvoiceNo,
         V18.InvoiceDate,
         V18.Serial,
         V18.VDescription,
         V18.BDescription,
         V18.TDescription,
         V18.Ana01ID,
         V18.Ana02ID,
         V18.Ana03ID,
         V18.Ana04ID,
         V18.Ana05ID,
         V18.Ana06ID,
         V18.Ana07ID,
         V18.Ana08ID,
         V18.Ana09ID,
         V18.Ana10ID,
         CurrencyID,
         V18.ExchangeRate,
         ObjectName,
         AccountName,
         ClosingOriginalAmount,
         ClosingConvertedAmount,
         V18.Duedate,
         V18.Ana01Name,
         V18.Ana02Name,
         V18.Ana03Name,
         V18.Ana04Name,
         V18.Ana05Name,
         V18.Ana06Name,
         V18.Ana07Name,
         V18.Ana08Name,
         V18.Ana09Name,
         V18.Ana10Name,
         V18.Parameter01,
         V18.Parameter02,
         V18.Parameter03,
         V18.Parameter04,
         V18.Parameter05,
         V18.Parameter06,
         V18.Parameter07,
         V18.Parameter08,
         V18.Parameter09,
         V18.Parameter10,
         V18.Amount01Ana04ID;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
