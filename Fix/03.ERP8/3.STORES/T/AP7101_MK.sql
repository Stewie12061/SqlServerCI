IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7101_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7101_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- In so cai - In dang chi tiet tung but toan
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 11/08/2003 by Nguyen Van Nhan
------- Edited BY Nguyen Quoc Huy, Date 30/09/2005.
------- 
---- Modified on 13/09/2011 by Le Thi Thu Hien : bo sung Orders
---- Modified on 30/03/2012 by Le Thi Thu Hien : bo sung SenderReceiver
---- Modified on 17/08/2012 by Le Thi Thu Hien : Bổ sung khoản mục, tên khoản mục
---- Modified on 22/10/2012 by Bao Anh : Bổ sung VoucherID, TableID, Status
---- Modified on 18/11/2012 by Bao Anh : Bổ sung nghiệp vụ ngoại bảng
---- Modified on 23/01/2013 by Bao Anh : Bổ sung RefNo01, RefNo02
---- Modified on 20/05/2013 by Le Thi Thu Hien : Bổ sung Ana06ID --> Ana10ID, 
---- Modified on 12/08/2013 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified on 03/10/2013 by Trần Quốc Tuấn : Bổ sung điều kiện lộc in số dư đầu kỳ đúng
---- Modified on 19/03/2015 by Trần Quốc Tuấn : Bổ sung SRDivisionName,SRAddress
---- Modified on 16/04/2015 by Thanh Sơn: Bổ sung ObjectName cho Long Giang
---- Modified on 15/06/2016 by Kim Vũ: Bổ sung lấy IsWithhodingTax
---- Modified on 06/09/2016 by Phương Thảo: Bổ sung Đối tượng Nợ, Đối tượng Có
---- Modified on 01/04/2019 by Kim Thư: Nối tên TK tiếng Anh sau mã tài khoản
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

--	EXEC AP7101 @DivisionID=N'CTY',@TranMonthFrom=4,@TranYearFrom=2012,@TranMonthTo=4,@TranYearTo=2012,@FromDate='2012-08-17 08:35:19.09',@ToDate='2012-08-17 08:35:19.09',@IsDate=0,@AccountIDFrom=N'001',@AccountIDTo=N'911',@Level1=0,@StrDivisionID='',@StrFinderMaster =''
--  SELECT * FROM AV7101

CREATE PROCEDURE [dbo].[AP7101_MK]
		@DivisionID AS NVARCHAR(50),
		@TranMonthFrom AS INT,
		@TranYearFrom AS INT,
		@TranMonthTo AS INT,
		@TranYearTo AS INT,
		@FromDate AS datetime,
		@ToDate  AS datetime,
		@IsDate AS tinyint,
		@AccountIDFrom AS NVARCHAR(50),
		@AccountIDTo AS NVARCHAR(50),
		@Level1 AS TINYINT,
		@UserID AS NVARCHAR(50) = 'ASOFTADMIN',
		@StrDivisionID AS NVARCHAR(4000) = '',
		@StrFinderMaster AS NVARCHAR(MAX)
AS

DECLARE 	@strSQL AS NVARCHAR(MAX),
			@sSQLUnion AS NVARCHAR(MAX)

