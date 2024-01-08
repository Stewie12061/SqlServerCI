-- <Summary>
---- Script view d?ng AV7405.
-- <History>
---- Create on 10/09/2020 by Van Tài
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- <Example>
IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[AV7405]')
          AND OBJECTPROPERTY(id, N'IsView') = 1
)
    DROP VIEW [dbo].[AV7405];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO
CREATE VIEW AV7405
AS
SELECT AV7415.GroupID,
       AV7415.BatchID,
       AV7415.VoucherID,
       AV7415.TableID,
       AV7415.Status,
       AV7415.DivisionID,
       AV7415.TranMonth,
       AV7415.TranYear,
       AV7415.RPTransactionType,
       AV7415.TransactionTypeID,
       AV7415.ObjectID,
       AV7415.ObjectName,
       AV7415.Address,
       AV7415.VATNo,
       AT1202.S1,
       AT1202.S2,
       AT1202.S3,
       AT1202.Tel,
       AT1202.Fax,
       AT1202.Email,
       AV7415.DebitAccountID,
       A01.AccountName AS DebitAccountName,
       AV7415.CreditAccountID,
       A02.AccountName AS CreditAccountName,
       AV7415.AccountID,
       AV7415.AccountName,
       AV7415.AccountNameE,
       AV7415.VoucherTypeID,
       AV7415.VoucherNo,
       AV7415.VoucherDate,
       AV7415.InvoiceNo,
       AV7415.InvoiceDate,
       AV7415.Serial,
       AV7415.VDescription,
       AV7415.BDescription,
       AV7415.TDescription,
       AV7415.Ana01ID,
       AV7415.Ana02ID,
       AV7415.Ana03ID,
       AV7415.Ana04ID,
       AV7415.Ana05ID,
       AV7415.Ana06ID,
       AV7415.Ana07ID,
       AV7415.Ana08ID,
       AV7415.Ana09ID,
       AV7415.Ana10ID,
       A11.AnaName AS Ana01Name,
       A12.AnaName AS Ana02Name,
       A13.AnaName AS Ana03Name,
       A14.AnaName AS Ana04Name,
       A15.AnaName AS Ana05Name,
       A16.AnaName AS Ana06Name,
       A17.AnaName AS Ana07Name,
       A18.AnaName AS Ana08Name,
       A19.AnaName AS Ana09Name,
       A10.AnaName AS Ana10Name,
       O01ID,
       O02ID,
       O03ID,
       O04ID,
       O05ID,
       AV7415.CurrencyID,
       AV7415.ExchangeRate,
       SUM(DebitOriginalAmount) AS DebitOriginalAmount,
       SUM(CreditOriginalAmount) AS CreditOriginalAmount,
       SUM(DebitConvertedAmount) AS DebitConvertedAmount,
       SUM(CreditConvertedAmount) AS CreditConvertedAmount,
       OpeningOriginalAmount,
       OpeningConvertedAmount,
       SUM(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
       SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
       ClosingOriginalAmount,
       ClosingConvertedAmount,
       CAST(AV7415.TranMonth AS VARCHAR) + '/' + CAST(AV7415.TranYear AS VARCHAR) AS MonthYear,
       CONVERT(VARCHAR(20), AV7415.Duedate, 103) AS duedate,
       '05/08/2020' AS Fromdate,
       (CASE
            WHEN 4 = 0 THEN
                '30/6/2020'
            ELSE
                '05/08/2020'
        END
       ) AS Todate,
       Parameter01,
       Parameter02,
       Parameter03,
       Parameter04,
       Parameter05,
       Parameter06,
       Parameter07,
       Parameter08,
       Parameter09,
       Parameter10,
	   '' AS Note
FROM AV7415
    INNER JOIN AT1202
        ON AT1202.DivisionID IN (AV7415.DivisionID, '@@@') 
		   AND AT1202.ObjectID = AV7415.ObjectID     
    LEFT JOIN AT1005 A01
        ON A01.AccountID = AV7415.DebitAccountID
           AND A01.DivisionID = AV7415.DivisionID
    LEFT JOIN AT1005 A02
        ON A02.AccountID = AV7415.CreditAccountID
           AND A02.DivisionID = AV7415.DivisionID
    LEFT JOIN AT1011 A11
        ON A11.AnaID = AV7415.Ana01ID
           AND A11.DivisionID = AV7415.DivisionID
           AND A11.AnaTypeID = 'A01'
    LEFT JOIN AT1011 A12
        ON A12.AnaID = AV7415.Ana01ID
           AND A12.DivisionID = AV7415.DivisionID
           AND A12.AnaTypeID = 'A02'
    LEFT JOIN AT1011 A13
        ON A13.AnaID = AV7415.Ana01ID
           AND A13.DivisionID = AV7415.DivisionID
           AND A13.AnaTypeID = 'A03'
    LEFT JOIN AT1011 A14
        ON A14.AnaID = AV7415.Ana01ID
           AND A14.DivisionID = AV7415.DivisionID
           AND A14.AnaTypeID = 'A04'
    LEFT JOIN AT1011 A15
        ON A15.AnaID = AV7415.Ana01ID
           AND A15.DivisionID = AV7415.DivisionID
           AND A15.AnaTypeID = 'A05'
    LEFT JOIN AT1011 A16
        ON A16.AnaID = AV7415.Ana01ID
           AND A16.DivisionID = AV7415.DivisionID
           AND A16.AnaTypeID = 'A06'
    LEFT JOIN AT1011 A17
        ON A17.AnaID = AV7415.Ana01ID
           AND A17.DivisionID = AV7415.DivisionID
           AND A17.AnaTypeID = 'A07'
    LEFT JOIN AT1011 A18
        ON A18.AnaID = AV7415.Ana01ID
           AND A18.DivisionID = AV7415.DivisionID
           AND A18.AnaTypeID = 'A08'
    LEFT JOIN AT1011 A19
        ON A19.AnaID = AV7415.Ana01ID
           AND A19.DivisionID = AV7415.DivisionID
           AND A19.AnaTypeID = 'A09'
    LEFT JOIN AT1011 A10
        ON A10.AnaID = AV7415.Ana01ID
           AND A10.DivisionID = AV7415.DivisionID
           AND A10.AnaTypeID = 'A10'
WHERE (
          DebitOriginalAmount <> 0
          OR CreditOriginalAmount <> 0
          OR DebitConvertedAmount <> 0
          OR CreditConvertedAmount <> 0
          OR OpeningOriginalAmount <> 0
          OR OpeningConvertedAmount <> 0
      )
GROUP BY AV7415.GroupID,
         AV7415.BatchID,
         AV7415.VoucherID,
         AV7415.TableID,
         AV7415.Status,
         AV7415.DivisionID,
         AV7415.TranMonth,
         AV7415.TranYear,
         AV7415.RPTransactionType,
         AV7415.TransactionTypeID,
         AV7415.ObjectID,
         AV7415.Address,
         AV7415.VATNo,
         AT1202.S1,
         AT1202.S2,
         AT1202.S3,
         AT1202.Tel,
         AT1202.Fax,
         AT1202.Email,
         AV7415.DebitAccountID,
         AV7415.CreditAccountID,
         AV7415.AccountID,
         AV7415.VoucherTypeID,
         AV7415.VoucherNo,
         AV7415.VoucherDate,
         AV7415.OpeningOriginalAmount,
         AV7415.OpeningConvertedAmount,
         AV7415.InvoiceNo,
         AV7415.InvoiceDate,
         AV7415.Serial,
         AV7415.VDescription,
         AV7415.BDescription,
         AV7415.TDescription,
         AV7415.Ana01ID,
         AV7415.Ana02ID,
         AV7415.Ana03ID,
         AV7415.Ana04ID,
         AV7415.Ana05ID,
         AV7415.Ana06ID,
         AV7415.Ana07ID,
         AV7415.Ana08ID,
         AV7415.Ana09ID,
         AV7415.Ana10ID,
         A11.AnaName,
         O01ID,
         O02ID,
         O03ID,
         O04ID,
         O05ID,
         AV7415.CurrencyID,
         AV7415.ExchangeRate,
         AV7415.ObjectName,
         AV7415.AccountName,
         AV7415.AccountNameE,
         ClosingOriginalAmount,
         ClosingConvertedAmount,
         A01.AccountName,
         A02.AccountName,
         AV7415.Duedate,
         A11.AnaName,
         A12.AnaName,
         A13.AnaName,
         A14.AnaName,
         A15.AnaName,
         A16.AnaName,
         A17.AnaName,
         A18.AnaName,
         A19.AnaName,
         A10.AnaName,
         Parameter01,
         Parameter02,
         Parameter03,
         Parameter04,
         Parameter05,
         Parameter06,
         Parameter07,
         Parameter08,
         Parameter09,
         Parameter10;
GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
