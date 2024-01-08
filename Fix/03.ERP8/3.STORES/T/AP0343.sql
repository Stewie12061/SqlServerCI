IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0343]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0343]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Bao cao chi tiet cong no giai tru phai thu, can cu tu phieu thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----- Created by Nguyen Van  Nhan, Date 02/06/2009 
---
---- Modified on 06/12/2011 by Le Thi Thu Hien : Sua ngay CONVERT(varchar(10),VoucherDate,101)
---- Modified on 16/01/2012 by Le Thi Thu Hien : Chinh sua CONVERT ngay
---- Modified on 26/02/2012 by Le Thi Thu Hien : Bổ sung 5 khoản mục
---- Modified on 06/03/2013 by Khanh Van: Bo sung tu tai khoan den tai khoan cho Sieu Thanh
---- Modified on 27/10/2015 by Phuong Thao: Bo sung khai bao bang cho cac truong
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Văn Minh on 26/02/2020: Bổ sung thêm trường ReDueDays
---- Modified by Huỳnh Thử on 16/04/2020: Fix: Bổ sung thêm trường ReDueDays
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP0343]  
				@DivisionID nvarchar(50), 
				@FromObjectID AS nvarchar(50),
				@ToObjectID AS nvarchar(50),
				@FromAccountID  AS nvarchar(50),
				@ToAccountID  AS nvarchar(50),
				@CurrencyID  AS nvarchar(50),
				@IsDate AS tinyint,
				@FromDate AS Datetime,
				@ToDate AS  Datetime,
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int	
			
 AS
Declare @sSQL AS nvarchar(4000),
		@sTime AS nvarchar(4000),
		@sTime1 AS nvarchar(4000),
		@sSQL1 AS nvarchar(MAX) = '',
		@sSQL2 AS nvarchar(MAX) = '',
		@CustomerName INT = -1,
		@sSELECT AS Nvarchar(MAX) = ''

SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

if @IsDate =0
	set 	@sTime='(TranMonth +100*TranYear between '+str(@FromMonth)+' + '+str(@FromYear)+'*100 AND '+str(@ToMonth)+' + '+str(@ToYear)+'*100) '
Else
	Set 	@sTime ='CONVERT(DATETIME,CONVERT(varchar(10),VoucherDate,101),101)  Between '''+ convert(nvarchar(10),@FromDate,101) +''' AND '''+convert(nvarchar(10),@ToDate,101)+'''  '

if @IsDate =0
	set 	@sTime1='(Month(CreditVoucherDate) +100*Year(CreditVoucherDate) between '+str(@FromMonth)+' + '+str(@FromYear)+'*100 AND '+str(@ToMonth)+' + '+str(@ToYear)+'*100) '
Else
	Set 	@sTime1 ='CONVERT(DATETIME,CONVERT(varchar(10),CreditVoucherDate,101),101)  Between '''+ convert(nvarchar(10),@FromDate,101) +''' AND '''+convert(nvarchar(10),@ToDate,101)+'''  '



Set 	@sSQL = '
SELECT 	AV0302.VoucherDate, AV0302.VoucherNo, AV0302.Vdescription, AV0302.ObjectID, AT1202.ObjectName, AV0302.BatchID, AV0302.VoucherID, AV0302.TableID, AV0302.CreditAccountID,
		AV0302.OriginalAmountCN, AV0302.ConvertedAmount, AV0302.GivedOriginalAmount, AV0302.GivedConvertedAmount,
		AV0302.OriginalAmountCN-isnull(AV0302.GivedOriginalAmount,0) AS RemainOriginalAmount,
  		AV0302.ConvertedAmount -isnull(AV0302.GivedConvertedAmount,0) AS RemainConvertedAmount,
  		AV0302.DivisionID,
  		AV0302.Ana01ID, AV0302.AnaName01, 
		AV0302.Ana02ID,	AV0302.AnaName02,
		AV0302.Ana03ID, AV0302.AnaName03,
		AV0302.Ana04ID, AV0302.AnaName04,
		AV0302.Ana05ID, AV0302.AnaName05
FROM	AV0302 
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV0302.ObjectID
WHERE	AV0302.DivisionID = '''+@DivisionID+''' AND
		AV0302.CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
		AV0302.CurrencyID ='''+@CurrencyID+''' AND
		AV0302.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+'''  AND '+@sTime+' '

