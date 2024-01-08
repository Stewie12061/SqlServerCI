﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP00111_ST]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP00111_ST]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by: Khanh Van
---- Date: 23/09/2013
---- Purpose: Cai thien toc do man hinh giai tru cong no phai thu
-- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP00111_ST] 
		@DivisionID nvarchar(50),
		@ObjectID nvarchar(50),
		@AccountID nvarchar(50)

			
 AS

Declare @sqlSelect as nvarchar(4000) =N'',
		@sqlSelect1 as nvarchar(4000) =N'',
		@sqlSelect2 as nvarchar(4000) =N'',
		@sqlExec as nvarchar(4000) =N'',
		@sqlExec1 as nvarchar(4000) =N'',
		@sqlExec2 as nvarchar(4000) =N''

Set @sqlExec = N'	
SELECT A.GiveUpID, A.VoucherID, A.BatchID, A.TableID, A.DivisionID, A.TranMonth, A.TranYear,
	A.ObjectID, A.DebitAccountID, A.CurrencyID, A.CurrencyIDCN, A.ObjectName, 
	A.Ana01ID, A.Ana02ID,A.Ana03ID, A.Ana04ID,A.Ana05ID, A.OriginalAmount + A.VATOriginalAmount  as OriginalAmount, 
	A.ConvertedAmount + A.VATConvertedAmount  as ConvertedAmount, A.OriginalAmountCN + A.VATOriginalAmount  as OriginalAmountCN,  
	Isnull(T3.GivedOriginalAmount,0) as GivedOriginalAmount,		
	Isnull(T3.GivedConvertedAmount,0)as GivedConvertedAmount,
	A.ExchangeRate,A.ExchangeRateCN,
	A.VoucherTypeID, A.VoucherNo, A.VoucherDate, A.InvoiceDate, A.InvoiceNo, A.Serial,
	A.VDescription, A.BDescription, A.Status,
	A.PaymentID, A.DueDays, A.DueDate'
Set @sqlExec1 = N'
into #AV03011
From( SELECT '''' AS GiveUpID, VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	(select Max(IsMultiTax) from AT9000 T90 where T90.DivisionID=AT9000.DivisionID and T90.VoucherID=AT9000.VoucherID) as IsMultiTax,				TransactionTypeID,	isnull(AT9000.Ana01ID,'''')as Ana01ID, isnull(AT9000.Ana02ID,'''')as Ana02ID,
	isnull(AT9000.Ana03ID,'''')as Ana03ID,isnull(AT9000.Ana04ID,'''')as Ana04ID,isnull(AT9000.Ana05ID,'''')as Ana05ID,	
	Sum(isnull(OriginalAmount,0))as OriginalAmount,  SUM(ISNULL(VATOriginalAmount,0))as VATOriginalAmount,	
	Sum(isnull(ConvertedAmount,0))as ConvertedAmount,  SUM(ISNULL(VATConvertedAmount,0))as VATConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN, 
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, VDescription AS BDescription, 0 AS Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate
FROM AT9000 WITH (NOLOCK) 
Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
WHERE DebitAccountID like('''+@AccountID+''') and AT9000.ObjectID like ('''+@ObjectID+''')
	and AT9000.DivisionID = '''+@DivisionID+''' and AT9000.TransactionTypeID <>''T14''
Group by VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	AT9000.Ana01ID, AT9000.Ana02ID,AT9000.Ana03ID, AT9000.Ana04ID,AT9000.Ana05ID,
	ExchangeRate, ExchangeRateCN,	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate,TransactionTypeID )A

LEFT JOIN	(SELECT isnull(T03.ConvertedAmount,0) AS GivedConvertedAmount,
					isnull(T03.OriginalAmount,0) AS GivedOriginalAmount,
					T03.ObjectID, T03.DebitVoucherID,T03.DebitBatchID,T03.AccountID,
					T03.DivisionID
					
			 FROM	AT0303 T03 WITH (NOLOCK) 
         	 Where DivisionID ='''+@DivisionID+''' and AccountID like('''+@AccountID+''') and ObjectID like ('''+@ObjectID+''')
			 )T3
	ON		T3.DebitVoucherID = A.VoucherID AND
			T3.DebitBatchID = A.BatchID 
			and T3.GivedConvertedAmount = A.ConvertedAmount+A.VATConvertedAmount
			and T3.GivedOriginalAmount = A.OriginalAmount + A.VATOriginalAmount
			'
