IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7502_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7502_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by Nguyen Van Nhan.
----- Date 28/07/2003
---- In so quy theo Thang
---- Modified on 07/04/2021 by Huỳnh Thử : [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 24/05/2021 by Nhựt Trường: Bổ sung lấy dữ liệu BegOriginalAmount, BegConvertedAmount trường hợp view AV7511 không có dữ liệu.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- EXEC AP7502 'VG', '111101', 'VND', 9, 2014, 9, 2014, '',N'1=1'
CREATE PROCEDURE [dbo].[AP7502_TIENTIEN]
				@DivisionID AS nvarchar(50),
				@AccountID AS nvarchar(50),
				@CurrencyID AS nvarchar(50),
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS INT,
				@StrDivisionID AS NVARCHAR(4000) = '',
				@SqlFind AS NVARCHAR(500),
				@ReportDate AS DATETIME = NULL
AS
Declare @StartOriginalAmount AS decimal(28,8),
	@StartConvertedAmount AS decimal(28,8),
	@BegOriginalAmount AS decimal(28,8),
	@BegConvertedAmount AS decimal(28,8),
	@DetalOriginalAmount AS decimal(28,8),
	@DetalConvertedAmount AS decimal(28,8),
	@EndOrginalAmount AS decimal(28,8),
	@EndConvertedAmount AS decimal(28,8),
	@StartMonth AS int,
	@StartYear AS int,
	@sSQL AS nvarchar(4000),
	@sSQL1 AS nvarchar(4000),
	@BaseCurrencyID AS nvarchar(50),
	@SQlCalculator AS NVARCHAR(4000),
	@ReportDivisionID AS NVARCHAR(50)
--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_AP7502]') AND type in (N'U'))
DELETE  Temp_AP7502 
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_AP7502]') AND type in (N'U'))
CREATE table Temp_AP7502  (DivisionID NVARCHAR(50),StartOriginalAmount decimal(28,8),StartConvertedAmount decimal(28,8))
	
IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = CASE WHEN @DivisionID = '%' THEN ' LIKE ''' + 
	@DivisionID + '''' ELSE ' IN (''' + replace(@DivisionID, ',',''',''')+ ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WITH (NOLOCK) WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID
IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END