---PRINT @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND  NAME ='AV0344')
	EXEC ('CREATE VIEW AV0344   AS '+@sSQL)
ELSE
	EXEC( 'ALTER VIEW AV0344   AS '+@sSQL)

---Edit by Nguyen Quoc Huy,date 16/06/2008   '''' AS VoucherNo
set @sSQL='
SELECT 	AT0303.DebitVoucherDate, AT0303.CreditVoucherDate AS VoucherDate, AV0301.VoucherNo, 
		AV0301.InvoiceDate, AV0301.InvoiceNo, AV0301.Vdescription, 
		AV0301.ObjectID, AT1202.ObjectName, 
		AT0303.CreditBatchID AS BatchID,  AT0303.CreditVoucherID AS VoucherID, AV0301.TableID, 
		AT0303.OriginalAmount AS GivedOriginalAmount, 
		AT0303.ConvertedAmount AS GivedConvertedAmount, 
		AT0303.DivisionID,
		AV0301.Ana01ID, AV0301.AnaName01, 
		AV0301.Ana02ID,	AV0301.AnaName02,
		AV0301.Ana03ID, AV0301.AnaName03,
		AV0301.Ana04ID, AV0301.AnaName04,
		AV0301.Ana05ID, AV0301.AnaName05
FROM	AT0303  WITH (NOLOCK)
INNER JOIN (SELECT	AT9000.DivisionID, AT9000.VoucherNo,  AT9000.InvoiceDate, AT9000.InvoiceNo, 
					AT9000.VoucherDate, AT9000.VDescription, AT9000.ObjectID, AT9000.VoucherID, AT9000.BatchID, AT9000.TableID, 
					sum(AT9000.OriginalAmountCN) AS OriginalAmountCN, 
					Sum(AT9000.convertedAmount) AS ConvertedAmount,
					MAX(AT9000.Ana01ID) AS Ana01ID, 
					MAX(AT9000.Ana02ID) AS Ana02ID, 
					MAX(AT9000.Ana03ID) AS Ana03ID, 
					MAX(AT9000.Ana04ID) AS Ana04ID, 
					MAX(AT9000.Ana05ID) AS Ana05ID, 
					MAX(A01.AnaName) AS AnaName01,
					MAX(A02.AnaName) AS AnaName02,
					MAX(A03.AnaName) AS AnaName03,
					MAX(A04.AnaName) AS AnaName04,
					MAX(A05.AnaName) AS AnaName05
            FROM	AT9000 WITH (NOLOCK)
            LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = AT9000.Ana01ID AND A01.AnaTypeID =''A01'' 
			LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID = AT9000.Ana01ID AND A02.AnaTypeID =''A02'' 
			LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaID = AT9000.Ana01ID AND A03.AnaTypeID =''A03'' 
			LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaID = AT9000.Ana01ID AND A04.AnaTypeID =''A04'' 
			LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaID = AT9000.Ana01ID AND A05.AnaTypeID =''A05'' 
			WHERE	DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND CurrencyIDCN ='''+@CurrencyID+'''  AND
					AT9000.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+''' --and '+@sTime+' 
			GROUP BY AT9000.DivisionID, VoucherNo,  InvoiceDate, InvoiceNo, VoucherDate, VDescription, AT9000.ObjectID, VoucherID, BatchID, TableID
			) AS AV0301 
	ON 	AV0301.VoucherID = AT0303.DebitVoucherID AND
		AV0301.BatchID = AT0303.DebitBatchID AND
	 	AV0301.ObjectID = AT0303.ObjectID AND
		AV0301.TableID = AT0303.DebitTableID AND
		AV0301.DivisionID = AT0303.DivisionID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT0303.ObjectID
WHERE	AT0303.DivisionID = '''+@DivisionID+''' AND
		AT0303.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+'''  AND
		AT0303.CurrencyID ='''+@CurrencyID+''' AND '+@sTime1+'  AND
		AT0303.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+'''  ' 
--Print @sSQL

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND  NAME ='AV0342')
	EXEC ('CREATE VIEW AV0342   AS '+@sSQL)
ELSE
	EXEC( 'ALTER VIEW AV0342   AS '+@sSQL)


