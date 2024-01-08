IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








---- Created by: Khanh Van
---- Date: 23/09/2013
---- Purpose: Cai thien toc do man hinh giai tru cong no phai thu
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 18/03/2019 by Kim Thư: Điều chỉnh tính số tiền quy đổi đã giải trừ bao gồm số tiền chênh lệch tỷ giá thanh toán
---- Modified on 25/12/2019 by Văn Minh: Bổ sung fix lỗi trương hợp giải trừ công nợ âm
---- Modified on 25/08/2020 by Lê Hoàng: Định danh bảng cho cột
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhựt Trường on 24/07/2023: [2023/05/IS/0068] - Cải tiến tốc độ load dữ liệu.
---- Exec AP0011 'MK', '%', '13611'

CREATE PROCEDURE [dbo].[AP0011] 
		@DivisionID nvarchar(50),
		@ObjectID nvarchar(50),
		@AccountID nvarchar(50)


			
 AS

Declare @sqlSelect as nvarchar(4000) =N'',
		@sqlSelect1 as nvarchar(4000) =N'',
		@sqlSelect2 as nvarchar(4000) =N'',
		@sqlExec as nvarchar(4000) =N'',
		@sqlExec1 as nvarchar(4000) =N'',
		@sqlExec2 as nvarchar(4000) =N'',
		@sqlUpdate as nvarchar(4000) =N'',
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 16 --- Customize Sieu Thanh
	EXEC AP0011_ST @DivisionID, @ObjectID, @AccountID
ELSE
Begin

