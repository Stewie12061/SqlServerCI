IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7407_HT]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7407_HT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------- Created by Phan thanh hoàng Vũ, Date 10/05/2016
------- Purpose: In chi tiet Cong no phai tra
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 18/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
/*
exec AP7407_HT @DivisionID=N'HT', @CurrencyID = 'VND',@FromAccountID=N'3311',@ToAccountID=N'357',@FromObjectID=N' 22247-B.TD*HBC',
@ToObjectID=N'Z-TV70',@SQLwhere=N' and 1=1',@StrDivisionID  = 'HT,Q7,TB'
*/

CREATE PROCEDURE [dbo].[AP7407_HT]  
				@DivisionID as nvarchar(50) ,
				@CurrencyID as nvarchar(50),
				@FromAccountID as nvarchar(50),
				@ToAccountID as nvarchar(50),
				@FromObjectID as nvarchar(50),
				@ToObjectID as nvarchar(50),	
				@SQLwhere as nvarchar(4000),
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


Declare @sql as nvarchar(4000), @sql1 AS NVARCHAR(4000)
----  Phat sinh No
set @sql = '
	SELECT D3.TransactionID,
		BatchID,
		VoucherID,
		TableID,
		D3.DivisionID,
		TranMonth,
		TranYear,
		''00'' as RPTransactionType, 
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
		NULL Ana01ID,
		NULL Ana02ID,
		NULL Ana03ID,
		NULL Ana04ID,
		NULL Ana05ID,
		NULL Ana06ID,
		NULL Ana07ID,
		NULL Ana08ID,
		NULL Ana09ID,
		NULL Ana10ID,
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
		D3.Parameter01,D3.Parameter02,D3.Parameter03,D3.Parameter04,D3.Parameter05,D3.Parameter06,D3.Parameter07,D3.Parameter08,D3.Parameter09,D3.Parameter10
FROM AT9000 D3  WITH (NOLOCK)
	LEFT JOIN AT1011 A1 WITH (NOLOCK)	ON A1.AnaID = D3.Ana01ID  AND A1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A2 WITH (NOLOCK)	ON A2.AnaID = D3.Ana02ID  AND A2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A3 WITH (NOLOCK)	ON A3.AnaID = D3.Ana03ID  AND A3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A4 WITH (NOLOCK)	ON A4.AnaID = D3.Ana04ID  AND A4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A5 WITH (NOLOCK)	ON A5.AnaID = D3.Ana05ID  AND A5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A6 WITH (NOLOCK)	ON A6.AnaID = D3.Ana06ID  AND A6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A7 WITH (NOLOCK)	ON A7.AnaID = D3.Ana07ID  AND A7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A8 WITH (NOLOCK)	ON A8.AnaID = D3.Ana08ID  AND A8.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A9	 WITH (NOLOCK)	ON A9.AnaID = D3.Ana09ID  AND A9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A10 WITH (NOLOCK)	ON A10.AnaID = D3.Ana10ID AND A10.AnaTypeID = ''A10''
	WHERE D3.DebitAccountID in (SELECT AccountID FROM AT1005 D3 WITH (NOLOCK) WHERE D3.GroupID = ''G04'' ' + @StrDivisionID_New + ')  --- Thuoc nhom cong no phai tra
		' + @StrDivisionID_New + ' 
		and	D3.TransactionTypeID <>''T00'' 
		and	D3.CurrencyIDCN like ''' + @CurrencyID+''''
Set @SQL = @SQL +  @SQLwhere

