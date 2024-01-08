IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7407]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7407]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[AV7407]    Script Date: 30/06/2021 ******/
 CREATE View AV7407 --Created by AP7407, fix ban đầu để chạy tools
 As 
	SELECT D3.TransactionID,
		BatchID,
		VoucherID,
		TableID,
		D3.DivisionID,
		TranMonth,
		TranYear,
		'00' as RPTransactionType, 
		D3.TransactionTypeID, 
		D3.ObjectID, 
		D3.DebitAccountID as DebitAccountID,
		D3.CreditAccountID as CreditAccountID, 
		D3.DebitAccountID as AccountID,   
		D3.VoucherNo,
		D3.VoucherTypeID,
		D3.VoucherDate,
		D3.InvoiceNo,
		D3.InvoiceDate,
		D3.Serial, 
		D3.VDescription,
		D3.BDescription,
		isnull(D3.TDescription, isnull(D3.BDescription, D3.VDescription)) as TDescription,
		D3.Ana01ID,
		D3.Ana02ID,
		D3.Ana03ID,
		D3.Ana04ID,
		D3.Ana05ID,
		D3.Ana06ID,
		D3.Ana07ID,
		D3.Ana08ID,
		D3.Ana09ID,
		D3.Ana10ID,
		A1.AnaName AS Ana01Name,A2.AnaName AS Ana02Name,A3.AnaName AS Ana03Name,A4.AnaName AS Ana04Name,A5.AnaName AS Ana05Name,
		A6.AnaName AS Ana06Name,A7.AnaName AS Ana07Name,A8.AnaName AS Ana08Name,A9.AnaName AS Ana09Name,A10.AnaName AS Ana10Name,
		D3.CurrencyIDCN,  
		D3.ExchangeRate, 
		D3.OriginalAmountCN as OriginalAmount,
		D3.ConvertedAmount, 
		D3.OriginalAmountCN as SignOriginalAmount,
		D3.ConvertedAmount as SignConvertedAmount, 
		D3.Status,
		D3.CreateUserID,
		D3.LastModifyUserID,
		D3.CreateDate,
		D3.LastModifyDate,
		D3.Duedate,
		D3.Parameter01,D3.Parameter02,D3.Parameter03,D3.Parameter04,D3.Parameter05,D3.Parameter06,D3.Parameter07,D3.Parameter08,D3.Parameter09,D3.Parameter10,
		A4.Amount01 Amount01Ana04ID
FROM AT9000 D3  WITH (NOLOCK)
	LEFT JOIN AT1011 A1 WITH (NOLOCK)	 ON A1.AnaID = D3.Ana01ID  AND A1.AnaTypeID = 'A01'
	LEFT JOIN AT1011 A2 WITH (NOLOCK)	 ON A2.AnaID = D3.Ana02ID  AND A2.AnaTypeID = 'A02'
	LEFT JOIN AT1011 A3 WITH (NOLOCK)	 ON A3.AnaID = D3.Ana03ID  AND A3.AnaTypeID = 'A03'
	LEFT JOIN AT1011 A4 WITH (NOLOCK)	 ON A4.AnaID = D3.Ana04ID  AND A4.AnaTypeID = 'A04'
	LEFT JOIN AT1011 A5 WITH (NOLOCK)	 ON A5.AnaID = D3.Ana05ID  AND A5.AnaTypeID = 'A05'
	LEFT JOIN AT1011 A6 WITH (NOLOCK)	 ON A6.AnaID = D3.Ana06ID  AND A6.AnaTypeID = 'A06'
	LEFT JOIN AT1011 A7 WITH (NOLOCK)	 ON A7.AnaID = D3.Ana07ID  AND A7.AnaTypeID = 'A07'
	LEFT JOIN AT1011 A8 WITH (NOLOCK)	 ON A8.AnaID = D3.Ana08ID  AND A8.AnaTypeID = 'A08'
	LEFT JOIN AT1011 A9 WITH (NOLOCK)	 ON A9.AnaID = D3.Ana09ID  AND A9.AnaTypeID = 'A09'
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = D3.Ana10ID AND A10.AnaTypeID = 'A10'
	WHERE D3.DebitAccountID in (SELECT AccountID FROM AT1005 D3 WITH (NOLOCK) WHERE D3.GroupID = 'G04')  --- Thuoc nhom cong no phai tra
		 and D3.DivisionID LIKE '%' 
		and	D3.TransactionTypeID <>'%' 
		and	D3.CurrencyIDCN like '%' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN     202105 AND     202106)   and D3.ObjectID >= '' and D3.ObjectID <=''	 and D3.DebitAccountID >='' and D3.DebitAccountID <= ''  UNION ALL 
	SELECT D3.TransactionID,
		BatchID, 
		VoucherID,
		TableID,
		D3.DivisionID,
		TranMonth,
		TranYear,
		'01' as RPTransactionType,
		D3.TransactionTypeID, 
		Case when D3.TransactionTypeID ='T99' then D3.CreditObjectID else D3.ObjectID end As ObjectID,   
		D3.DebitAccountID as DebitAccountID,
		D3.CreditAccountID  as CreditAccountID, 
		D3.CreditAccountID as AccountID,
		D3.VoucherNo,
		D3.VoucherTypeID,
		D3.VoucherDate,
		D3.InvoiceNo,
		D3.InvoiceDate,
		D3.Serial, 
		D3.VDescription,
		D3.BDescription,
		isnull(D3.TDescription, isnull(D3.BDescription, D3.VDescription)) as TDescription,
		D3.Ana01ID,
		D3.Ana02ID,
		D3.Ana03ID,
		D3.Ana04ID,
		D3.Ana05ID,
		D3.Ana06ID,
		D3.Ana07ID,
		D3.Ana08ID,
		D3.Ana09ID,
		D3.Ana10ID,
		A1.AnaName AS Ana01Name,A2.AnaName AS Ana02Name,A3.AnaName AS Ana03Name,A4.AnaName AS Ana04Name,A5.AnaName AS Ana05Name,
		A6.AnaName AS Ana06Name,A7.AnaName AS Ana07Name,A8.AnaName AS Ana08Name,A9.AnaName AS Ana09Name,A10.AnaName AS Ana10Name,
		D3.CurrencyIDCN,
		D3.ExchangeRate,
		D3.OriginalAmountCN as OriginalAmount ,  D3.ConvertedAmount, 