Set @sqlExec = N'	
SELECT	'''' AS GiveUpID, AT9000.VoucherID, BatchID, TableID, AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear,
		(CASE WHEN TransactionTypeID = ''T99'' THEN AT9000.CreditObjectID ELSE AT9000.ObjectID END) AS ObjectID, 
		CreditAccountID, AT9000.CurrencyID, CurrencyIDCN,
		(CASE WHEN TransactionTypeID = ''T99'' THEN B.ObjectName ELSE A.ObjectName  END)  AS  ObjectName,
		SUM(ISNULL(OriginalAmount,0)) AS OriginalAmount,
		SUM(ISNULL(ConvertedAmount,0)) AS ConvertedAmount, 
		SUM(ISNULL(OriginalAmountCN,0)) AS OriginalAmountCN,	
		SUM(isnull(VATOriginalAmount,0))as VATOriginalAmount,
		Sum(isnull(VATConvertedAmount,0)) as VATConvertedAmount,
		AT9000.ExchangeRate, ExchangeRateCN, AT9000.STATUS, AT9000.VoucherTypeID, AT9000.VoucherNo, VoucherDate,
		Isnull(InvoiceDate,VoucherDate) AS InvoiceDate, InvoiceNo, Serial,
		VDescription, VDescription AS BDescription, VDescription AS CDescription, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate, 	
		Max(AT9000.Ana01ID) as Ana01ID, 
		Max(AT9000.Ana02ID) as Ana02ID,
		Max(AT9000.Ana03ID) as Ana03ID,
		Max(AT9000.Ana04ID) as Ana04ID,
		Max(AT9000.Ana05ID) as Ana05ID,
		Max(AT9000.Ana06ID) as Ana06ID,
		Max(AT9000.Ana07ID) as Ana07ID,
		Max(AT9000.Ana08ID) as Ana08ID,
		Max(AT9000.Ana09ID) as Ana09ID,
		Max(AT9000.Ana10ID) as Ana10ID,
		MAX(A01.AnaName) AS AnaName01,
		MAX(A02.AnaName) AS AnaName02,
		MAX(A03.AnaName) AS AnaName03,
		MAX(A04.AnaName) AS AnaName04,
		MAX(A05.AnaName) AS AnaName05,
		MAX(A06.AnaName) AS AnaName06,
		MAX(A07.AnaName) AS AnaName07,
		MAX(A08.AnaName) AS AnaName08,
		MAX(A09.AnaName) AS AnaName09,
		MAX(A10.AnaName) AS AnaName10,
		MAX(AT9000.Parameter01) AS Parameter01,
		MAX(AT9000.Parameter02) AS Parameter02,
		MAX(AT9000.Parameter03) AS Parameter03,
		MAX(AT9000.Parameter04) AS Parameter04,
		MAX(AT9000.Parameter05) AS Parameter05,
		MAX(AT9000.Parameter06) AS Parameter06,
		MAX(AT9000.Parameter07) AS Parameter07,
		MAX(AT9000.Parameter08) AS Parameter08,
		MAX(AT9000.Parameter09) AS Parameter09,
		MAX(AT9000.Parameter10) AS Parameter10,
		MAX(OT2001.SOrderID) AS SOrderID, MAX(OT2001.OrderDate) AS OrderDate, OT2001.ClassifyID,
		(CASE WHEN TransactionTypeID = ''T99'' THEN  B.O01ID ELSE A.O01ID END) AS O01ID ,
		(CASE WHEN TransactionTypeID = ''T99'' THEN  B.O02ID ELSE A.O02ID END) AS O02ID ,
		(CASE WHEN TransactionTypeID = ''T99'' THEN  B.O03ID ELSE A.O03ID END) AS O03ID ,
		(CASE WHEN TransactionTypeID = ''T99'' THEN  B.O04ID ELSE A.O04ID END) AS O04ID ,
		(CASE WHEN TransactionTypeID = ''T99'' THEN  B.O05ID ELSE A.O05ID END) AS O05ID ,
		T01.AnaName AS O01Name, 
		T02.AnaName AS O02Name,
		T03.AnaName AS O03Name,
		T04.AnaName AS O04Name,
		T05.AnaName AS O05Name'
Set @sqlExec1 = N'
into #AV0312
FROM AT9000  WITH (NOLOCK)	
LEFT JOIN AT1202  A WITH (NOLOCK) ON A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A.ObjectID = AT9000.ObjectID
LEFT JOIN AT1202  B WITH (NOLOCK) ON B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND B.ObjectID = AT9000.CreditObjectID
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1005.AccountID = AT9000.CreditAccountID AND GroupID =''G03'' AND IsObject = 1
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A01.AnaID = AT9000.Ana01ID AND A01.AnaTypeID =''A01''
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A02.AnaID = AT9000.Ana02ID AND A02.AnaTypeID =''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A03.AnaID = AT9000.Ana03ID AND A03.AnaTypeID =''A03''
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A04.AnaID = AT9000.Ana04ID AND A04.AnaTypeID =''A04''
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A05.AnaID = AT9000.Ana05ID AND A05.AnaTypeID =''A05''
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A06.AnaID = AT9000.Ana06ID AND A06.AnaTypeID =''A06''
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A07.AnaID = AT9000.Ana07ID AND A07.AnaTypeID =''A07''
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A08.AnaID = AT9000.Ana08ID AND A08.AnaTypeID =''A08''
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A09.AnaID = AT9000.Ana09ID AND A09.AnaTypeID =''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A10.AnaID = AT9000.Ana10ID AND A10.AnaTypeID =''A10''
LEFT JOIN  OT2001 WITH (NOLOCK) ON OT2001.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND  OT2001.SOrderID = AT9000.OrderID	and OT2001.DivisionID = AT9000.DivisionID	
LEFT JOIN AT1015 T01 WITH (NOLOCK) ON T01.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T01.AnaID =  (CASE WHEN TransactionTypeID =''T99'' THEN  B.O01ID ELSE A.O01ID END)  AND T01.AnaTypeID = ''O01'' 
LEFT JOIN AT1015 T02 WITH (NOLOCK) ON T02.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T02.AnaID =  (CASE WHEN TransactionTypeID =''T99'' THEN  B.O02ID ELSE A.O02ID END)  AND T02.AnaTypeID = ''O02''
LEFT JOIN AT1015 T03 WITH (NOLOCK) ON T03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T03.AnaID =  (CASE WHEN TransactionTypeID =''T99'' THEN  B.O03ID ELSE A.O03ID END) AND T03.AnaTypeID = ''O03''
LEFT JOIN AT1015 T04 WITH (NOLOCK) ON T04.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T04.AnaID =  (CASE WHEN TransactionTypeID =''T99'' THEN  B.O04ID ELSE A.O04ID END) AND T04.AnaTypeID = ''O04''
LEFT JOIN AT1015 T05 WITH (NOLOCK) ON T05.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T05.AnaID =  (CASE WHEN TransactionTypeID =''T99'' THEN  B.O05ID ELSE A.O05ID END)  AND T05.AnaTypeID = ''O05'''
Set @sqlExec2 = N'
Where AT9000.DivisionID = '''+@DivisionID+''' and (CASE WHEN TransactionTypeID = ''T99'' THEN AT9000.CreditObjectID ELSE AT9000.ObjectID END)like ('''+@ObjectID+''') and CreditAccountID like ('''+@AccountID+''')
GROUP BY AT9000.VoucherID, BatchID, TableID, AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear,
		(CASE WHEN TransactionTypeID =''T99'' THEN  AT9000.CreditObjectID ELSE AT9000.ObjectID END),
		CreditAccountID, AT9000.CurrencyID, CurrencyIDCN, 
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.ObjectName  ELSE A.ObjectName  END),
		AT9000.ExchangeRate, ExchangeRateCN, AT9000.STATUS, AT9000.VoucherTypeID, AT9000.VoucherNo, VoucherDate,
		InvoiceDate, InvoiceNo, Serial, VDescription, VDescription, VDescription, AT9000.PaymentID, AT9000.DueDays, AT9000.DueDate, 
		OT2001.ClassifyID,
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.O01ID ELSE A.O01ID END)  ,
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.O02ID ELSE A.O02ID END)  ,
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.O03ID ELSE A.O03ID END)  ,
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.O04ID ELSE A.O04ID END)  ,
		(CASE WHEN TransactionTypeID =''T99'' THEN  B.O05ID ELSE A.O05ID END),
				T01.AnaName , T02.AnaName ,T03.AnaName ,T04.AnaName ,T05.AnaName

		'