if @FromObjectID <> '%'
	set @SQL= @SQL + '  and D3.ObjectID >= ''' + @FromObjectID + ''' and D3.ObjectID <=''' + @ToObjectID+ '''	'

 If @FromAccountID <> '%' 
	set @SQL= @SQL +' and D3.DebitAccountID >=''' + @FromAccountID + ''' and D3.DebitAccountID <= '''+ @ToAccountID + '''  '

Set @sql1 = 'UNION ALL 
	SELECT D3.TransactionID,
		BatchID, 
		VoucherID,
		TableID,
		D3.DivisionID,
		TranMonth,
		TranYear,
		''01'' as RPTransactionType,
		D3.TransactionTypeID, 
		Case when D3.TransactionTypeID =''T99'' then D3.CreditObjectID else D3.ObjectID end As ObjectID,   
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
		NULL Ana01ID,
		NULL Ana02ID,
		NULL Ana03ID,
		NULL Ana04ID,
		NULL Ana05ID,
		NULL Ana06ID,
		NULL Ana07ID,
		NULL Ana08ID,
		NULL Ana09ID,
		NULL Ana10ID,
		A1.AnaName AS Ana01Name,A2.AnaName AS Ana02Name,A3.AnaName AS Ana03Name,A4.AnaName AS Ana04Name,A5.AnaName AS Ana05Name,
		A6.AnaName AS Ana06Name,A7.AnaName AS Ana07Name,A8.AnaName AS Ana08Name,A9.AnaName AS Ana09Name,A10.AnaName AS Ana10Name,
		D3.CurrencyIDCN,
		D3.ExchangeRate,
		D3.OriginalAmountCN as OriginalAmount ,  D3.ConvertedAmount, 
		D3.OriginalAmountCN*(-1) as SignOriginalAmount ,  D3.ConvertedAmount*(-1) as SignConvertedAmount,  --- Phat sinh Co		
		D3.Status, 	D3.CreateUserID, D3.LastModifyUserID, D3.CreateDate,D3.LastModifyDate,D3.Duedate,
		D3.Parameter01,D3.Parameter02,D3.Parameter03,D3.Parameter04,D3.Parameter05,D3.Parameter06,D3.Parameter07,D3.Parameter08,D3.Parameter09,D3.Parameter10
	From  AT9000 D3 WITH (NOLOCK)
	LEFT JOIN AT1011 A1	 WITH (NOLOCK) ON A1.AnaID = D3.Ana01ID  AND A1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A2	 WITH (NOLOCK) ON A2.AnaID = D3.Ana02ID  AND A2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A3	 WITH (NOLOCK) ON A3.AnaID = D3.Ana03ID  AND A3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A4	 WITH (NOLOCK) ON A4.AnaID = D3.Ana04ID  AND A4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A5	 WITH (NOLOCK) ON A5.AnaID = D3.Ana05ID  AND A5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A6	 WITH (NOLOCK) ON A6.AnaID = D3.Ana06ID  AND A6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A7	 WITH (NOLOCK) ON A7.AnaID = D3.Ana07ID  AND A7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A8	 WITH (NOLOCK) ON A8.AnaID = D3.Ana08ID  AND A8.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A9	 WITH (NOLOCK) ON A9.AnaID = D3.Ana09ID  AND A9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = D3.Ana10ID AND A10.AnaTypeID = ''A10''
	Where 	D3.CreditAccountID in (Select AccountID From AT1005 WITH (NOLOCK) WHere GroupID = ''G04'' ' + @StrDivisionID_New + ')   ---- Phat sinh Co
		' + @StrDivisionID_New + '  
		and	D3.TransactionTypeID <> ''T00''
		and	D3.CurrencyIDCN like ''' + @CurrencyID + ''' 	'

Set @SQL1 = @SQL1 +  @SQLwhere

if @FromObjectID <> '%'
	set @SQL1= @SQL1 + ' and (Case when D3.TransactionTypeID =''T99'' Then  D3.CreditObjectID else  D3.ObjectID End) >= ''' + @FromObjectID + ''' and (Case when D3.TransactionTypeID = ''T99'' then D3.CreditObjectID else   D3.ObjectID End)  <=''' + @ToObjectID+ '''	'

If @FromAccountID <> '%' 
	set @SQL1= @SQL1 + ' and D3.CreditAccountID >= ''' + @FromAccountID + ''' and D3.CreditAccountID <= '''+ @ToAccountID + '''  '


If not exists (Select name from sysobjects WITH (NOLOCK) Where id = Object_id(N'[dbo].[AV7407]') and OBJECTPROPERTY(id, N'IsView') = 1)
     Exec ('  Create View AV7407 as ' + @SQL+@sql1)
Else
     Exec ('  Alter View AV7407  As ' + @SQL+@sql1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