IF @Level1 = 0
	SET @strSQL = '
		SELECT  '''+@DivisionID +''' AS DivisionID,			BatchID,				TransactionTypeID,
				AccountID,			CorAccountID,			D_C,			
				DebitAccountID, 	CreditAccountID,	
				Case when TransactionTypeID=''T98'' then  DateAdd(hh,1, VoucherDate) else  VoucherDate end AS  VoucherDate,		
				VoucherTypeID,	VoucherNo,
				InvoiceDate,		InvoiceNo,				Serial,			
				Sum(isnull(ConvertedAmount,0)) AS ConvertedAmount,
				Sum(isnull(OriginalAmount,0)) AS OriginalAmount,		
				Sum(isnull(OSignAmount,0)) AS OSignAmount,
				Sum(isnull(SignAmount,0)) AS SignAmount,
				CurrencyID,			ExchangeRate,		
				TranMonth,			TranYear,	
				TranMonth + TranYear*100 AS Period,
				CreateUserID,		VDescription,			BDescription, TDescription,
				ObjectID,			VATObjectID,
				VATNo,				VATObjectName,			Object_Address,	
				VATTypeID,			VATGroupID,		
				AccountID AS LinkAccountID ,
				AV5000.Orders,
				AV5000.SenderReceiver,
				AV5000.Ana01ID,AV5000.Ana02ID,AV5000.Ana03ID,AV5000.Ana04ID,AV5000.Ana05ID,
				AV5000.Ana06ID,AV5000.Ana07ID,AV5000.Ana08ID,AV5000.Ana09ID,AV5000.Ana10ID,
				AV5000.AnaName01,AV5000.AnaName02,AV5000.AnaName03,AV5000.AnaName04,AV5000.AnaName05,
				AV5000.AnaName06,AV5000.AnaName07,AV5000.AnaName08,AV5000.AnaName09,AV5000.AnaName10,
				AV5000.VoucherID, AV5000.TableID, AV5000.Status, AV5000.RefNo01, AV5000.RefNo02,AV5000.SRDivisionName,AV5000.SRAddress,
				AV5000.IsWithhodingTax,
				AV5000.DebitObjectID, AV5000.DebitObjectName,
				AV5000.CreditObjectID, AV5000.CreditObjectName				
				'
ELSE
	SET @strSQL = '
		SELECT 	'''+@DivisionID +''' AS DivisionID,			BatchID,				TransactionTypeID,
				AccountID,			CorAccountID,			D_C,			
				DebitAccountID, 
				CreditAccountID,	
				Case when TransactionTypeID=''T98'' then  DateAdd(hh,1, VoucherDate) else  VoucherDate end AS  VoucherDate,		
				VoucherTypeID,		VoucherNo,
				InvoiceDate,		InvoiceNo,				Serial,			
				Sum(isnull(ConvertedAmount,0)) AS ConvertedAmount,
				Sum(isnull(OriginalAmount,0)) AS OriginalAmount,	
				Sum(isnull(OSignAmount,0)) AS OSignAmount,
				Sum(isnull(SignAmount,0)) AS SignAmount,	
				CurrencyID,			ExchangeRate,		
				TranMonth,			TranYear,				TranMonth + TranYear*100 AS Period,
				CreateUserID,				
				VDescription,		BDescription,			TDescription,
				ObjectID,			VATObjectID,
				VATNo,				VATObjectName,			Object_Address,	
				VATTypeID,			VATGroupID,		
				left(AccountID,' + str(@Level1+2) + ') AS LinkAccountID,
				AV5000.Orders,
				AV5000.SenderReceiver,
				AV5000.Ana01ID,AV5000.Ana02ID,AV5000.Ana03ID,AV5000.Ana04ID,AV5000.Ana05ID,
				AV5000.Ana06ID,AV5000.Ana07ID,AV5000.Ana08ID,AV5000.Ana09ID,AV5000.Ana10ID,
				AV5000.AnaName01,AV5000.AnaName02,AV5000.AnaName03,AV5000.AnaName04,AV5000.AnaName05,
				AV5000.AnaName06,AV5000.AnaName07,AV5000.AnaName08,AV5000.AnaName09,AV5000.AnaName10,
				AV5000.VoucherID, AV5000.TableID, AV5000.Status, AV5000.RefNo01, AV5000.RefNo02,AV5000.SRDivisionName,AV5000.SRAddress,
				AV5000.IsWithhodingTax,
				AV5000.DebitObjectID, AV5000.DebitObjectName,
				AV5000.CreditObjectID, AV5000.CreditObjectName'

SET @strSQL = @strSQL + ' 
		FROM	AV5000 '
SET @strSQL =	@strSQL + ' 
		WHERE	DivisionID like ''' + @StrDivisionID +'''
				AND (AccountID like ''' + @AccountIDFrom +'%''  OR AccountID like ''' + @AccountIDTo +'%''
				OR (AccountID >=  ''' + @AccountIDFrom +''' AND AccountID <=  ''' + @AccountIDTo +'''))
				AND '+@StrFinderMaster+''

