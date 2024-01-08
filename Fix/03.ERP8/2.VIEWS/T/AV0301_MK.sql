IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[AV0301_MK]'))
DROP VIEW [dbo].[AV0301_MK]
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
---- Modified on 27/01/2021 by Văn Tài: Tách view cho MEIKO

CREATE VIEW [dbo].[AV0301_MK] AS

SELECT GiveUpID
		, K01.VoucherID
		, BatchID
		, TableID
		, K01.DivisionID
		, TranMonth
		, TranYear
		, ObjectID
		, DebitAccountID
		, CurrencyID
		, CurrencyIDCN
		, ObjectName
		, Ana01ID
		, Ana02ID
		, Ana03ID
		, Ana04ID
		, Ana05ID
		, OriginalAmount
		, ConvertedAmount
		, OriginalAmountCN
		, GivedOriginalAmount
		, GivedConvertedAmount
		, ExchangeRate
		, ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, VDescription
		, BDescription
		, Status
		, PaymentID
		, DueDays
		, DueDate
		, InheritTableID
From (
		select Isnull(Max(IsMultiTax), 0) as IsMultiTax
				, DivisionID
				, VoucherID
				, Ana01ID
				, Ana02ID
				, Ana03ID
				, Ana04ID
				, Ana05ID 
		 from AT9000  WITH (NOLOCK) 
		 Group by DivisionID
					, VoucherID
					, Ana01ID
					, Ana02ID
					, Ana03ID
					, Ana04ID
					, Ana05ID
	) T90
inner join
AV03011_MK K01 ON K01.DivisionID = T90.DivisionID and K01.VoucherID = T90.VoucherID
Where IsMultiTax =1

Union
SELECT GiveUpID
		, K02.VoucherID
		, BatchID
		, TableID
		, K02.DivisionID
		, TranMonth
		, TranYear
		, ObjectID
		, DebitAccountID
		, CurrencyID
		, CurrencyIDCN
		, ObjectName
		, Ana01ID
		, Ana02ID
		, Ana03ID
		, Ana04ID
		, Ana05ID
		, OriginalAmount
		, ConvertedAmount
		, OriginalAmountCN
		, GivedOriginalAmount
		, GivedConvertedAmount
		, ExchangeRate
		, ExchangeRateCN
		, VoucherTypeID
		, VoucherNo
		, VoucherDate
		, InvoiceDate
		, InvoiceNo
		, Serial
		, VDescription
		, BDescription
		, Status
		, PaymentID
		, DueDays
		, DueDate
		, InheritTableID
From (
		select Isnull(Max(IsMultiTax), 0) as IsMultiTax
		, DivisionID
		, VoucherID 
		from AT9000 WITH (NOLOCK)  
		Group by DivisionID
				, VoucherID
	) T91
inner join AV03012_MK K02 ON K02.DivisionID = T91.DivisionID 
							and K02.VoucherID = T91.VoucherID
Where IsMultiTax =0
















