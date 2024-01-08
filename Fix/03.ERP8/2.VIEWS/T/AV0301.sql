IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[AV0301]'))
DROP VIEW [dbo].[AV0301]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



------ Created By Nguyen Van Nhan, Sunday 09/11/2003.
----- Purpose Loc cac  hoa  don phat sinh No cong no phat thu
----- Cac truong nhan biet: VoucherID, BatchID,TableID,ObjectID,DebitAccountID,
----Edit By Thien Huynh (13/02/2012): Nhom cac dong cung Hoa don (BatchID) thanh 1 dong, 
----khong nhom theo cac tieu chi khac (Khoan muc)
---- Modified on 08/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 23/04/2021 by Nhựt Trường: Bổ sung trường ExchangeRateNew.
---- Modified on 23/04/2021 by Huỳnh Thử: Bổ group by Ana Tách dòng, giải trừ nhiều lần

CREATE VIEW [dbo].[AV0301] AS

SELECT ISNULL(K01.ExchangeRateNew,K01.ExchangeRateCN) AS ExchangeRateNew, GiveUpID,  K01.VoucherID, BatchID, TableID, K01.DivisionID, TranMonth, TranYear,
 ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN, ObjectName, '' AS Ana01ID, '' AS Ana02ID, '' AS Ana03ID, '' AS Ana04ID,
 '' AS Ana05ID, OriginalAmount,CASE WHEN ISNULL(K01.ExchangeRateNew, 0) <> 0 THEN OriginalAmountCN *K01.ExchangeRateNew ELSE ConvertedAmount END as ConvertedAmount,
  OriginalAmountCN, GivedOriginalAmount, GivedConvertedAmount,
 ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate,
 InvoiceNo, Serial, VDescription, BDescription, Status, PaymentID, DueDays,
 DueDate

From
(	SELECT Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID 
	FROM AT9000  WITH (NOLOCK) 
	GROUP by DivisionID, VoucherID
) T90
inner join
AV03011 K01

ON K01.DivisionID = T90.DivisionID and K01.VoucherID = T90.VoucherID
Where IsMultiTax =1

Union
SELECT ISNULL(K02.ExchangeRateNew,K02.ExchangeRateCN) AS ExchangeRateNew, GiveUpID,  K02.VoucherID, BatchID, TableID, K02.DivisionID, TranMonth, TranYear,
 ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN, ObjectName, '' AS Ana01ID, '' AS Ana02ID, '' AS Ana03ID, '' AS Ana04ID,
 '' AS Ana05ID, OriginalAmount, CASE WHEN ISNULL(K02.ExchangeRateNew, 0) <> 0 THEN OriginalAmountCN *K02.ExchangeRateNew ELSE ConvertedAmount END as ConvertedAmount, OriginalAmountCN, GivedOriginalAmount, GivedConvertedAmount,
 ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate,
 InvoiceNo, Serial, VDescription, BDescription, Status, PaymentID, DueDays,
 DueDate

From
(select Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID from AT9000 WITH (NOLOCK)  Group by DivisionID, VoucherID) T91
inner join
AV03012 K02
	
ON K02.DivisionID = T91.DivisionID and K02.VoucherID = T91.VoucherID
Where IsMultiTax =0
