Set @sqlSelect = N'
	  SELECT SUM(ISNULL(T03.ConvertedAmount,0)) AS GivedConvertedAmount,
	  SUM(ISNULL(T03.OriginalAmount,0)) AS GivedOriginalAmount,
	  T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID,T03.AccountID,
	  T03.DivisionID, T03.CurrencyID
	  INTO #AT0303
	  FROM AT0303 T03  WITH (NOLOCK)
	  GROUP BY T03.ObjectID, T03.CreditVoucherID,T03.CreditBatchID,T03.AccountID, T03.DivisionID,T03.CurrencyID

	  Delete AT0302
	  WHERE DivisionID = '''+@DivisionID+''' and ObjectID like ('''+@ObjectID+''') and CreditAccountID like ('''+@AccountID+''')
	  Insert into AT0302 (GiveUpID, VoucherID, BatchID,  TableID, DivisionID,TranMonth,TranYear,
      ObjectID, CreditAccountID, CurrencyID, CurrencyIDCN,
      ObjectName, OriginalAmount,ConvertedAmount,
      OriginalAmountCN, GivedOriginalAmount,  GivedConvertedAmount,   ExchangeRate, ExchangeRateCN,
      VoucherTypeID, VoucherNO, VoucherDate,  InvoiceDate,InvoiceNo, Serial,
      VDescription,BDescription,  Status,   PaymentID, DueDays, DueDate)
      SELECT GiveUpID, VoucherID, BatchID,  TableID, DivisionID,TranMonth,TranYear,
      ObjectID, CreditAccountID, CurrencyID, CurrencyIDCN,
      ObjectName , OriginalAmount, ConvertedAmount,
      OriginalAmountCN,GivedOriginalAmount,GivedConvertedAmount,  ExchangeRate, ExchangeRateCN,
      VoucherTypeID, VoucherNO, VoucherDate,  InvoiceDate,InvoiceNo, Serial,
      VDescription,BDescription,  Status, PaymentID , DueDays, DueDate
      From
      '