Set @sqlExec2 = N'
SELECT '''' AS GiveUpID, VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	Max(isnull(Ana01ID,'''')) As Ana01ID, Max(isnull(Ana02ID,'''')) As Ana02ID, Max(isnull(Ana03ID,'''')) As Ana03ID, Max(isnull(Ana04ID,'''')) As Ana04ID, Max(isnull(Ana05ID,'''')) As Ana05ID, 
	Sum(isnull(OriginalAmount,0)) as OriginalAmount,
	Sum(isnull(ConvertedAmount,0)) as ConvertedAmount, 
	Sum(isnull(OriginalAmountCN,0)) as OriginalAmountCN,
	GivedOriginalAmount = isnull((Select Sum(isnull(OriginalAmount,0)) From AT0303 Where DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0),
	GivedConvertedAmount =isnull( (Select Sum(isnull(ConvertedAmount,0)) From AT0303 Where 	DivisionID = AT9000.DivisionID and
										ObjectID = AT9000.ObjectID and
										DebitVoucherID = AT9000.VoucherID and
										DebitBatchID = AT9000.BatchID and
										DebitTableID = At9000.TableID and
										AccountID = AT9000.DebitAccountID and
										CurrencyID = AT9000.CurrencyIDCN),0),
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, VDescription AS BDescription, 0 AS Status,
	AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate
Into #AV03012
FROM AT9000 WITH (NOLOCK) Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
WHERE DebitAccountID like('''+@AccountID+''') and AT9000.ObjectID like ('''+@ObjectID+''')
and AT9000.DivisionID = '''+@DivisionID+''' 
Group by VoucherID, BatchID, TableID, AT9000.DivisionID, TranMonth, TranYear,
	AT9000.ObjectID, DebitAccountID, AT9000.CurrencyID, CurrencyIDCN, AT1202.ObjectName, 
	ExchangeRate, ExchangeRateCN,
	VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate, InvoiceNo, Serial,
	VDescription, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate
		'
Set @sqlSelect = N'
	  Delete AT0301
	  WHERE DivisionID = '''+@DivisionID+''' and DebitAccountID like('''+@AccountID+''') and ObjectID like ('''+@ObjectID+''')
	  Insert AT0301 (GiveUpID, VoucherID, BatchID,  TableID, DivisionID,TranMonth,TranYear,
      ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN,
      ObjectName, OriginalAmount,ConvertedAmount,
      OriginalAmountCN, GivedOriginalAmount,  GivedConvertedAmount,   ExchangeRate, ExchangeRateCN,
      VoucherTypeID, VoucherNO, VoucherDate,  InvoiceDate,InvoiceNo, Serial,
      VDescription,BDescription,  Status,   PaymentID, DueDays, DueDate)
      SELECT GiveUpID, VoucherID, BatchID,  TableID, DivisionID,TranMonth,TranYear,
      ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN,
      ObjectName , OriginalAmount, ConvertedAmount,
      OriginalAmountCN,GivedOriginalAmount,GivedConvertedAmount,  ExchangeRate, ExchangeRateCN,
      VoucherTypeID, VoucherNO, VoucherDate,  InvoiceDate,InvoiceNo, Serial,
      VDescription,BDescription,  Status, PaymentID , DueDays, DueDate
      From
      '

Set @sqlSelect1 = N'
(SELECT GiveUpID,  K01.VoucherID, BatchID, TableID, K01.DivisionID, TranMonth, TranYear,
 ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN, ObjectName, Ana01ID, Ana02ID, Ana03ID, Ana04ID,
 Ana05ID, OriginalAmount, ConvertedAmount, OriginalAmountCN, GivedOriginalAmount, GivedConvertedAmount,
 ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate,
 InvoiceNo, Serial, VDescription, BDescription, Status, PaymentID, DueDays,
 DueDate
From
(select Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID from AT9000  WITH (NOLOCK) 
Where DivisionID = '''+@DivisionID+'''and DebitAccountID like('''+@AccountID+''') and ObjectID like ('''+@ObjectID+''')
Group by DivisionID, VoucherID) T90
inner join
#AV03011 K01
ON K01.VoucherID = T90.VoucherID
Where IsMultiTax =1
'
Set @sqlSelect2 = N'
union all
SELECT GiveUpID,  K02.VoucherID, BatchID, TableID, K02.DivisionID, TranMonth, TranYear,
 ObjectID, DebitAccountID, CurrencyID, CurrencyIDCN, ObjectName, Ana01ID, Ana02ID, Ana03ID, Ana04ID,
 Ana05ID, OriginalAmount, ConvertedAmount, OriginalAmountCN, GivedOriginalAmount, GivedConvertedAmount,
 ExchangeRate, ExchangeRateCN, VoucherTypeID, VoucherNo, VoucherDate, InvoiceDate,
 InvoiceNo, Serial, VDescription, BDescription, Status, PaymentID, DueDays,
 DueDate

From
(select Isnull(Max(IsMultiTax),0) as IsMultiTax, DivisionID, VoucherID from AT9000  WITH (NOLOCK) 
Where DivisionID = '''+@DivisionID+''' and DebitAccountID like('''+@AccountID+''') and ObjectID like ('''+@ObjectID+''')
Group by DivisionID, VoucherID) T91
inner join
#AV03012 K02
ON K02.VoucherID = T91.VoucherID
Where IsMultiTax =0)B'
--Print @sqlExec
--Print @sqlExec1
--Print @sqlExec2
--Print @sqlSelect
--Print @sqlSelect1
--Print @sqlSelect2

Exec(@sqlExec + @sqlExec1 + @sqlExec2 +  @sqlSelect +  @sqlSelect1 +  @sqlSelect2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON