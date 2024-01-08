IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7404]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7404]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  CREATE View AV7404  As 
SELECT TransactionID,
	D3.BatchID, 
	D3.VoucherID,
	D3.DivisionID,
	D3.TranMonth,
	D3.TranYear,
	'00' as RPTransactionType,
	D3.TransactionTypeID, 
	D3.ObjectID, 
	DebitAccountID as DebitAccountID,
	CreditAccountID as CreditAccountID, 
	DebitAccountID as AccountID,   
	D3.VoucherNo, 
	D3.VoucherTypeID,
	VoucherDate,
	InvoiceNo,
	InvoiceDate,
	Serial,
	D3.DueDate,
	VDescription,
	BDescription,
	TDescription, 
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
	(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) AS CurrencyID,
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
	D3.OrderID,
	OT2001.Orderdate,
	OT2001.ClassifyID,
	D3.TableID,
	D3.Parameter01, D3.Parameter02,
	D3.Parameter03, D3.Parameter04,
	D3.Parameter05, D3.Parameter06,
	D3.Parameter07, D3.Parameter08,
	D3.Parameter09, D3.Parameter10
FROM AT9000 D3 with (NOLOCK) -- inner  join AT1005 on D3.DebitAccountID = AT1005.AccountID
left  join OT2001 WITH (NOLOCK) on OT2001.SorderID = D3.OrderID and OT2001.DivisionID = D3.DivisionID
Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
WHERE  D3.DebitAccountID in (Select AccountID from AT1005 WITH (NOLOCK) Where GroupID ='G03')   --- Thuoc nhom cong no phai thu
		 and D3.DivisionID LIKE 'MA' 
			and	D3.TransactionTypeID <> 'T00'
		and	(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE 'VND'
		 AND (D3.TranMonth + 100 * D3.TranYear BETWEEN     202007 AND     202007) and D3.ObjectID >= '000001' and D3.ObjectID <= 'ZODIAC' and D3.DebitAccountID >='12811' and D3.DebitAccountID<= '171'  UNION ALL 
	SELECT TransactionID,
		BatchID,
		D3.VoucherID,
		D3.DivisionID, 
		D3.TranMonth, 
		D3.TranYear,
		'01' as RPTransactionType, 
		TransactionTypeID, 
		(Case When D3.TransactionTypeID = 'T99' then CreditObjectID else D3.ObjectID End) as ObjectID,     
		DebitAccountID as DebitAccountID,
		CreditAccountID  as CreditAccountID, 
		CreditAccountID as AccountID,
		D3.VoucherNo, 
		D3.VoucherTypeID, 
		VoucherDate,
		InvoiceNo,
		InvoiceDate,
		Serial,
		D3.DueDate,
		VDescription,
		BDescription,
		TDescription,
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
		(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) AS CurrencyID,
		D3.ExchangeRate,
		D3.OriginalAmountCN as OriginalAmount,
		D3.ConvertedAmount, 
		D3.OriginalAmountCN * (-1) as SignOriginalAmount,
		D3.ConvertedAmount * (-1) as SignConvertedAmount,  --- Phat sinh Co		
		D3.Status,
		D3.CreateUserID,
		D3.LastModifyUserID,
		D3.CreateDate,
		D3.LastModifyDate,
		D3.OrderID,
		OT2001.Orderdate,
		OT2001.ClassifyID,
		D3.TableID,
		D3.Parameter01, D3.Parameter02,
		D3.Parameter03, D3.Parameter04,
		D3.Parameter05, D3.Parameter06,
		D3.Parameter07, D3.Parameter08,
		D3.Parameter09, D3.Parameter10
FROM  AT9000 D3  with (NOLOCK)
Left  join OT2001 WITH (NOLOCK) on OT2001.SorderID = D3.OrderID and OT2001.DivisionID = D3.DivisionID
Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
Where CreditAccountID in (Select AccountID From AT1005 WITH (NOLOCK) WHere GroupID ='G03')   ---- Phat sinh Co		
	  and D3.DivisionID LIKE 'MA' 
		and	D3.TransactionTypeID <> 'T00'
	And (Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE 'VND'	
AND (D3.TranMonth + 100 * D3.TranYear BETWEEN     202007 AND     202007) and (Case when D3.TransactionTypeID = 'T99' Then D3.CreditObjectID else D3.ObjectID End) >= '000001' and (Case when D3.TransactionTypeID ='T99' then D3.CreditObjectID else D3.ObjectID End)  <='ZODIAC' and D3.CreditAccountID >='12811' and D3.CreditAccountID<= '171'  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
