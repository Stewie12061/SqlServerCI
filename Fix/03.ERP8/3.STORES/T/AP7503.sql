IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- So quy theo ngay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/07/2003 by Nguyen Van Nhan
---- 
---- Edit by B.Anh, date 15/12/2009	Bo sung MPT 4,5
---- Edit by B.Anh, date 24/05/2010	Them in tat ca loai tien
---- Modified on 13/12/2011 by Le Thi Thu Hien : Chinh sua Ngay
---- Modified on 11/01/2012 by Le Thi Thu Hien : Sua dieu kien loc theo ngay
---- Modified on 31/01/2012 by Le Thi Thu Hien : Bo sung tieu chi o nhung but toan doi tien va chuyen khoan ngan hang
---- Edited by Bao Anh, Date: 05/08/2012	Lay them truong EmployeeID, EmployeeName
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified by on 24/09/2014 by Trần Quốc Tuấn : Bổ sung điều kiện lọc
---- Modified on 10/09/2015 by Tiểu Mai: Bổ sung tên 10 MPT, 10 tham số
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 07/04/2021 by Huỳnh Thử : Tách Store [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

--exec AP7503 'VG','11103','VND','2014-09-24 00:00:00','2014-09-24 00:00:00','',N'  (ISNULL(Ana01ID, '''') LIKE N''%1%'')'

CREATE PROCEDURE [dbo].[AP7503]
				@DivisionID AS nvarchar(50),
				@AccountID AS nvarchar(50),
				@CurrencyID AS nvarchar(50),
				@FromDate AS datetime,
				@ToDate AS DATETIME,
				@StrDivisionID AS NVARCHAR(4000) = '',
				@SqlFind AS NVARCHAR(MAX),
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
		@CustomerName INT
--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
DECLARE @Temp table (StartOriginalAmount decimal(28,8),StartConvertedAmount decimal(28,8))

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = CASE WHEN @DivisionID = '%' THEN ' LIKE ''' + 
	@DivisionID + '''' ELSE ' IN (''' + replace(@DivisionID, ',',''',''')+ ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')


SET @CustomerName=(SELECT CustomerName FROM CustomerIndex)
IF (@CustomerName = 13) -- Tiên Tiến
BEGIN
    EXEC dbo.AP7503_TIENTIEN @DivisionID = @DivisionID,                 -- nvarchar(50)
                    @AccountID = @AccountID,                  -- nvarchar(50)
                    @CurrencyID = @CurrencyID,                 -- nvarchar(50)
                    @FromDate = @FromDate, -- datetime
                    @ToDate = @ToDate,   -- datetime
                    @StrDivisionID = @StrDivisionID,              -- nvarchar(4000)
                    @SqlFind = @SqlFind ,                    -- nvarchar(max)
                    @ReportDate = @ReportDate                     -- nvarchar(max)
    
END
ELSE
	BEGIN
	---------------------<<<<<<<<<< Chuỗi DivisionID

	Set @BaseCurrencyID = (Select top 1 BaseCurrencyID From AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	Set @BaseCurrencyID =isnull( @BaseCurrencyID,'VND')

	----- Buoc 1, So du dau ky------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Set  	@StartMonth = (Select top 1 TranMonth From AT9999 WITH (NOLOCK) Where DivisionID =@DivisionID Order by (TranMOnth+TranYear*100))
	Set  	@StartYear = (Select top 1 TranYear From AT9999 WITH (NOLOCK) Where DivisionID =@DivisionID Order by (TranMOnth+TranYear*100))
	------ So du ban dau
	SET @SQlCalculator='SELECT SUM(CASE WHEN DebitAccountID = '''+@AccountID+''' then  OriginalAmount else - OriginalAmount End ) StartOriginalAmount,
			SUM(CASE WHEN   DebitAccountID ='''+@AccountID+'''  then ConvertedAmount else - ConvertedAmount End) StartConvertedAmount
			From	AT9000  WITH (NOLOCK)
			Where 	TranMonth = '+str(@StartMonth)+' and
			TranYear = '+str(@StartYear)+' and
			DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) and
			( DebitAccountID = '''+@AccountID+''' Or CreditAccountID = '''+@AccountID+''' ) and
			CurrencyID like '''+@CurrencyID+''' and
			TransactionTypeID =''T00'' AND '+@SqlFind+'--- So du dau '
			
		INSERT INTO @Temp (StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
		SELECT @StartOriginalAmount = ISNULL(StartOriginalAmount,0),
		@StartConvertedAmount = StartConvertedAmount
		FROM @Temp

	--- Xac dinh so phat sinh truoc giai doan (FromDate )
		SET @SQlCalculator='SELECT (ISNULL(isnull((Select Sum(CASE WHEN  TransactionTypeID IN (''T11'',''T16'') and CurrencyID ='''+@BaseCurrencyID+''' then  ConvertedAmount
								Else  OriginalAmount End )  From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
													DebitAccountID ='''+@AccountID+''' and
													CurrencyID like '''+@CurrencyID+''' and
													TransactionTypeID <>''T00'' and
													CONVERT(DATETIME,CONVERT(VARCHAR(20),VoucherDate,101), 101) < CONVERT(VARCHAR(20),'''+LTRIM(@FromDate)+''' ,101)
													AND '+@SqlFind+' ),0)
							- isnull((Select Sum(CASE WHEN  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN ='''+@BaseCurrencyID+''' then  ConvertedAmount
								Else  OriginalAmount End  )  From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
														CreditAccountID ='''+@AccountID+''' and
														TransactionTypeID <>''T00'' and
														(CASE WHEN TransactionTypeID IN (''T11'',''T16'') then CurrencyIDCN Else CurrencyID End) like '''+@CurrencyID+''' and													
														CONVERT(DATETIME,CONVERT(VARCHAR(20),VoucherDate,101), 101) < CONVERT(VARCHAR(20),'''+ LTRIM(@FromDate)+''',101) AND '+@SqlFind+' ),0),0)),0'
			--PRINT @SQlCalculator											
			INSERT INTO @Temp (StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
			SELECT @DetalOriginalAmount = ISNULL(StartOriginalAmount,0)
			FROM @Temp	

			SET @SQlCalculator='SELECT (ISNULL(isnull((Select Sum(ConvertedAmount)  From AT9000 WITH (NOLOCK) Where DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
													DebitAccountID ='''+@AccountID+''' and
													CurrencyID like '''+@CurrencyID+''' and
													TransactionTypeID <>''T00'' and
													CONVERT(DATETIME,CONVERT(VARCHAR(20),VoucherDate,101), 101) < CONVERT(VARCHAR(20),'''+ LTRIM(@FromDate)+''',101)
													AND '+@SqlFind+'),0)					
							- isnull((Select Sum(ConvertedAmount)  From AT9000 WITH (NOLOCK) Where 	DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID) and
														CreditAccountID ='''+@AccountID+''' and
														TransactionTypeID <>''T00'' and
														(CASE WHEN TransactionTypeID IN (''T11'',''T16'') then CurrencyIDCN Else CurrencyID End)  like '''+@CurrencyID+''' and
														CONVERT(DATETIME,CONVERT(VARCHAR(20),VoucherDate,101), 101) < CONVERT(VARCHAR(20), '''+ LTRIM(@FromDate)+''',101) 
														AND '+@SqlFind+'),0),0)),0'
			INSERT INTO @Temp (StartOriginalAmount, StartConvertedAmount) EXEC(@SQlCalculator)
			SELECT @DetalConvertedAmount = ISNULL(StartOriginalAmount,0)
			FROM @Temp
			Set @BegOriginalAmount = isnull(@StartOriginalAmount,0) + isnull(@DetalOriginalAmount,0)
			Set @BegConvertedAmount = isnull(@StartConvertedAmount,0) + Isnull(@DetalConvertedAmount,0)		
	---print 'BegOriAmt ' + str(@BegOriginalAmount) + '	BegConvAmt ' + str(@BegConvertedAmount)

	----- Buoc 2,  Xac dinh so phat sinh ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Set @sSQL='
		SELECT 	(CASE WHEN DebitAccountID = '''+@AccountID+''' then 0  else 1 end) AS TransactionTypeID, TransactionID, BatchID, VoucherID,		
			TranMonth, TranYear, AT9000.DivisionID,
			--isnull(VoucherDate, ''12/31/1753'') VoucherDate
			VoucherDate
			,	VoucherTypeID,
			VoucherNo,
			AT9000.ObjectID,

			--AT1202.ObjectName,
			(CASE WHEN   AT1202.IsUpdateName =1 then   AT9000.VATObjectName 
				Else AT1202.ObjectName  End) AS ObjectName,
			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
			Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
			A11.AnaName AS Ana01Name,A12.AnaName AS Ana02Name,A13.AnaName AS Ana03Name,A14.AnaName AS Ana04Name,A15.AnaName AS Ana05Name,
			A16.AnaName AS Ana06Name,A17.AnaName AS Ana07Name,A18.AnaName AS Ana08Name,A19.AnaName AS Ana09Name,A10.AnaName AS Ana10Name, 
				--isnull(VoucherDate, ''12/31/1753'') VoucherDate
			(CASE WHEN DebitAccountID = '''+@AccountID+''' then VoucherNo else '''' end) AS DebitVoucherNo,
			(CASE WHEN CreditAccountID = '''+@AccountID+''' then VoucherNo else '''' end) AS CreditVoucherNo,
			Serial, InvoiceNo, 
			--isnull(InvoiceDate, ''12/31/1753'') InvoiceDate
			InvoiceDate
			,
			DebitAccountID, CreditAccountID,
			(CASE WHEN TransactionTypeID IN (''T11'',''T16'') and CreditAccountID ='''+@AccountID+'''  then CurrencyIDCN Else AT9000.CurrencyID End) AS CurrencyID, 
			(CASE WHEN TransactionTypeID IN (''T11'',''T16'')  and CreditAccountID ='''+@AccountID+''' and CurrencyIDCN ='''+@BaseCurrencyID+'''  then  1 Else 
				CASE WHEN TransactionTypeID IN (''T11'',''T16'')  and DebitAccountID ='''+@AccountID+''' and AT9000.CurrencyID ='''+@BaseCurrencyID+'''  then 1  else ExchangeRate End End)   ExchangeRate,
			'''+@AccountID+''' AS AccountID,
			( CASE WHEN DebitAccountID = '''+@AccountID+''' then CreditAccountID else DebitAccountID End) AS RelationAccountID,		
			( CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID NOT IN (''T11'',''T16'')  then OriginalAmount
			 Else  CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and AT9000.CurrencyID='''+@BaseCurrencyID+''' then ConvertedAmount
				Else  CASE WHEN DebitAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and AT9000.CurrencyID<>'''+@BaseCurrencyID+'''  then OriginalAmount
					Else
						0
					End
				End
			End)  AS DebitOriginalAmount,

			( CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID NOT IN (''T11'',''T16'')  then OriginalAmount
			 Else  CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN='''+@BaseCurrencyID+''' then ConvertedAmount
				Else  CASE WHEN CreditAccountID = '''+@AccountID+'''  and  TransactionTypeID IN (''T11'',''T16'') and CurrencyIDCN<>'''+@BaseCurrencyID+'''  then OriginalAmount
					Else
						0
					End
				End
			End)  AS CreditOriginalAmount,


			(CASE WHEN DebitAccountID = '''+@AccountID+''' then ConvertedAmount else 0 End) AS DebitConvertedAmount,
			(CASE WHEN CreditAccountID = '''+@AccountID+''' then ConvertedAmount else 0 End) AS CreditConvertedAmount,			
			VDescription, BDescription, TDescription,
			'+str(isnull(@BegOriginalAmount,0),28,4)+' AS BegOriginalAmount,
			'+str(isnull(@BegConvertedAmount,0),28,4)+' AS BegConvertedAmount,
			SenderReceiver	,
			AT9000.CreateDate,
			AT9000.Orders,
			(case when TransactionTypeID in (''T03'',''T04'') then AT9000.CreateUserID else AT9000.EmployeeID end) as EmployeeID,
			(case when TransactionTypeID in (''T03'',''T04'') then AT1405.UserName else AT1103.FullName end) as EmployeeName,
			AT9000.Parameter01,AT9000.Parameter02,AT9000.Parameter03,AT9000.Parameter04,AT9000.Parameter05,AT9000.Parameter06,
			AT9000.Parameter07,AT9000.Parameter08,AT9000.Parameter09,AT9000.Parameter10,AT9000.CreateUserID, AT1405.UserName
	'
	SET @sSQL1 = '
	FROM		AT9000  WITH (NOLOCK)
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
		LEFT JOIN	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID =  AT9000.ObjectID
		Left join 	AT1103 WITH (NOLOCK) on AT1103.EmployeeID = AT9000.EmployeeID and AT1103.DivisionID =  AT9000.DivisionID
		Left join 	AT1405 WITH (NOLOCK) on AT1405.UserID = AT9000.CreateUserID and AT1405.DivisionID =  AT9000.DivisionID
	WHERE ---TransactionTypeID in (''T01'', ''T02'', ''T09'', ''T11'' , ''T21'', ''T22'' ) and
				TransactionTypeID <> ''T00'' and 
				AT9000.DivisionID '+ @StrDivisionID_New +' AND
				(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) BETWEEN ''' + Convert(varchar(10),@FromDate,101) + ''' AND ''' + convert(varchar(10), @ToDate ,101) + ''' ) AND
				(DebitAccountID = '''+@AccountID+''' or CreditAccountID ='''+@AccountID+''') and
				(CASE WHEN TransactionTypeID =''T11'' and CreditAccountID ='''+@AccountID+''' then CurrencyIDCN else AT9000.CurrencyID End) like ''' + @CurrencyID+''' ' 


	--PRINT @sSQL
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'AV7511')
		DROP VIEW AV7511
	Exec ('  Create View AV7511

	  ---tao boi AP7503
	 AS ' + @sSQL + @sSQL1)

	if Exists (Select TOP 1 1 From AV7511)
		Set @sSQL ='SELECT * FROM AV7511 '
	Else
		Set @sSQL ='
		SELECT 	null AS TransactionTypeID, 
				'''' AS TransactionID,
				'''' AS BatchID, 
				'''' AS VoucherID,		
				null AS TranMonth, 
				null AS TranYear, 
				'''+@DivisionID+''' AS DivisionID,
				'''' AS VoucherNo,
				'''' AS ObjectID,
				'''' AS ObjectName,
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
				'+str(isnull(@BegOriginalAmount,0),28,4)+' AS BegOriginalAmount,
				'+str(isnull(@BegConvertedAmount,0),28,4)+' AS BegConvertedAmount,
				'''' AS SenderReceiver,
				null AS CreateDate,
				0 AS Orders,
				'''' as EmployeeID, '''' as EmployeeName,
				Null as Parameter01, Null as Parameter02, Null as Parameter03, Null as Parameter04, Null as Parameter05,
				Null as Parameter06, Null as Parameter07, Null as Parameter08, Null as Parameter09, Null as Parameter10,
				'''' as CreateUserID,'''' as UserName
	' 

	--Print @sSQL
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'AV7513')
		DROP VIEW AV7513
	Exec ('  Create View AV7513  ---tao boi AP7503
		as ' + @sSQL)


	Set @sSQL =' Select TransactionTypeID, BatchID, VoucherID, TranMonth, TranYear, 
			AV7513.DivisionID, VoucherNo, ObjectID, ObjectName, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
			Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
			Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, 
			Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name, 
			--isnull(VoucherDate, ''12/31/1753'') VoucherDate
			VoucherDate
			, VoucherTypeID, DebitVoucherNo, CreditVoucherNo, Serial, InvoiceNo, 
			--isnull(InvoiceDate, ''12/31/1753'') InvoiceDate
			InvoiceDate
			, DebitAccountID, CreditAccountID, CurrencyID, ExchangeRate, 
			AccountID, RelationAccountID, VDescription, BDescription, TDescription, 
			BegOriginalAmount, BegConvertedAmount,
			sum(DebitOriginalAmount) AS DebitOriginalAmount ,
			sum(CreditOriginalAmount) AS CreditOriginalAmount,
			sum(DebitConvertedAmount) AS DebitConvertedAmount,
			sum(CreditConvertedAmount) AS CreditConvertedAmount,
			SenderReceiver, CreateDate, Orders, EmployeeID, EmployeeName,
			Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, 
			Parameter06, Parameter07, Parameter08, Parameter09, Parameter10,
			AV7513.CreateUserID, AV7513.UserName
		From AV7513
		Group by   TransactionTypeID, BatchID, VoucherID, TranMonth, TranYear, 
				AV7513.DivisionID, VoucherNo, ObjectID, ObjectName, Ana01ID, Ana02ID, Ana03ID,  Ana04ID, Ana05ID,
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
				Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, 
				Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name, 
				VoucherDate, VoucherTypeID, DebitVoucherNo, CreditVoucherNo, Serial, InvoiceNo, 
				InvoiceDate, DebitAccountID, CreditAccountID, CurrencyID, ExchangeRate, 
				AccountID, RelationAccountID, VDescription, BDescription, TDescription, 
				BegOriginalAmount, BegConvertedAmount,SenderReceiver , CreateDate ,Orders, EmployeeID, EmployeeName,
				Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, 
				Parameter06, Parameter07, Parameter08, Parameter09, Parameter10,AV7513.CreateUserID, AV7513.UserName'

	--PRINT @sSQL
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'AV7501')
		DROP VIEW AV7501
	  Exec ('  Create View AV7501  ---tao boi AP7503
		 AS ' + @sSQL)


END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
