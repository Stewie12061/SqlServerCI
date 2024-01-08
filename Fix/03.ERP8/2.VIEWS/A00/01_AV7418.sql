IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7418]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7418]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7418]    Script Date: 30/06/2021 ******/
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW AV7418 --Created by AP7408, fix ban đầu để chạy tools
AS 
SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
		BatchID,
		VoucherID,
		AV7407.TableID, AV7407.Status,
		isnull(AV7407.DivisionID,AV7417.DivisionID) as DivisionID,
		TranMonth,
		TranYear, 
		Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
			cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
			cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
			cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
			Year(VoucherDate)*10000 AS char(8)) + 
			cast(VoucherID AS char(20)) + 
			(Case when ISNULL(RPTransactionType,'') = '' then '0' ELSE '1' end) AS Orders,
		RPTransactionType , TransactionTypeID,
		Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
		isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
		AT1202.Note,
		AT1202.Address, AT1202.VATNo,AT1202.Contactor,
		AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
		AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
		DebitAccountID, CreditAccountID, 
		Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
		Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
		VoucherTypeID,
		VoucherNo,
		VoucherDate,
		InvoiceNo,
		InvoiceDate,
		Serial,
		VDescription,
		ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,
		TDescription, 
		AV7407.Ana01ID,
		AV7407.Ana02ID,
		AV7407.Ana03ID,
		AV7407.Ana04ID,
		AV7407.Ana05ID,
		AV7407.Ana06ID,
		AV7407.Ana07ID,
		AV7407.Ana08ID,
		AV7407.Ana09ID,
		AV7407.Ana10ID,
		AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
		isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
		ExchangeRate,
		AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
		Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
		Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
		isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
		isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
		cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
		cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
		AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID  
FROM		AV7407 WITH (NOLOCK) 
FULL JOIN	AV7417 WITH (NOLOCK) ON AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID 
LEFT JOIN 	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (AV7407.DivisionID, '@@@') AND AT1202.ObjectID = Isnull(AV7407.ObjectID, AV7417.ObjectID) --AV7407.ObjectID 
LEFT JOIN	AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV7407.AccountID 
WHERE (isnull(AV7407.ObjectID, AV7417.ObjectID) between '' and '')  and (isnull(AV7407.AccountID, AV7417.AccountID) between '' and '')   
GROUP BY 	BatchID, VoucherID, AV7407.TableID, AV7407.Status, AV7407.DivisionID,AV7417.DivisionID, TranMonth, TranYear, 
			RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7417.ObjectID,
			AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
			DebitAccountID, CreditAccountID, AV7407.AccountID, AV7417.AccountID, 
			VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
			InvoiceNo, InvoiceDate, Serial, VDescription, BDescription,  TDescription,
			AV7407.Ana01ID,
			AV7407.Ana02ID,
			AV7407.Ana03ID,
			AV7407.Ana04ID,
			AV7407.Ana05ID,
			AV7407.Ana06ID,
			AV7407.Ana07ID,
			AV7407.Ana08ID,
			AV7407.Ana09ID,
			AV7407.Ana10ID,
			AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
			AV7407.CurrencyIDCN, AV7417.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
			AV7417.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7417.AccountName,Duedate,
			AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10 ,AV7407.Amount01Ana04ID  
UNION 
SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
		BatchID,
		VoucherID,
		TableID, Status,
		AV7417.DivisionID,
		TranMonth,
		TranYear, 
		Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
			cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
			cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
			cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
			Year(VoucherDate)*10000 AS char(8)) + 
			cast(VoucherID AS char(20)) + 
			(Case when ISNULL(RPTransactionType,'') = '' then '0' ELSE '1' end) AS Orders,
		RPTransactionType , TransactionTypeID,
		Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
		isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
		AT1202.Note,
		AT1202.Address, AT1202.VATNo,AT1202.Contactor,
		AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
		AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
		DebitAccountID, CreditAccountID, 
		Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
		Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
		VoucherTypeID,
		VoucherNo,
		VoucherDate,
		InvoiceNo,
		InvoiceDate,
		Serial,
		--NULL AS VDescription,
		--NULL AS BDescription,
		--NULL AS TDescription,
		AV7407.VDescription,
		ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,
		AV7407.TDescription,
		--convert(varchar,AV7417.Ana01ID),
		--convert(varchar,AV7417.Ana02ID),
		--convert(varchar,AV7417.Ana03ID),
		--convert(varchar,AV7417.Ana04ID),
		--convert(varchar,AV7417.Ana05ID),
		--convert(varchar,AV7417.Ana06ID),
		--convert(varchar,AV7417.Ana07ID),
		--convert(varchar,AV7417.Ana08ID),
		--convert(varchar,AV7417.Ana09ID),
		--convert(varchar,AV7417.Ana10ID),

		Cast (AV7407.Ana01ID as nvarchar(50)),
		Cast (AV7407.Ana02ID as nvarchar(50)),
		Cast (AV7407.Ana03ID as nvarchar(50)),
		Cast (AV7407.Ana04ID as nvarchar(50)),
		Cast (AV7407.Ana05ID as nvarchar(50)),
		Cast (AV7407.Ana06ID as nvarchar(50)),
		Cast (AV7407.Ana07ID as nvarchar(50)),
		Cast (AV7407.Ana08ID as nvarchar(50)),
		Cast (AV7407.Ana09ID as nvarchar(50)),
		Cast (AV7407.Ana10ID as nvarchar(50)),
		AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
		isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
		ExchangeRate,
		AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
		Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
		Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
		Sum(Case When ISNULL(RPTransactionType,'') = '' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
		isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
		isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
		cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
		cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
		AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID 
FROM AV7417 WITH (NOLOCK)
LEFT JOIN AV7407 WITH (NOLOCK) on AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID 
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AV7417.DivisionID, '@@@') AND AT1202.ObjectID = AV7417.ObjectID
LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7417.AccountID 
WHERE (isnull(AV7407.ObjectID, AV7417.ObjectID) between '' and '')  and (isnull(AV7407.AccountID, AV7417.AccountID) between '' and '')   
GROUP BY	BatchID, VoucherID, TableID, Status, AV7417.DivisionID, TranMonth, TranYear, 
			RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7417.ObjectID,
			AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
			DebitAccountID, CreditAccountID, AV7407.AccountID, AV7417.AccountID, 
			VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
			InvoiceNo, InvoiceDate, Serial,--- VDescription, BDescription,  TDescription,
			AV7407.Ana01ID,
			AV7407.Ana02ID,
			AV7407.Ana03ID,
			AV7407.Ana04ID,
			AV7407.Ana05ID,
			AV7407.Ana06ID,
			AV7407.Ana07ID,
			AV7407.Ana08ID,
			AV7407.Ana09ID,
			AV7407.Ana10ID,
			AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
			AV7407.CurrencyIDCN, AV7417.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
			AV7417.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7417.AccountName,Duedate,
			AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID,
			AV7407.TDescription, AV7407.BDescription, AV7407.VDescription

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