D3.OriginalAmountCN*(-1) as SignOriginalAmount ,  D3.ConvertedAmount*(-1) as SignConvertedAmount,  --- Phat sinh Co		
		D3.Status, 	D3.CreateUserID, D3.LastModifyUserID, D3.CreateDate,D3.LastModifyDate,D3.Duedate,
		D3.Parameter01,D3.Parameter02,D3.Parameter03,D3.Parameter04,D3.Parameter05,D3.Parameter06,D3.Parameter07,D3.Parameter08,D3.Parameter09,D3.Parameter10,
		A4.Amount01 Amount01Ana04ID
	From  AT9000 D3 WITH (NOLOCK)
	LEFT JOIN AT1011 A1 WITH (NOLOCK)	ON A1.AnaID = D3.Ana01ID  AND A1.AnaTypeID = 'A01'
	LEFT JOIN AT1011 A2 WITH (NOLOCK)	ON A2.AnaID = D3.Ana02ID  AND A2.AnaTypeID = 'A02'
	LEFT JOIN AT1011 A3 WITH (NOLOCK)	ON A3.AnaID = D3.Ana03ID  AND A3.AnaTypeID = 'A03'
	LEFT JOIN AT1011 A4 WITH (NOLOCK)	ON A4.AnaID = D3.Ana04ID  AND A4.AnaTypeID = 'A04'
	LEFT JOIN AT1011 A5 WITH (NOLOCK)	ON A5.AnaID = D3.Ana05ID  AND A5.AnaTypeID = 'A05'
	LEFT JOIN AT1011 A6 WITH (NOLOCK)	ON A6.AnaID = D3.Ana06ID  AND A6.AnaTypeID = 'A06'
	LEFT JOIN AT1011 A7 WITH (NOLOCK)	ON A7.AnaID = D3.Ana07ID  AND A7.AnaTypeID = 'A07'
	LEFT JOIN AT1011 A8 WITH (NOLOCK)	ON A8.AnaID = D3.Ana08ID  AND A8.AnaTypeID = 'A08'
	LEFT JOIN AT1011 A9 WITH (NOLOCK)	ON A9.AnaID = D3.Ana09ID  AND A9.AnaTypeID = 'A09'
	LEFT JOIN AT1011 A10 WITH (NOLOCK)	ON A10.AnaID = D3.Ana10ID AND A10.AnaTypeID = 'A10'
	Where 	D3.CreditAccountID in (Select AccountID From AT1005 WITH (NOLOCK) WHere GroupID = 'G04')   ---- Phat sinh Co
		 and D3.DivisionID LIKE '%'  
		and	D3.TransactionTypeID <> '%'
		and	D3.CurrencyIDCN like '%' 	 AND (D3.TranMonth + 100 * D3.TranYear BETWEEN     202105 AND     202106)  and (Case when D3.TransactionTypeID ='%' Then  D3.CreditObjectID else  D3.ObjectID End) >= '' and (Case when D3.TransactionTypeID = '%' then D3.CreditObjectID else   D3.ObjectID End)  <=''	 and D3.CreditAccountID >= '' and D3.CreditAccountID <= ''  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