If @IsDate = 0
	SET @strSQL =	@strSQL + ' AND TranYear*100+TranMonth <= ''' + str(@TranYearTo*100+@TranMonthTo) + ''''
Else 
	SET @strSQL =	@strSQL + ' AND VoucherDate <= ''' + convert(varchar(20),@ToDate,101) + ''' '		

SET @strSQL =	@strSQL + '  
		GROUP BY	BatchID,		TransactionTypeID,
					AccountID,		CorAccountID,		D_C,			
					DebitAccountID, CreditAccountID,	
					VoucherDate,	VoucherTypeID,		VoucherNo,
					InvoiceDate,	InvoiceNo,			Serial,								
					CurrencyID,		ExchangeRate,		TranMonth,		TranYear,
					CreateUserID,	VDescription,		BDescription,	TDescription,
					ObjectID,		VATObjectID,
					VATNo,			VATObjectName,		Object_Address,	
					VATTypeID,		VATGroupID,		
					AccountID,		Orders ,			AV5000.SenderReceiver,
					AV5000.Ana01ID,AV5000.Ana02ID,AV5000.Ana03ID,AV5000.Ana04ID,AV5000.Ana05ID,
					AV5000.Ana06ID,AV5000.Ana07ID,AV5000.Ana08ID,AV5000.Ana09ID,AV5000.Ana10ID,
					AV5000.AnaName01,AV5000.AnaName02,AV5000.AnaName03,AV5000.AnaName04,AV5000.AnaName05,
					AV5000.AnaName06,AV5000.AnaName07,AV5000.AnaName08,AV5000.AnaName09,AV5000.AnaName10,
					AV5000.VoucherID, AV5000.TableID, AV5000.Status, AV5000.RefNo01, AV5000.RefNo02,AV5000.SRDivisionName,AV5000.SRAddress,
					AV5000.IsWithhodingTax,
					AV5000.DebitObjectID, AV5000.DebitObjectName,
					AV5000.CreditObjectID, AV5000.CreditObjectName'

Set @sSQLUnion = '
		UNION ALL
		SELECT  '''+@DivisionID +''' AS DivisionID,	NULL as	BatchID, TransactionTypeID,
				AccountID,	NULL as	CorAccountID, D_C,			
				DebitAccountID,	CreditAccountID,	
				VoucherDate, VoucherTypeID,	VoucherNo,
				NULL AS InvoiceDate, NULL AS InvoiceNo, NULL AS Serial,			
				isnull(ConvertedAmount,0) AS ConvertedAmount,
				isnull(OriginalAmount,0) AS OriginalAmount,		
				isnull(SignOriginalAmount,0) AS OSignAmount,
				isnull(SignConvertedAmount,0) AS SignAmount,
				CurrencyID,			ExchangeRate,		
				TranMonth,			TranYear,	
				TranMonth + TranYear*100 AS Period,
				NULL AS CreateUserID,		VDescription, NULL AS BDescription, TDescription,
				ObjectID, NULL AS VATObjectID,
				NULL AS VATNo,	NULL as	VATObjectName,	NULL as	Object_Address,	
				NULL AS VATTypeID,	NULL AS VATGroupID,		
				(case when ' + str(@Level1) + ' = 0 then AccountID else left(AccountID,' + str(@Level1+2) + ') end) AS LinkAccountID,
				NULL AS Orders,
				NULL AS SenderReceiver,
				NULL AS Ana01ID, NULL AS Ana02ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID,
				NULL AS Ana06ID,NULL AS Ana07ID,NULL AS Ana08ID,NULL AS Ana09ID,NULL AS Ana10ID,
				NULL AS AnaName01, NULL AS AnaName02, NULL AS AnaName03, NULL AS AnaName04, NULL AS AnaName05,
				NULL AS AnaName06,NULL AS AnaName07,NULL AS AnaName08,NULL AS AnaName09,NULL AS AnaName10,
				VoucherID, ''AT9004'' AS TableID, NULL AS Status, NULL AS RefNo01, NULL AS RefNo02,NULL AS SRDivisionName,NULL AS SRAddress,
				0 as IsWithhodingTax,
				CASE WHEN D_C = ''D'' THEN ObjectID ELSE NULL END AS DebitObjectID, 
				CASE WHEN D_C = ''D'' THEN ObjectName ELSE NULL END AS DebitObjectName, 
				CASE WHEN D_C = ''C'' THEN ObjectID ELSE NULL END AS CreditObjectID, 
				CASE WHEN D_C = ''C'' THEN ObjectName ELSE NULL END AS CreditObjectName
		FROM AV9004
		WHERE	DivisionID like ''' + @StrDivisionID +'''
				AND (AccountID like ''' + @AccountIDFrom +'%''  OR AccountID like ''' + @AccountIDTo +'%''
				OR (AccountID >=  ''' + @AccountIDFrom +''' AND AccountID <=  ''' + @AccountIDTo +'''))
		'