Set @sqlSelect1 = N'
(SELECT   '''' AS GiveUpID, 
		T9.VoucherID AS VoucherID,
		T9.CreditAccountID, 
		T9.BatchID,  
		T9.TableID,		T9.DivisionID,T9.TranMonth, T9.TranYear,
		T9.ObjectID,	
		(SELECT TOP 1 ObjectName FROM AT1202 WITH(NOLOCK) WHERE DivisionID IN ('''+ @DivisionID +''',''@@@'') AND ObjectID = T9.ObjectID) AS ObjectName,
		--A.ObjectName,		
		T9.CurrencyID, T9.CurrencyIDCN,
		ExchangeRate, ExchangeRateCN,
		VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
		VDescription, VDescription AS BDescription,	
		T9.PaymentID, T9.DueDays, T9.DueDate,				
		ISNULL(T3.GivedOriginalAmount, 0) AS GivedOriginalAmount,		
		ISNULL(T3.GivedConvertedAmount,0) AS GivedConvertedAmount,
		T9.OriginalAmount AS OriginalAmount, T9.STATUS,	
		T9.OriginalAmountCN AS OriginalAmountCN,
		T9.ConvertedAmount AS ConvertedAmount, 
		T9.Ana01ID, T9.AnaName01, 
		T9.Ana02ID,	T9.AnaName02,
		T9.Ana03ID, T9.AnaName03,
		T9.Ana04ID, T9.AnaName04,
		T9.Ana05ID, T9.AnaName05
FROM		#AV0312 T9	
LEFT JOIN	#AT0303 T3
	ON		T3.DivisionID = T9.DivisionID AND
			T3.ObjectID = T9.ObjectID  and
			T3.CreditVoucherID = T9.VoucherID AND
			T3.CreditBatchID = T9.BatchID AND
			T3.AccountID = T9.CreditAccountID
INNER JOIN	AT1005  WITH (NOLOCK)
	ON 		AT1005.AccountID = T9.CreditAccountID and
			AT1005.GroupID=''G03''
GROUP BY 	T9.VoucherID,		T9.BatchID,  
			T9.OriginalAmount,	T9.OriginalAmountCN, T9.ConvertedAmount,
			T9.CreditAccountID, 
			T9.Ana01ID, T9.AnaName01, 
			T9.Ana02ID,	T9.AnaName02,
			T9.Ana03ID, T9.AnaName03,
			T9.Ana04ID, T9.AnaName04,
			T9.Ana05ID, T9.AnaName05,
			T9.TableID, T9.DivisionID,T9.TranMonth, T9.TranYear,
			T9.ObjectID ,T9.CurrencyID, T9.CurrencyIDCN,
			ExchangeRate, ExchangeRateCN, T9.STATUS,	
			VoucherTypeID, VoucherNO, VoucherDate,InvoiceDate,InvoiceNo, Serial,
			VDescription, 	
			T9.PaymentID, T9.DueDays, T9.DueDate,
			--A.ObjectName,
			ISNULL(T3.GivedOriginalAmount, 0),
			ISNULL(T3.GivedConvertedAmount,0))A'

SET @sqlUpdate='
	IF EXISTS (SELECT * FROM AT0302 WHERE DivisionID = '''+@DivisionID+''' AND ObjectID='''+@ObjectID+''' AND CreditAccountID = '''+@AccountID+''' AND ISNULL(OriginalAmount,0)-ISNULL(GivedOriginalAmount,0) = 0 AND ISNULL(ConvertedAmount,0)-ISNULL(GivedConvertedAmount,0)<>0)
	BEGIN
		SELECT A1.VoucherID, A1.VoucherNo, SUM(ISNULL(A2.ConvertedAmount,0)) AS GivedConvertedAmount,
			(SELECT TOP 1 ISNULL(A3.ConvertedAmount,0) FROM AT0303 A3 WITH(NOLOCK) INNER JOIN AT9000 A90 WITH (NOLOCK) ON A3.DivisionID = A90.DivisionID AND A90.TransactionTypeID=''T10'' 
																											AND A3.DebitVoucherID=A90.VoucherID
				WHERE A3.AccountID = '''+@AccountID+''' AND A3.ObjectID = '''+@ObjectID+''' AND A3.CreditVoucherID = A2.CreditVoucherID 
						AND ABS(ISNULL(A1.GivedConvertedAmount,0) - ISNULL(A1.ConvertedAmount,0)) = ISNULL(A3.ConvertedAmount,0)
			 ) AS DiffConvertedAmount
		INTO #DiffConvertedAmount
		FROM AT0302 A1 WITH(NOLOCK) INNER JOIN AT0303 A2 WITH(NOLOCK) ON A1.VoucherID = A2.CreditVoucherID
		WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.ObjectID='''+@ObjectID+''' AND A1.CreditAccountID = '''+@AccountID+''' AND ISNULL(A1.OriginalAmount,0)-ISNULL(A1.GivedOriginalAmount,0) = 0 
		AND ISNULL(A1.ConvertedAmount,0)-ISNULL(A1.GivedConvertedAmount,0)<>0 
		GROUP BY A1.VoucherID, A1.VoucherNo, ISNULL(A1.GivedConvertedAmount,0), ISNULL(A1.ConvertedAmount,0), A2.CreditVoucherID
	

		UPDATE A01
		SET A01.GivedConvertedAmount = CASE WHEN ISNULL(A01.ConvertedAmount,0) - ISNULL(A01.GivedConvertedAmount,0) > 0 THEN ISNULL(A01.GivedConvertedAmount,0) + ISNULL(A02.DiffConvertedAmount,0) ELSE ISNULL(A01.GivedConvertedAmount,0) - ISNULL(A02.DiffConvertedAmount,0) END 
		FROM AT0302 A01 INNER JOIN #DiffConvertedAmount A02 ON A01.VoucherID = A02.VoucherID
	
	END

'


Exec(@sqlExec + @sqlExec1 + @sqlExec2 +  @sqlSelect +  @sqlSelect1 + @sqlUpdate)
End









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