BEGIN
	SET @BaseCurrencyID = (Select top 1 BaseCurrencyID From AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @BaseCurrencyID =isnull( @BaseCurrencyID,'VND')

	----- Buoc 1, So du dau ky------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SET  	@StartMonth = (Select top 1 TranMonth From AT9999 WITH (NOLOCK) Where DivisionID =@DivisionID Order by (TranMonth+TranYear*100))
	SET  	@StartYear = (Select top 1 TranYear From AT9999 WITH (NOLOCK) Where DivisionID =@DivisionID Order by (TranMonth+TranYear*100))

	SET @SQlCalculator='SELECT DivisionID, SUM(CASE WHEN DebitAccountID = '''+@AccountID+''' then  OriginalAmount else - OriginalAmount End ) StartOriginalAmount,
				SUM(CASE WHEN   DebitAccountID ='''+@AccountID+'''  then ConvertedAmount else - ConvertedAmount End) StartConvertedAmount
		From	AT9000 WITH (NOLOCK) 
		Where 	TranMonth = '+str(@StartMonth)+' and
				TranYear = '+str(@StartYear)+' and
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) and
				( DebitAccountID = '''+@AccountID+''' Or CreditAccountID = '''+@AccountID+''' ) and
				CurrencyID like '''+@CurrencyID+''' and
				TransactionTypeID =''T00'' AND '+@SqlFind+'--- So du dau 
		Group by DivisionID'
			
	INSERT INTO Temp_AP7502 (DivisionID, StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
	--SELECT @StartOriginalAmount = ISNULL(StartOriginalAmount,0),
	--@StartConvertedAmount = StartConvertedAmount
	--FROM Temp_AP7502

	If @FromMonth+ @FromYear*100 = @StartMonth + @StartYear*100
		Begin
			SET @BegOriginalAmount = isnull(@StartOriginalAmount,0)
			SET @BegConvertedAmount = isnull(@StartConvertedAmount,0)

		End
	Else
		BEGIN
       --- Xac dinh so phat sinh truoc giai doan (FromMonth , FromYear)
	   SET @SQlCalculator=' Select DivisionID,Sum(CASE WHEN  TransactionTypeID IN (''T11'',''T16'') and CurrencyID ='''+@BaseCurrencyID+''' then  ConvertedAmount
								Else  OriginalAmount End ), 0  From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
													DebitAccountID ='''+@AccountID+''' and
													CurrencyID like '''+@CurrencyID+''' and
													TransactionTypeID <>''T00'' and
													TranMonth + TranYear*100< '+STR(@FromMonth+ @FromYear*100)+' AND '+@SqlFind+'
													Group by DivisionID'
	    PRINT @SQlCalculator
		INSERT INTO Temp_AP7502 (DivisionID,StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
		SET @SQlCalculator = 'Select DivisionID, - Sum(CASE WHEN  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN ='''+@BaseCurrencyID+''' then  ConvertedAmount
													Else  OriginalAmount End  ), 0  From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
													CreditAccountID ='''+@AccountID+''' and
													TransactionTypeID <>''T00'' and
													(CASE WHEN TransactionTypeID IN (''T11'',''T16'') then CurrencyIDCN Else CurrencyID End) like '''+@CurrencyID+''' and													
													TranMonth + TranYear*100< '+STR(@FromMonth+ @FromYear*100)+' AND '+@SqlFind+'
													
													Group by DivisionID'

		PRINT @SQlCalculator											
		INSERT INTO Temp_AP7502 (DivisionID,StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)

			
		SET @SQlCalculator='Select DivisionID, 0,Sum(ConvertedAmount)  
								From AT9000 WITH (NOLOCK) Where DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
													DebitAccountID ='''+@AccountID+''' and
													CurrencyID like '''+@CurrencyID+''' and
													TransactionTypeID <>''T00'' and
													TranMonth + TranYear*100< '+STR(@FromMonth+ @FromYear*100)+' AND '+@SqlFind+'
													Group by DivisionID'		
		PRINT @SQlCalculator											
		INSERT INTO Temp_AP7502 (DivisionID,StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)			
						
		SET @SQlCalculator = 'Select DivisionID, 0,- Sum(ConvertedAmount)  
										From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
														CreditAccountID ='''+@AccountID+''' and
														TransactionTypeID <>''T00'' and
														(CASE WHEN TransactionTypeID IN (''T11'',''T16'') then CurrencyIDCN Else CurrencyID End)  like '''+@CurrencyID+''' and
														TranMonth + TranYear*100< '+STR(@FromMonth+ @FromYear*100)+' AND '+@SqlFind+'
														Group by DivisionID'
		INSERT INTO dbo.Temp_AP7502 (DivisionID,StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
		PRINT @SQlCalculator
				

		End


	----- Buoc 2,  Xac dinh so phat sinh ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		SET @sSQL='
		SELECT 	(CASE WHEN DebitAccountID = '''+@AccountID+''' then 0  else 1 end) AS TransactionTypeID, 
				TransactionID,BatchID, VoucherID,		
				TranMonth, TranYear, AT9000.DivisionID,
				VoucherNo,
				AT9000.ObjectID,
				--AT1202.ObjectName,	
				(CASE WHEN   AT1202.IsUpdateName =1 then   AT9000.VATObjectName 
				Else AT1202.ObjectName  End) AS ObjectName, BankName,
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, 
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
				A11.AnaName AS Ana01Name,A12.AnaName AS Ana02Name,A13.AnaName AS Ana03Name,A14.AnaName AS Ana04Name,A15.AnaName AS Ana05Name,
				A16.AnaName AS Ana06Name,A17.AnaName AS Ana07Name,A18.AnaName AS Ana08Name,A19.AnaName AS Ana09Name,A10.AnaName AS Ana10Name, 
				--isnull(VoucherDate, ''12/31/1753'') VoucherDate
				VoucherDate		,	VoucherTypeID,
				(CASE WHEN DebitAccountID = '''+@AccountID+''' then VoucherNo else '''' end) AS DebitVoucherNo,
				(CASE WHEN CreditAccountID = '''+@AccountID+''' then VoucherNo else '''' end) AS CreditVoucherNo,
				Serial, InvoiceNo, 
				--isnull(InvoiceDate, ''12/31/1753'') InvoiceDate
				InvoiceDate	,
				DebitAccountID, CreditAccountID,
				(CASE WHEN TransactionTypeID IN (''T11'',''T16'') and CreditAccountID ='''+@AccountID+'''  then CurrencyIDCN Else AT9000.CurrencyID End) AS CurrencyID, 
				(CASE WHEN TransactionTypeID IN (''T11'',''T16'')  and CreditAccountID ='''+@AccountID+''' and CurrencyIDCN ='''+@BaseCurrencyID+'''  then  1 Else 
				CASE WHEN TransactionTypeID IN (''T11'',''T16'')  and DebitAccountID ='''+@AccountID+''' and AT9000.CurrencyID ='''+@BaseCurrencyID+'''  then 1  else ExchangeRate End End)   ExchangeRate,
				'''+@AccountID+''' AS AccountID,
				(CASE WHEN DebitAccountID = '''+@AccountID+''' then CreditAccountID else DebitAccountID End) AS RelationAccountID,

				( CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID NOT IN (''T11'',''T16'')  then OriginalAmount
				Else  CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and AT9000.CurrencyID='''+@BaseCurrencyID+''' then ConvertedAmount
				Else  CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and AT9000.CurrencyID<>'''+@BaseCurrencyID+'''  then OriginalAmount
					Else	0	End		End		End)  AS DebitOriginalAmount,
				( CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID NOT IN (''T11'',''T16'')  then OriginalAmount
				Else  CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN ='''+@BaseCurrencyID+''' then ConvertedAmount
				Else  CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN <>'''+@BaseCurrencyID+'''  then OriginalAmount
					Else	0	End		End		End)  AS CreditOriginalAmount,
				(CASE WHEN DebitAccountID = '''+@AccountID+''' then ConvertedAmount else 0 End) AS DebitConvertedAmount,
				(CASE WHEN CreditAccountID = '''+@AccountID+''' then ConvertedAmount else 0 End) AS CreditConvertedAmount,			
				VDescription, BDescription, TDescription,
				(SELECT SUM(StartOriginalAmount)  FROM Temp_AP7502 WHERE Temp_AP7502.DivisionID = AT9000.DivisionID)  AS BegOriginalAmount,
				(SELECT SUM(StartConvertedAmount)  FROM Temp_AP7502 WHERE Temp_AP7502.DivisionID = AT9000.DivisionID ) AS BegConvertedAmount,
				SenderReceiver,		AT9000.CreateDate,		Orders,
				AT9000.RefNo01, AT9000.RefNo02,
				(CASE WHEN TransactionTypeID in (''T03'',''T04'') then AT9000.CreateUserID else AT9000.EmployeeID end) as EmployeeID,
				(CASE WHEN TransactionTypeID in (''T03'',''T04'') then AT1405.UserName else AT1103.FullName end) as EmployeeName,
				AT9000.Parameter01,AT9000.Parameter02,AT9000.Parameter03,AT9000.Parameter04,AT9000.Parameter05,AT9000.Parameter06,
				AT9000.Parameter07,AT9000.Parameter08,AT9000.Parameter09,AT9000.Parameter10,ISNULL(AT9000.IsWithhodingTax,0) IsWithhodingTax,
				AT9000.CreateUserID, AT1405.UserName
	'
	SET @sSQL1 = '
		From AT9000 WITH (NOLOCK)
		LEFT JOIN AT1011 A11 WITH (NOLOCK) on A11.AnaID = AT9000.Ana01ID AND A11.DivisionID=AT9000.DivisionID AND A11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A12 WITH (NOLOCK) on A12.AnaID = AT9000.Ana01ID AND A12.DivisionID=AT9000.DivisionID AND A12.AnaTypeID = ''A02''
		LEFT JOIN AT1011 A13 WITH (NOLOCK) on A13.AnaID = AT9000.Ana01ID AND A13.DivisionID=AT9000.DivisionID AND A13.AnaTypeID = ''A03''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) on A14.AnaID = AT9000.Ana01ID AND A14.DivisionID=AT9000.DivisionID AND A14.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A15 WITH (NOLOCK) on A15.AnaID = AT9000.Ana01ID AND A15.DivisionID=AT9000.DivisionID AND A15.AnaTypeID = ''A05''
		LEFT JOIN AT1011 A16 WITH (NOLOCK) on A16.AnaID = AT9000.Ana01ID AND A16.DivisionID=AT9000.DivisionID AND A16.AnaTypeID = ''A06''
		LEFT JOIN AT1011 A17 WITH (NOLOCK) on A17.AnaID = AT9000.Ana01ID AND A17.DivisionID=AT9000.DivisionID AND A17.AnaTypeID = ''A07''
		LEFT JOIN AT1011 A18 WITH (NOLOCK) on A18.AnaID = AT9000.Ana01ID AND A18.DivisionID=AT9000.DivisionID AND A18.AnaTypeID = ''A08'' 
		LEFT JOIN AT1011 A19 WITH (NOLOCK) on A19.AnaID = AT9000.Ana01ID AND A19.DivisionID=AT9000.DivisionID AND A19.AnaTypeID = ''A09''
		LEFT JOIN AT1011 A10 WITH (NOLOCK) on A10.AnaID = AT9000.Ana01ID AND A10.DivisionID=AT9000.DivisionID AND A10.AnaTypeID = ''A10'' 
		Left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID =  AT9000.ObjectID
		Left join AT1103 on AT1103.EmployeeID = AT9000.EmployeeID and AT1103.DivisionID =  AT9000.DivisionID
		Left join AT1405 on AT1405.UserID = AT9000.CreateUserID and AT1405.DivisionID =  AT9000.DivisionID
		Where  
			--- TransactionTypeID in (''T01'', ''T02'' , ''T09'', ''T11'', ''T21'', ''T22'' ) and
			TransactionTypeID <> ''T00'' and 
			AT9000.DivisionID '+ @StrDivisionID_New +' and
			(TranMonth + TranYear*100 Between ('+str(@FromMonth)+' + '+str(@FromYear)+'*100) and ('+str(@ToMonth)+' + '+str(@ToYear)+'*100)) and 
			(DebitAccountID = '''+@AccountID+''' or CreditAccountID ='''+@AccountID+''') and
			(CASE WHEN TransactionTypeID IN (''T11'',''T16'') and CreditAccountID ='''+@AccountID+''' then CurrencyIDCN else AT9000.CurrencyID End) like ''' + @CurrencyID+''' ' 


	---Print @sSQL
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'AV7511')
		DROP VIEW AV7511
		 Exec ('  Create View AV7511 ---tao boi AP7502
		 AS ' + @sSQL + @sSQL1)

	If Exists (Select TOP 1 1 From AV7511)
		SET @sSQL ='SELECT * FROM AV7511 '
	Else
		SET @sSQL ='SELECT 	
					AT9000.DivisionID,
					NULL AS TransactionTypeID, 
					'''' AS TransactionID,
					'''' AS BatchID, 
					'''' AS VoucherID,		
					null AS TranMonth, 
					null AS TranYear, 
					'''' AS VoucherNo,
					'''' AS ObjectID,
					'''' AS ObjectName,
					'''' AS BankName,
					'''' AS Ana01ID, 
					'''' AS Ana02ID, 
					'''' AS Ana03ID, 
					'''' AS Ana04ID,
					'''' AS Ana05ID,
					'''' AS Ana06ID, 
					'''' AS Ana07ID, 
					'''' AS Ana08ID, 
					'''' AS Ana09ID,
					'''' AS Ana10ID,
					Null as Ana01Name,
					Null as Ana02Name,
					Null as Ana03Name,
					Null as Ana04Name,
					Null as Ana05Name,
					Null as Ana06Name,
					Null as Ana07Name,
					Null as Ana08Name,
					Null as Ana09Name,
					Null as Ana10Name,
					null AS VoucherDate,	
					'''' AS VoucherTypeID,
					''''  AS DebitVoucherNo,
					'''' as	CreditVoucherNo,
					'''' AS Serial, 
					'''' AS InvoiceNo, 
					null AS InvoiceDate,
					'''' AS DebitAccountID, 
					'''' AS CreditAccountID,
					'''+@CurrencyID+''' AS CurrencyID, 
					null AS ExchangeRate,
					'''+@AccountID+''' AS AccountID,
					'''' as	 RelationAccountID,
					0  AS DebitOriginalAmount,
					0 AS  CreditOriginalAmount,
					0 AS DebitConvertedAmount,
					0 AS CreditConvertedAmount,			
					'''' AS VDescription, 
					'''' AS BDescription, 
					'''' AS TDescription,
				(SELECT SUM(StartOriginalAmount)  FROM Temp_AP7502 WHERE Temp_AP7502.DivisionID = AT9000.DivisionID)  AS BegOriginalAmount,
				(SELECT SUM(StartConvertedAmount)  FROM Temp_AP7502 WHERE Temp_AP7502.DivisionID = AT9000.DivisionID) AS BegConvertedAmount,
					'''' AS SenderReceiver,
					null AS CreateDate,
					0 AS Orders,
					'''' as RefNo01, '''' as RefNo02, '''' as EmployeeID, '''' as EmployeeName,
					Null as Parameter01, Null as Parameter02, Null as Parameter03, Null as Parameter04, Null as Parameter05,
					Null as Parameter06, Null as Parameter07, Null as Parameter08, Null as Parameter09, Null as Parameter10,0 IsWithhodingTax,
					'''' as CreateUserID,'''' as UserName
				From AT9000 WITH (NOLOCK)
				Where AT9000.DivisionID '+ @StrDivisionID_New +'
	 ' 


	--Print @sSQL
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'AV7513')
		DROP VIEW AV7513
	Exec ('  CREATE VIEW AV7513  ---tao boi AP7502
		as ' + @sSQL)

	SET @sSQL =' 
	SELECT TransactionTypeID, BatchID, VoucherID, AV7513.TranMonth, AV7513.TranYear, 
			AV7513.DivisionID, VoucherNo, ObjectID, ObjectName, BankName,
			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
			Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
			Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, 
			Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name, 
			--isnull(VoucherDate, ''12/31/1753'') VoucherDate
			VoucherDate
			, VoucherTypeID, DebitVoucherNo, CreditVoucherNo, Serial, InvoiceNo, 
			--isnull(InvoiceDate, ''12/31/1753'') InvoiceDate
			InvoiceDate
			, DebitAccountID, CreditAccountID, AV7513.CurrencyID, AV7513.ExchangeRate, 
			AV7513.AccountID, A.AccountName,
			RelationAccountID, AT1005.AccountName AS RelationAccountName,
			VDescription, BDescription, TDescription, 
			BegOriginalAmount, BegConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) As BegConvertedAmount,
			SUM(DebitOriginalAmount) AS DebitOriginalAmount ,
			SUM(CreditOriginalAmount) AS CreditOriginalAmount,
			SUM(DebitConvertedAmount) * ISNULL(AT1012.ExchangeRate, 1) AS DebitConvertedAmount,
			SUM(CreditConvertedAmount) * ISNULL(AT1012.ExchangeRate, 1) AS CreditConvertedAmount,
			SenderReceiver, AV7513.CreateDate, 
			Orders, RefNo01, RefNo02, 
			EmployeeID, EmployeeName,
			Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, 
			Parameter06, Parameter07, Parameter08, Parameter09, Parameter10,IsWithhodingTax,
			AV7513.CreateUserID,AV7513.UserName

	FROM		AV7513
	LEFT JOIN	AT1005 WITH (NOLOCK) ON AT1005.DivisionID = AV7513.DivisionID AND AT1005.AccountID = AV7513.RelationAccountID
	LEFT JOIN	AT1005 A WITH (NOLOCK) ON A.DivisionID = AV7513.DivisionID AND A.AccountID = AV7513.AccountID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7513.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
	GROUP BY	TransactionTypeID, BatchID, VoucherID, AV7513.TranMonth, AV7513.TranYear, 
				AV7513.DivisionID, VoucherNo, ObjectID, ObjectName, BankName,
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
				Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, 
				Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name,
				VoucherDate, VoucherTypeID, DebitVoucherNo, CreditVoucherNo, Serial, InvoiceNo, 
				InvoiceDate, DebitAccountID, CreditAccountID, AV7513.CurrencyID, AV7513.ExchangeRate, 
				AV7513.AccountID, A.AccountName, RelationAccountID, AT1005.AccountName, 
				VDescription, BDescription, TDescription, 
				BegOriginalAmount, BegConvertedAmount,SenderReceiver , AV7513.CreateDate,
				Orders, RefNo01, RefNo02, 
				EmployeeID, EmployeeName,Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, 
				Parameter06, Parameter07, Parameter08, Parameter09, Parameter10,IsWithhodingTax,AV7513.CreateUserID,AV7513.UserName,
				AT1012.ExchangeRate
				'


	IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'AV7501')
		DROP VIEW AV7501
	  EXEC ('  CREATE VIEW AV7501

	  ---tao boi AP7502
		 AS ' + @sSQL )

		 PRINT @sSQL
END
DELETE FROM	A00007 WHERE SPID = @@SPID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
