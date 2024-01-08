IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7404_HT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7404_HT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


------- Created by Phan thanh hoàng vũ, Date 10/05/2016
------- Purpose: In chi tiet Cong no phai thu
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)

CREATE PROCEDURE [dbo].[AP7404_HT]  
				@DivisionID as nvarchar(50) ,
				@CurrencyID as nvarchar(50),
				@FromAccountID as nvarchar(50),
				@ToAccountID as nvarchar(50),
				@FromObjectID as nvarchar(50),
				@ToObjectID as nvarchar(50),
				@SQLwhere as nvarchar(500),
				@StrDivisionID AS NVARCHAR(4000)
AS
		
		Declare @CustomerName INT
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
		--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_New AS NVARCHAR(4000)
		
		If @CustomerName =51 --Customer Hoàng trần
		Begin
			IF isnull(@StrDivisionID, '') = Isnull(@DivisionID, '') 
				Set @StrDivisionID_New = ' and D3.DivisionID LIKE ''' + @DivisionID + '''' 
			ELSE 
				Set @StrDivisionID_New = ' and D3.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
		End
		Else
			Set @StrDivisionID_New = ' and D3.DivisionID LIKE ''' + @DivisionID + '''' 
		---------------<<<< Chuỗi DivisionID	


Declare @sql as nvarchar(MAX)
------ Phat sinh No
set @sql = '
SELECT TransactionID,
	D3.BatchID, 
	D3.VoucherID,
	D3.DivisionID,
	D3.TranMonth,
	D3.TranYear,
	''00'' as RPTransactionType,
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
	OriginalAmountCN as OriginalAmount,
	D3.ConvertedAmount, 
	OriginalAmountCN as SignOriginalAmount,
	D3.ConvertedAmount as SignConvertedAmount, 
	Status, 
	D3.CreateUserID,
	D3.LastModifyUserID,
	D3.CreateDate,
	D3.LastModifyDate,
	D3.OrderID,
	OT2001.Orderdate,
	D3.TableID,
	D3.Parameter01, D3.Parameter02,
	D3.Parameter03, D3.Parameter04,
	D3.Parameter05, D3.Parameter06,
	D3.Parameter07, D3.Parameter08,
	D3.Parameter09, D3.Parameter10
FROM AT9000 D3 with (NOLOCK) -- inner  join AT1005 on D3.DebitAccountID = AT1005.AccountID
left  join OT2001 WITH (NOLOCK) on OT2001.SorderID = D3.OrderID and OT2001.DivisionID = D3.DivisionID
Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
WHERE  D3.DebitAccountID in (Select AccountID from AT1005 WITH (NOLOCK) Where GroupID =''G03'')   --- Thuoc nhom cong no phai thu
		' +  @StrDivisionID_New + ' 
		and	D3.TransactionTypeID <> ''T00''
		and	(Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE ''' + @CurrencyID + '''
		'
		
Set @SQL = @SQL +  @SQLwhere

if @FromObjectID <> '%'
	set @SQL= @SQL + ' and D3.ObjectID >= ''' + @FromObjectID + ''' and D3.ObjectID <= ''' + @ToObjectID + ''''

 If @FromAccountID <> '%' 
	set @SQL= @SQL + ' and D3.DebitAccountID >=''' + @FromAccountID + ''' and D3.DebitAccountID<= '''+ @ToAccountID + '''  '

Set @sql = @sql + 'UNION ALL 
	SELECT TransactionID,
		BatchID,
		D3.VoucherID,
		D3.DivisionID, 
		D3.TranMonth, 
		D3.TranYear,
		''01'' as RPTransactionType, 
		TransactionTypeID, 
		(Case When D3.TransactionTypeID = ''T99'' then CreditObjectID else D3.ObjectID End) as ObjectID,     
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
		OriginalAmountCN as OriginalAmount,
		D3.ConvertedAmount, 
		OriginalAmountCN * (-1) as SignOriginalAmount,
		D3.ConvertedAmount * (-1) as SignConvertedAmount,  --- Phat sinh Co		
		Status,
		D3.CreateUserID,
		D3.LastModifyUserID,
		D3.CreateDate,
		D3.LastModifyDate,
		D3.OrderID,
		OT2001.Orderdate,
		D3.TableID,
		D3.Parameter01, D3.Parameter02,
		D3.Parameter03, D3.Parameter04,
		D3.Parameter05, D3.Parameter06,
		D3.Parameter07, D3.Parameter08,
		D3.Parameter09, D3.Parameter10
FROM  AT9000 D3  with (NOLOCK)
Left  join OT2001 WITH (NOLOCK) on OT2001.SorderID = D3.OrderID and OT2001.DivisionID = D3.DivisionID
Left join AT0000 A00 WITH (NOLOCK) on D3.DivisionID = A00.DefDivisionID
Where CreditAccountID in (Select AccountID From AT1005 WITH (NOLOCK) WHere GroupID =''G03'')   ---- Phat sinh Co		
	 '+ @StrDivisionID_New + ' 
	and	D3.TransactionTypeID <>''T00'' 
	And (Case when D3.CurrencyIDCN is null then A00.CurrencyID else D3.CurrencyIDCN end ) LIKE ''' + @CurrencyID + '''	
	'

Set @SQL = @SQL +  @SQLwhere

if @FromObjectID <> '%'
	set @SQL= @SQL + ' and (Case when D3.TransactionTypeID = ''T99'' Then D3.CreditObjectID else D3.ObjectID End) >= ''' + @FromObjectID + ''' and (Case when D3.TransactionTypeID =''T99'' then D3.CreditObjectID else D3.ObjectID End)  <=''' + @ToObjectID+ ''''

 If @FromAccountID <> '%' 
	set @SQL= @SQL + ' and D3.CreditAccountID >=''' + @FromAccountID + ''' and D3.CreditAccountID<= '''+ @ToAccountID + '''  '


If not exists (Select name from sysobjects WITH (NOLOCK) Where id = Object_id(N'[dbo].[AV7404]') and OBJECTPROPERTY(id, N'IsView') = 1)
     Exec ('  Create View AV7404 as ' + @SQL)
Else
     Exec ('  Alter View AV7404  As ' + @SQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