If @IsDate = 0
	SET @sSQLUnion =	@sSQLUnion + ' AND TranYear*100+TranMonth <= ''' + str(@TranYearTo*100+@TranMonthTo) + ''''
Else 
	SET @sSQLUnion =	@sSQLUnion + ' AND VoucherDate <= ''' + convert(varchar(20),@ToDate,101) + ''' '
	
--Print  @sSQLUnion

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4310' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV4310 --AP7101
	AS ' + @strSQL + @sSQLUnion)
ELSE
	EXEC ('ALTER VIEW AV4310 --AP7101
	AS ' + @strSQL + @sSQLUnion)


---- Chi hien thi So du
If @IsDate =0
Begin
SET @strSQL = 'SELECT V10.LinkAccountID, T01.AccountName, T01.AccountNameE, '''+@DivisionID +''' AS DivisionID, '
SET @strSQL = @strSQL + ' sum(case when V10.TranYear*100+TranMonth < ''' + str(@TranYearFrom*100+@TranMonthFrom) + 
				''' OR V10.TransactionTypeID = ''' + 'T00' + ''' OR V10.TransactionTypeID = ''' + 'Z00' + ''' then SignAmount else 0 end) AS OpeningAmount, '
SET @strSQL = @strSQL + ' sum(case when V10.VoucherDate < ''' + convert(varchar(20), @FromDate, 101) + 
				''' OR V10.TransactionTypeID = ''' + 'T00' + ''' OR V10.TransactionTypeID = ''' + 'Z00' + ''' then OSignAmount else 0 end) AS OOpeningAmount, '

SET @strSQL = @strSQL + ' sum(SignAmount) AS ClosingAmount,'

SET @strSQL = @strSQL + ' sum(OSignAmount) AS OClosingAmount,'

SET @strSQL = @strSQL +'SUM (CASE WHEN  (V10.TranYear*100+V10.TranMonth) <=  ''' + str(@TranYearTo*100+@TranMonthTo) + 
				''' AND (V10.TranYear >= ''' + str(@TranYearFrom) + ''') AND
							V10.D_C ='''+'D'+''' AND V10.TransactionTypeID <> '''+'T00'+''' AND V10.TransactionTypeID <> '''+'Z00'+'''
							THEN ConvertedAmount ELSE 0 END) AS AccumulatedDebit,'
SET @strSQL = @strSQL +'SUM (CASE WHEN  (V10.TranYear*100+V10.TranMonth) <=  ''' + str(@TranYearTo*100+@TranMonthTo) + 
				''' AND (V10.TranYear >= ''' + str(@TranYearFrom) + ''') AND
							V10.D_C ='''+'C'+''' AND V10.TransactionTypeID <> '''+'T00'+''' AND V10.TransactionTypeID <> '''+'Z00'+'''
							THEN ConvertedAmount ELSE 0 END) AS AccumulatedCredit'

SET @strSQL = @strSQL + ' FROM AV4310 AS V10'
SET @strSQL = @strSQL + ' LEFT JOIN AT1005 AS T01 ON T01.AccountID = V10.LinkAccountID and T01.DivisionID = '''+@DivisionID+''' '


IF @Level1 <> 0	
	SET @strSQL =	@strSQL + ' WHERE len(V10.LinkAccountID) = ''' +str(@Level1+2) + ''''


SET @strSQL =	@strSQL + ' GROUP BY V10.LinkAccountID, T01.AccountName , T01.AccountNameE '
End
Else
Begin
SET @strSQL = 'SELECT V10.LinkAccountID, T01.AccountName, T01.AccountNameE, '''+@DivisionID +''' AS DivisionID, '
SET @strSQL = @strSQL + ' sum(case when V10.VoucherDate < ''' + convert(varchar(20), @FromDate, 101) + 
				''' OR V10.TransactionTypeID = ''' + 'T00' +''' OR V10.TransactionTypeID = ''' + 'Z00' +''' then SignAmount else 0 end) AS OpeningAmount, '

SET @strSQL = @strSQL + ' sum(case when V10.VoucherDate < ''' + convert(varchar(20), @FromDate, 101) + 
				''' OR V10.TransactionTypeID = ''' + 'T00' +''' OR V10.TransactionTypeID = ''' + 'Z00' +''' then OSignAmount else 0 end) AS OOpeningAmount, '

SET @strSQL = @strSQL + ' sum(SignAmount) AS ClosingAmount,'
SET @strSQL = @strSQL + ' sum(OSignAmount) AS OClosingAmount,'

SET @strSQL = @strSQL +'SUM (CASE WHEN  V10.VoucherDate<=  ''' +Convert(varchar(20), @ToDate,101) + '''
						AND V10.VoucherDate >= ''' +Convert(varchar(20), @FromDate,101)  + ''' AND
							V10.D_C ='''+'D'+''' AND V10.TransactionTypeID <> '''+'T00'+''' AND V10.TransactionTypeID <> '''+'Z00'+'''
							THEN ConvertedAmount ELSE 0 END) AS AccumulatedDebit,'
SET @strSQL = @strSQL +'SUM (CASE WHEN V10.VoucherDate  <=  ''' + Convert(varchar(20), @ToDate,101) + ''' 
						AND V10.VoucherDate >= ''' +Convert(varchar(20), @FromDate,101)  + ''' AND
							V10.D_C ='''+'C'+''' AND V10.TransactionTypeID <> '''+'T00'+''' AND V10.TransactionTypeID <> '''+'Z00'+'''
							THEN ConvertedAmount ELSE 0 END) AS AccumulatedCredit'

SET @strSQL = @strSQL + ' FROM AV4310 AS V10'
SET @strSQL = @strSQL + ' LEFT JOIN AT1005 AS T01 ON T01.AccountID = V10.LinkAccountID and T01.DivisionID = '''+@DivisionID+''' '


IF @Level1 <> 0	
	SET @strSQL =	@strSQL + ' WHERE len(V10.LinkAccountID) = ''' +str(@Level1+2) + ''''


SET @strSQL =	@strSQL + ' GROUP BY V10.LinkAccountID, T01.AccountName , T01.AccountNameE '

End

--print @strSQL

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4315' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV4315 --AP7101
	AS ' + @strSQL)
ELSE

	EXEC ('ALTER VIEW AV4315 AS --AP7101
	' + @strSQL)


----- Tra ra View so lieu phat sinh -- error here
SET @strSQL = 'SELECT *'
SET @strSQL = @strSQL + ' FROM AV4310  AS V10'

--SET @strSQL =	@strSQL + ' WHERE TranYear*100+TranMonth >= ''' + str(@TranYearFrom*100+@TranMonthFrom) + ''''
--SET @strSQL =	@strSQL + 'AND (TransactionTypeID is NULL OR TransactionTypeID <> ''' + 'T00' +''')'
--IF @Level1 <> 0	
	--SET @strSQL =	@strSQL + 'AND len(V10.LinkAccountID) = ''' +str(@Level1+2) + ''''

IF @IsDate =0
	SET @strSQL =	@strSQL + ' WHERE V10.TranYear*100+V10.TranMonth >= ''' + str(@TranYearFrom*100+@TranMonthFrom) + ''''
Else
	SET @strSQL =	@strSQL + ' WHERE (V10.VoucherDate Between ''' + convert(varchar(20), @FromDate,101)+ ''' And '''+convert(varchar(20),@ToDate,101)+ ''') '
SET @strSQL =	@strSQL + ' AND (V10.TransactionTypeID is NULL OR (V10.TransactionTypeID <> ''' + 'T00' +''' and V10.TransactionTypeID <> ''' + 'Z00' + '''))'
IF @Level1 <> 0	
	SET @strSQL =	@strSQL + ' AND len(V10.LinkAccountID) = ''' +str(@Level1+2) + ''''

--print @strSQL

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4316' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV4316 --AP7101
	AS ' + @strSQL)
ELSE
	EXEC ('ALTER VIEW AV4316 --AP7101
	AS ' + @strSQL)                   

SET @strSQL = '
	SELECT		ISNULL(V16.DivisionID, V15.DivisionID) AS DivisionID,  V16.BatchID, V16.TransactionTypeID, V16.Period, 
				isnull(V16.LinkAccountID, V15.LinkAccountID) + '' - '' + V15.AccountNameE AS AccountID, 
				V16.CorAccountID + '' - '' + A05.AccountNameE AS CorAccountID,
				V16.D_C AS D_C,  V16.DebitAccountID,       V16.CreditAccountID,
				V16.VoucherTypeID,
       			V16.VoucherNo,             V16.InvoiceDate, V16.VoucherDate, 
				V16.InvoiceNo,             V16.Serial,                V16.ConvertedAmount,                 V16.OriginalAmount,
				V16.CurrencyID,            V16.ExchangeRate,           V16.SignAmount,                        V16.OSignAmount ,
				V16.TranMonth, V16.TranYear,   V16.CreateUserID,          V16.VDescription, V16.BDescription,  
				--isnull(V16.TDescription, isnull(V16.BDescription,V16.VDescription)) AS TDescription,
				(case when (isnull(V16.TDescription,'''')='''') then isnull(V16.BDescription,V16.VDescription) else V16.TDescription end) AS TDescription,
 				V16.ObjectID, (case when isnull(V16.VATObjectName,'''')='''' then A02.ObjectName  else V16.VATObjectName end) As ObjectName,
				V16.DebitObjectID, V16.DebitObjectName,
				V16.CreditObjectID, V16.CreditObjectName,
 				V16.VATObjectID,           V16.VATNo       ,          V16.VATObjectName,
				V16.Object_Address, 
				V16.VATTypeID,             V16.VATGroupID,
				V15.OpeningAmount, 
				V15.ClosingAmount, 
				V15.AccountName,				
				V15.OOpeningAmount, 
				V15.OClosingAmount,				
				V15.AccountNameE, 
				V15.LinkAccountID  AS ReportAccountID, 				
				V15.AccumulatedDebit, 
				V15.AccumulatedCredit,
				V16.Orders,
				V16.SenderReceiver,
				V16.Ana01ID,V16.Ana02ID,V16.Ana03ID,V16.Ana04ID,V16.Ana05ID,
				V16.Ana06ID,V16.Ana07ID,V16.Ana08ID,V16.Ana09ID,V16.Ana10ID,
				V16.AnaName01,V16.AnaName02,V16.AnaName03,V16.AnaName04,V16.AnaName05, 
				V16.AnaName06,V16.AnaName07,V16.AnaName08,V16.AnaName09,V16.AnaName10, 
				V16.VoucherID, V16.TableID, V16.Status, V16.RefNo01, V16.RefNo02,V16.SRDivisionName,V16.SRAddress,
				A05.AccountName as CorAccountName,
				A05.AccountNameE as CorAccountNameE,
				Isnull(V16.IsWithhodingTax, 0) as IsWithhodingTax'
				
SET @strSQL = @strSQL + ' FROM AV4315  AS V15'
SET @strSQL = @strSQL + ' LEFT JOIN AV4316  AS V16 ON V16.LinkAccountID = V15.LinkAccountID AND V15.DivisionID = V16.DivisionID
						  LEFT JOIN AT1202 A02 ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = V16.ObjectID
						  LEFT JOIN AT1005 A05 ON A05.DivisionID = V16.DivisionID AND V16.CorAccountID = A05.AccountID
WHERE  Isnull(V15.OpeningAmount, 0) <> 0 OR isnull(V15.ClosingAmount, 0)<>0 OR  isnull(V16.ConvertedAmount,0) <> 0'

--PRINT @strSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV7101' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV7101 --AP7101
	AS ' + @strSQL)
ELSE
	EXEC ('ALTER VIEW AV7101 --AP7101
	AS ' + @strSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