IF(@CustomerName = 44)
BEGIN
	SET @sSQL1 = '
		LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.ObjectID = AV0344.ObjectID AND T1.DivisionID IN (AV0344.DivisionID,''@@@'')
		LEFT JOIN AT1015 T2 WITH (NOLOCK) ON T1.O01ID = T2.AnaID AND T2.AnaTypeID = ''O01''
		LEFT JOIN AT1015 T3 WITH (NOLOCK) ON T1.O02ID = T3.AnaID AND T3.AnaTypeID = ''O02''
		LEFT JOIN AT1015 T4 WITH (NOLOCK) ON T1.O03ID = T4.AnaID AND T4.AnaTypeID = ''O03''
		LEFT JOIN AT1015 T5 WITH (NOLOCK) ON T1.O04ID = T5.AnaID AND T5.AnaTypeID = ''O04''
		LEFT JOIN AT1015 T6 WITH (NOLOCK) ON T1.O05ID = T6.AnaID AND T6.AnaTypeID = ''O05'''
	SET @sSQL2 = '
		LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.ObjectID = AV0342.ObjectID AND T1.DivisionID IN (AV0342.DivisionID,''@@@'')
		LEFT JOIN AT1015 T2 WITH (NOLOCK) ON T1.O01ID = T2.AnaID AND T2.AnaTypeID = ''O01''
		LEFT JOIN AT1015 T3 WITH (NOLOCK) ON T1.O02ID = T3.AnaID AND T3.AnaTypeID = ''O02''
		LEFT JOIN AT1015 T4 WITH (NOLOCK) ON T1.O03ID = T4.AnaID AND T4.AnaTypeID = ''O03''
		LEFT JOIN AT1015 T5 WITH (NOLOCK) ON T1.O04ID = T5.AnaID AND T5.AnaTypeID = ''O04''
		LEFT JOIN AT1015 T6 WITH (NOLOCK) ON T1.O05ID = T6.AnaID AND T6.AnaTypeID = ''O05'''
	SET @sSELECT = '
		,ISNULL(T1.ReDueDays,0) AS ReDueDays,T1.O01ID,T1.O02ID,T1.O03ID,T1.O04ID,T1.O05ID,
		T2.AnaName As O01Name,T3.AnaName As O02Name,T4.AnaName As O03Name,T5.AnaName As O04Name,T6.AnaName As O05Name'
END


Set @sSQL='
SELECT 	0 AS ID, VoucherDate AS ReVoucherDate, VoucherDate, VoucherNo, VDescription , AV0344.ObjectID, AV0344.ObjectName,  BatchID, VoucherID,
		OriginalAmountCN, ConvertedAmount, RemainOriginalAmount, RemainConvertedAmount,
		null AS InvoiceDate, null AS invoiceNo, null AS VDescription_In,
		0 AS GivedOriginalAmount, 0 AS GivedConvertedAmount,
		VoucherDate AS CreditVoucherDate, AV0344.DivisionID,
		AV0344.Ana01ID, AV0344.AnaName01, 
		AV0344.Ana02ID,	AV0344.AnaName02,
		AV0344.Ana03ID, AV0344.AnaName03,
		AV0344.Ana04ID, AV0344.AnaName04,
		AV0344.Ana05ID, AV0344.AnaName05'+@sSELECT+'
FROM	AV0344 '+@sSQL1+'
UNION ALL 
SELECT	1 AS ID, DebitVoucherDate AS ReVoucherDate, VoucherDate AS VoucherDate, VoucherNo, Vdescription AS VDescription , AV0342.ObjectID,  AV0342.ObjectName, BatchID, VoucherID,
		0 AS OriginalAmountCN, 0 AS ConvertedAmount, 0 AS RemainOriginalAmount, 0 AS RemainConvertedAmount,
		InvoiceDate,  invoiceNo, VDescription AS VDescription_In,
		GivedOriginalAmount, GivedConvertedAmount,
		null AS CreditVoucherDate, AV0342.DivisionID,
		AV0342.Ana01ID, AV0342.AnaName01, 
		AV0342.Ana02ID,	AV0342.AnaName02,
		AV0342.Ana03ID, AV0342.AnaName03,
		AV0342.Ana04ID, AV0342.AnaName04,
		AV0342.Ana05ID, AV0342.AnaName05'+@sSELECT+'
FROM	AV0342 ' + @sSQL2


--PRINT @sSQL

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND  NAME ='AV0343')
	EXEC ('CREATE VIEW AV0343   AS '+@sSQL)
ELSE
	EXEC( 'ALTER VIEW AV0343   AS '+@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
