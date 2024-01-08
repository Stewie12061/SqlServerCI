IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7516_TIENTIEN]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7516_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In so ngan hang, tu ngay --- den ngay ----- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 12/12/2007 by Nguyen Van Nhan
---- 
---- Last Edit Thuy Tuyen, 18/03/2008/  lay so du dau ky theo BankAccountID
---- Edit by Nguyen Quoc Huy, Date 25/09/2008
---- Edit Thuy Tuyen , date 19/01/2009 
---- Modified on 13/01/2012 by Le Thi Thu Hien : Sua dieu kien theo ngay
--------Edit by Thien Huynh, Date 14/03/2012
---- Modified on 24/05/2013 by Lê Thị Thu Hiền : Bổ sung 10 khoản mục Ana
---- Modified on 26/06/2013 by Lê Thị Thu Hiền : Không select dữ liệu từ View AV1111 ( Cải tiến tốc độ)
-- <Example>
---- EXEC AP7516 'MK', 'ASFJKK', '1311', 'VND', '2011-09-08', '2013-09-20','',''
---- Modified on 30/09/2013 by Khánh Vân: Cải thiện tốc độ
---- Modified on 03/10/2014 by Quốc Tuấn : bo sung điều kiện where
---- Modified on 08/10/2015 by Tieu Mai: Sửa tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Bảo Anh on 06/08/2018: Sửa lỗi sổ tiền gửi ngân hàng lên cả các bút toán CLTG
---- Modified by Kim Thư on 07/03/2019: Thêm cột BankAccountNo vào #AV7516 và lấy lên kết quả báo cáo
---- Modified by Kim Thư on 27/05/2019: Thêm cột tỷ giá (loại trừ seabornes 109)
---- Modified by Kim Thư on 5/06/2019: gán mặc định cho BasecurrencyID là VND
---- Modified by Kim Thư on 8/7/2019: Sửa lỗi ambigous ObjectID
---- Modified by Hoài PHong on 02/12/2020:Bổ  sung thêm where DivisionID cho báo cáo
---- Modified on 07/04/2021 by Huỳnh Thử : [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 10/05/2021 by Huỳnh Thử : [TienTien] -- Print 1 DivisionID bỏ union all @@@
---- Modified on 31/05/2021 by Nhựt Trường: Bổ sung thêm điều kiện theo DivisionID khi Join bảng AT1016.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP7516_TIENTIEN]  	
					@DivisionID AS nvarchar(50),
					@BankID AS nvarchar(50),
					@AccountID AS nvarchar(50),			
					@CurrencyID AS nvarchar(50),
					@FromDate AS datetime,
					@ToDate AS datetime,
					@Orderby as nvarchar(1000),
					@SqlWhere AS NVARCHAR(MAX),
					@StrDivisionID AS NVARCHAR(4000) = '',
					@ReportDate AS DATETIME = NULL
				
AS
Declare @sSQLSelect AS nvarchar(4000),
		@sSQLFrom AS nvarchar(4000),
		@sSQLUnion AS nvarchar(4000),
		@sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@sSQL3_01 AS nvarchar(MAX),
		@sSQL4 AS nvarchar(MAX),
		@sSQL5 AS nvarchar(MAX),
		@sWHERE1 AS NVARCHAR(MAX),
		@sWHERE2 AS NVARCHAR(MAX),
		@CustomerName INT,
		@ReportDivisionID AS NVARCHAR(50)

SET @sWHERE1 = ''
SET @sWHERE2 = ''

		--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)

SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

	IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END
		
			
SET @CustomerName=(SELECT CustomerName FROM CustomerIndex)

	IF @CurrencyID <> '' AND @CurrencyID <> '%'
	BEGIN
		SET @sWHERE1 = @sWHERE1 + ' 
			AND		CASE WHEN TransactionTypeID=''T16'' then CurrencyIDCN else AT9000.CurrencyID END = '''+@CurrencyID+''' '	
		SET @sWHERE2 = @sWHERE2 + ' 
			AND		AT1016.CurrencyID = '''+@CurrencyID+''' '
	END

	IF @AccountID <> '' AND @AccountID <> '%'
	BEGIN
		SET @sWHERE1 = @sWHERE1 + ' 
			AND	AT9000.CreditAccountID = '''+@AccountID+''' '
		SET @sWHERE2 = @sWHERE2 + '
			AND AT9000.DebitAccountID = '''+@AccountID+''' '
	END
	--ELSE
	--BEGIN
	--	SET @sWHERE1 = @sWHERE1 + ' 
	--		AND	LEFT(AT9000.CreditAccountID,3) = ''112'''
	--	SET @sWHERE2 = @sWHERE2 + '
	--		AND LEFT(AT9000.DebitAccountID,3) = ''112'''
	--END

	Set @sSQLSelect = N'
	SELECT  DivisionID,
			TranMonth,
			TranYear,
			BankAccountID,
			AccountID, 
			CreditAccountID,
			DebitAccountID,
			CurrencyID,
			ExchangeRate,
			OriginalAmount,	
			ConvertedAmount,
			SignOriginalAmount,	
			SignConvertedAmount,
			VoucherDate,
			VoucherNo,
			VoucherID,
			ObjectID,
			VDescription,
			TDescription,
			BDescription,
			TransactionTypeID,
			D_C,
			Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,
			Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID	 
	Into #AV0087'

	--Print @sSQLSelect
	
	SET @sSQLFrom = N'
	From (
	SELECT  AT9000.DivisionID,
			AT9000.TranMonth,
			AT9000.TranYear,
			CreditBankAccountID AS BankAccountID,
			CreditAccountID AS AccountID, 
			CreditAccountID,
			DebitAccountID,
			CASE WHEN TransactionTypeID=''T16'' then CurrencyIDCN else AT9000.CurrencyID END AS CurrencyID,
			CASE WHEN TransactionTypeID=''T16'' then ExchangeRateCN else AT9000.ExchangeRate End AS ExchangeRate,
			CASE WHEN TransactionTypeID=''T16'' then OriginalAmountCN else OriginalAmount End AS OriginalAmount,	
			ConvertedAmount,
			-CASE WHEN TransactionTypeID=''T16'' then OriginalAmountCN else OriginalAmount End AS SignOriginalAmount,	
			-ConvertedAmount AS SignConvertedAmount,
			VoucherDate,
			VoucherNo,
			VoucherID,
			AT9000.ObjectID,
			VoucherTypeID
			VDescription,
			TDescription,
			BDescription,
			TransactionTypeID,
			''C'' AS D_C,
			Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
			AT9000.Ana06ID,	AT9000.Ana07ID,	AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID	 
	FROM	AT9000  WITH (NOLOCK)	
	LEFT JOIN AT1016 WITH (NOLOCK) on  AT1016.DivisionID = AT9000.DivisionID AND AT1016.BankAccountID = AT9000.CreditBankAccountID
	WHERE	ISNULL(CreditBankAccountID,'''') <>'''' AND AT9000.CreditAccountID = ISNULL(AT1016.AccountID,'''')
			AND	AT9000.DivisionID  '+@StrDivisionID_New+'
			--AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) >= ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + '''
			AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) <= ''' + CONVERT(NVARCHAR(10), @ToDate ,101) + ''' 
			'+@sWHERE1+''
	--Print @sSQLFrom

	Set @sSQLUnion = N'
	UNION ALL
	SELECT   AT9000.DivisionID,
			AT9000.TranMonth,
			AT9000.TranYear,
			DebitBankAccountID AS BankAccountID,
			DebitAccountID AS AccountID, 
			CreditAccountID,
			DebitAccountID,
			AT1016.CurrencyID,
			AT9000.ExchangeRate,
			CASE WHEN AT1016.CurrencyID = (SELECT   top 1 ISNULL (BasecurrencyID,''VND'') from AT1101 WITH (NOLOCK) where DivisionID '+@StrDivisionID_New+') then ConvertedAmount else OriginalAmount end AS OriginalAmount,
			ConvertedAmount,
			CASE WHEN AT1016.CurrencyID = (SELECT  top  1  ISNULL (BasecurrencyID,''VND'') from AT1101 WITH (NOLOCK) where DivisionID '+@StrDivisionID_New+')  then ConvertedAmount else OriginalAmount end AS SignOriginalAmount,
			ConvertedAmount AS SignConvertedAmount,
			VoucherDate,
			VoucherNo,
			VoucherID,
			AT9000.ObjectID,
			VoucherTypeID
			VDescription,
			TDescription,
			BDescription,
			TransactionTypeID,
			''D'' AS D_C,
			Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
			AT9000.Ana06ID,	AT9000.Ana07ID,	AT9000.Ana08ID,AT9000.Ana09ID,AT9000.Ana10ID 
	FROM	AT9000 WITH (NOLOCK) 	
	LEFT JOIN AT1016 WITH (NOLOCK) on  AT1016.DivisionID = AT9000.DivisionID AND AT1016.BankAccountID = AT9000.DebitBankAccountID
	WHERE  ISNULL(DebitBankAccountID,'''')<>'''' AND AT9000.DebitAccountID = ISNULL(AT1016.AccountID,'''')
			AND	AT9000.DivisionID'+@StrDivisionID_New+'
			--AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) >= ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + '''
			AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) <= ''' + CONVERT(NVARCHAR(10), @ToDate ,101) + '''
			'+@sWHERE2+'
	 )A WHERE '+@SqlWhere+'

	'
	--Print @sSQLUnion

	----- Buoc 1, So du dau ky----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	Set @sSQL ='
	SELECT	AV1111.DivisionID, Isnull(Sum(SignOriginalAmount),0) as BegOriginalAmount, 
			Isnull(sum(SignConvertedAmount),0)as BegConvertedAmount
	Into #Temp1
	FROM	#AV0087 AV1111 
	INNER JOIN AT1016 WITH (NOLOCK) on AT1016.DivisionID = '''+@DivisionID+''' AND AT1016.BankAccountID = AV1111.BankAccountID
	WHERE	
			IsNull(BankID, '''') LIKE '''+@BankID+''' 
			AND ( (CONVERT(DATETIME,CONVERT(VARCHAR(10),AV1111.VoucherDate,101),101) < ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + ''' ) 
			or ( TransactionTypeID=''T00'' ))  
	group by AV1111.DivisionID
	SELECT	AV1111.DivisionID, Isnull(Sum(SignOriginalAmount),0) as EndOriginalAmount, 
			Isnull(sum(SignConvertedAmount),0) as EndConvertedAmount
	Into #Temp2 
	FROM	#AV0087 AV1111 
	INNER JOIN AT1016 WITH (NOLOCK) on AT1016.DivisionID = '''+@DivisionID+''' AND AT1016.BankAccountID = AV1111.BankAccountID
	WHERE	IsNull(BankID, '''') LIKE '''+@BankID+''' 
			AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV1111.VoucherDate,101),101) <= ''' + CONVERT(NVARCHAR(10), @ToDate ,101) + '''
	group by AV1111.DivisionID
	'

	----- Buoc 1b, So du dau ky theo  BankAccountID ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Print @sSQL

	SET @sSQL1 =' 
	SELECT	AV1111.DivisionID, 
			SUM(ISNULL(SignOriginalAmount,0)) AS  BegOriginalAmountDe  ,
			SUM(ISNULL(SignConvertedAmount,0)) AS BegConvertedAmountDe, 
			AV1111.BankAccountID, ObjectName, AT1016.BankAccountNo' + CASE WHEN @CustomerName = 109 THEN '' ELSE ', AV1111.ExchangeRate' END + '

	Into #AV7516		
	FROM	#AV0087 AV1111
	INNER JOIN AT1016 WITH (NOLOCK) on AT1016.DivisionID = '''+@DivisionID+''' AND AT1016.BankAccountID =AV1111.BankAccountID
	LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID =AT1016.BankID

	WHERE	ISNULL(AT1016.BankID,'''') LIKE '''+@BankID+'''  
			AND ( CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101), 101) <  '''+Convert(varchar(10),@FromDate,101)+'''   
					OR (CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101), 101) =  '''+Convert(varchar(10),@FromDate,101)+''' 
					AND TransactionTypeID=''T00''))  
	GROUP BY AV1111.DivisionID,AV1111.BankAccountID,ObjectName, AT1016.BankAccountNo' + CASE WHEN @CustomerName = 109 THEN '' ELSE ', AV1111.ExchangeRate' END + '
	'

	--Print @sSQL1

	----- Buoc 2,  Xac dinh so phat sinh ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SET @sSQL2='
	SELECT	AV1111.DivisionID, TranMonth, TranYear,  CreditAccountID, DebitAccountID, 

			NULL AS AccountID, 
			(CASE WHEN CreditAccountID <> AV1111.AccountID then CreditAccountID else DebitAccountID End ) AS CorAccountID,
			ISNULL (AT01.ObjectName, AV7516.ObjectName) AS BankName,		
			(Select BegOriginalAmount from #Temp1  WHERE DivisionID = AV1111.DivisionID) as BegOriginalAmount,
			(Select BegConvertedAmount from #Temp1 WHERE DivisionID = AV1111.DivisionID )as BegConvertedAmount,					 
			(Select EndOriginalAmount from #Temp2  WHERE DivisionID = AV1111.DivisionID)as EndOriginalAmount,
			(Select EndConvertedAmount from #Temp2 WHERE DivisionID =  AV1111.DivisionID)as EndConvertedAmount,	
			ISNULL(BegOriginalAmountDe,0) AS BegOriginalAmountDe,
			ISNULL(BegConvertedAmountDe,	0) AS BegConvertedAmountDe,	
						 
			CASE WHEN D_C = ''D'' then OriginalAmount else 0 End AS ReOriginalAmount, 
			CASE WHEN D_C = ''D'' then ConvertedAmount else 0 End AS ReConvertedAmount,
			CASE WHEN D_C = ''C'' then OriginalAmount else 0 End AS DeOriginalAmount, 
			CASE WHEN D_C = ''C'' then ConvertedAmount else 0 End AS DeConvertedAmount, 

			VoucherDate,
			CASE WHEN D_C = ''D'' then VoucherNo else NULL end AS ReVoucherNo, 
			CASE WHEN D_C = ''C'' then VoucherNo else NULL end AS DeVoucherNo, 

			VDescription, TDescription, BDescription, 
			AV1111.ObjectID, AT02.ObjectName,

			CASE WHEN TransactionTypeID = ''T16'' AND D_C = ''C''  THEN ''T26'' ELSE TransactionTypeID  END AS TransactionTypeID , 
			D_C, 
			Ana01ID,	Ana02ID,	Ana03ID,	Ana04ID,	Ana05ID,
			Ana06ID,	Ana07ID,	Ana08ID,	Ana09ID,	Ana10ID,
			AV1111.BankAccountID,  AV1111.CurrencyID, AT1016.BankAccountNo, 
			BankID' + CASE WHEN @CustomerName = 109 THEN '' ELSE ', AV1111.ExchangeRate' END + '
	Into #AV7515
	FROM	#AV0087 AV1111 	
	INNER JOIN AT1016 WITH (NOLOCK) on AT1016.DivisionID = '''+@DivisionID+''' AND AT1016.BankAccountID =AV1111.BankAccountID
	LEFT JOIN #AV7516 AV7516 on AV7516.BankAccountID = AV1111.BankAccountID AND AV7516.DivisionID = AV1111.DivisionID
	LEFT JOIN AT1202 AT01 WITH (NOLOCK) on AT01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT01.ObjectID =AT1016.BankID
	LEFT JOIN AT1202 AT02 WITH (NOLOCK) on AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID =AV1111.ObjectID

	WHERE 	TransactionTypeID<>''T00'' AND
			ISNULL(AT1016.BankID,'''') LIKE '''+@BankID+'''  AND 
			(CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101), 101) Between  '''+Convert(varchar(10),@FromDate,101)+''' AND '''+convert(varchar(10), @ToDate,101)+''' ) '

 IF(CHARINDEX(',', @StrDivisionID) > 0 )
 BEGIN
		SET @sSQL3 ='
SELECT * FROM (
SELECT * FROM (
		SELECT #AV7515.DivisionID,
               #AV7515.TranMonth,
               #AV7515.TranYear,
               CreditAccountID,
               DebitAccountID,
               AccountID,
               CorAccountID,
               BankName,
               BegOriginalAmount,
               BegConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmount,
               EndOriginalAmount,
               EndConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS EndConvertedAmount,
               BegOriginalAmountDe,
               BegConvertedAmountDe * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmountDe,
               ReOriginalAmount,
               ReConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS ReConvertedAmount,
               DeOriginalAmount,
               DeConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS DeConvertedAmount,
               VoucherDate,
               ReVoucherNo,
               DeVoucherNo,
               VDescription,
               TDescription,
               BDescription,
               ObjectID,
               ObjectName,
               TransactionTypeID,
               D_C,
               Ana01ID,
               Ana02ID,
               Ana03ID,
               Ana04ID,
               Ana05ID,
               Ana06ID,
               Ana07ID,
               Ana08ID,
               Ana09ID,
               Ana10ID,
               #AV7515.BankAccountID,
               #AV7515.CurrencyID,
               BankAccountNo,
               #AV7515.BankID FROM #AV7515 
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #AV7515.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
										'
		SET @sSQL3_01 = N'
		UNION ALL
		SELECT ''@@@'' As DivisionID,
               #AV7515.TranMonth,
               #AV7515.TranYear,
               CreditAccountID,
               DebitAccountID,
               AccountID,
               CorAccountID,
               BankName,
               SUM(BegOriginalAmount) AS BegOriginalAmount,
               SUM(BegConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS BegConvertedAmount,
               SUM(EndOriginalAmount) AS EndOriginalAmount,
               SUM(EndConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS EndConvertedAmount,
               SUM(BegOriginalAmountDe) AS BegOriginalAmountDe,
               SUM(BegConvertedAmountDe * ISNULL(AT1012.ExchangeRate, 1)) AS BegConvertedAmountDe,
               SUM(ReOriginalAmount) AS ReOriginalAmount,
               SUM(ReConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS ReConvertedAmount,
               SUM(DeOriginalAmount) AS DeOriginalAmount,
               SUM(DeConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) AS DeConvertedAmount,
               VoucherDate,
               ReVoucherNo,
               DeVoucherNo,
               VDescription,
               TDescription,
               BDescription,
               ObjectID,
               ObjectName,
               TransactionTypeID,
               D_C,
               Ana01ID,
               Ana02ID,
               Ana03ID,
               Ana04ID,
               Ana05ID,
               Ana06ID,
               Ana07ID,
               Ana08ID,
               Ana09ID,
               Ana10ID,
               #AV7515.BankAccountID,
               #AV7515.CurrencyID,
               BankAccountNo,
               #AV7515.BankID FROM #AV7515 
			   LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #AV7515.DivisionID
		       LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
			   GROUP BY
			   #AV7515.TranMonth,
               #AV7515.TranYear,
               CreditAccountID,
               DebitAccountID,
               AccountID,
               CorAccountID,
               BankName,
               VoucherDate,
               ReVoucherNo,
               DeVoucherNo,
               VDescription,
               TDescription,
               BDescription,
               ObjectID,
               ObjectName,
               TransactionTypeID,
               D_C,
               Ana01ID,
               Ana02ID,
               Ana03ID,
               Ana04ID,
               Ana05ID,
               Ana06ID,
               Ana07ID,
               Ana08ID,
               Ana09ID,
               Ana10ID,
               #AV7515.BankAccountID,
               #AV7515.CurrencyID,
               BankAccountNo,
               #AV7515.BankID,
			   AT1012.ExchangeRate
		) A'

		SET @sSQL4 = N'
		UNION ALL
				SELECT * FROM (
					SELECT
					AV7516.DivisionID, 
					NULL AS TranMonth, 
					NULL AS TranYear,  
					NULL AS CreditAccountID, 
					NULL AS DebitAccountID, 
					NULL AS AccountID, 
					NULL AS CorAccountID,				
					AV7516.ObjectName AS  BankName,						
					(Select BegOriginalAmount from #Temp1 WHERE DivisionID = AV7516.DivisionID ) as BegOriginalAmount,
					(Select BegConvertedAmount from #Temp1 WHERE DivisionID = AV7516.DivisionID ) * ISNULL(AT1012.ExchangeRate, 1) as BegConvertedAmount,					 
					(Select EndOriginalAmount from #Temp2 WHERE DivisionID = AV7516.DivisionID ) as EndOriginalAmount,
					(Select EndConvertedAmount from #Temp2 WHERE DivisionID = AV7516.DivisionID ) * ISNULL(AT1012.ExchangeRate, 1) as EndConvertedAmount,	
						 
					ISNULL(BegOriginalAmountDe,0) AS BegOriginalAmountDe,
					ISNULL(BegConvertedAmountDe,	0) * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmountDe,									 
					0  AS ReOriginalAmount, 
					0  AS ReConvertedAmount,
					0  AS DeOriginalAmount, 
					0  AS DeConvertedAmount, 
					Convert(DateTime, NULL) AS VoucherDate,
					NULL  AS ReVoucherNo, 
					NULL  AS DeVoucherNo, 
					NULL AS VDescription, NULL AS TDescription, NULL AS BDescription, 
					NULL AS ObjectID, NULL AS  ObjectName,
					''TZZ'' AS TransactionTypeID, -- Gan <> NULL de Count tren Report
					NULL AS D_C, 
					Null as	Ana01ID,
					Null as	Ana02ID,
					Null as	Ana03ID,
					Null as	Ana04ID,
					Null as	Ana05ID,
					Null as	Ana06ID,
					Null as	Ana07ID,
					Null as	Ana08ID,
					Null as	Ana09ID,
					Null as	Ana10ID,
					AV7516.BankAccountID,  NULL AS CurrencyID, AV7516.BankAccountNo, 
					NULL AS BankID--, AV7516.ExchangeRate
		FROM		#AV7516 AV7516
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7516.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
		WHERE	AV7516.BankAccountID NOT IN (SELECT ISNULL(BankAccountID,'''') FROM #AV7515 ) 
				AND (ISNULL(BegOriginalAmountDe,0) <> 0 or ISNULL(BegConvertedAmountDe,0) <> 0)
		'
		SET @sSQL5 = N'	 
		UNION ALL
						SELECT
					''@@@'' AS DivisionID, 
					NULL AS TranMonth, 
					NULL AS TranYear,  
					NULL AS CreditAccountID, 
					NULL AS DebitAccountID, 
					NULL AS AccountID, 
					NULL AS CorAccountID,				
					AV7516.ObjectName AS  BankName,						
					(Select SUM(BegOriginalAmount) from #Temp1 ) as BegOriginalAmount,
					(Select SUM(BegConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ) from #Temp1
					LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #Temp1.DivisionID
					LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''  )  as BegConvertedAmount,					 
					(Select SUM(EndOriginalAmount) from #Temp2 ) as EndOriginalAmount,
					(Select SUM(EndConvertedAmount * ISNULL(AT1012.ExchangeRate, 1)) from #Temp2 
					
					LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #Temp2.DivisionID
					LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
										)  as EndConvertedAmount,	
						 
					SUM(ISNULL(BegOriginalAmountDe,0)) AS BegOriginalAmountDe,
					SUM(ISNULL(BegConvertedAmountDe,	0) * ISNULL(AT1012.ExchangeRate, 1))  AS BegConvertedAmountDe, 									 
					0  AS ReOriginalAmount, 
					0  AS ReConvertedAmount,
					0  AS DeOriginalAmount, 
					0  AS DeConvertedAmount, 
					Convert(DateTime, NULL) AS VoucherDate,
					NULL  AS ReVoucherNo, 
					NULL  AS DeVoucherNo, 
					NULL AS VDescription, NULL AS TDescription, NULL AS BDescription, 
					NULL AS ObjectID, NULL AS  ObjectName,
					''TZZ'' AS TransactionTypeID, -- Gan <> NULL de Count tren Report
					NULL AS D_C, 
					Null as	Ana01ID,
					Null as	Ana02ID,
					Null as	Ana03ID,
					Null as	Ana04ID,
					Null as	Ana05ID,
					Null as	Ana06ID,
					Null as	Ana07ID,
					Null as	Ana08ID,
					Null as	Ana09ID,
					Null as	Ana10ID,
					AV7516.BankAccountID,  NULL AS CurrencyID, AV7516.BankAccountNo, 
					NULL AS BankID--, AV7516.ExchangeRate
		FROM		#AV7516 AV7516
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7516.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
		WHERE	AV7516.BankAccountID NOT IN (SELECT ISNULL(BankAccountID,'''') FROM #AV7515 ) 
				AND (ISNULL(BegOriginalAmountDe,0) <> 0 or ISNULL(BegConvertedAmountDe,0) <> 0) 
				GROUP BY AV7516.ObjectName, AV7516.BankAccountID, AV7516.BankAccountNo,
						 AT1012.ExchangeRate
				)B

) C
Order by DivisionID,BankAccountID,Voucherdate,TransactionTypeID
'--+@Orderby

		print @sSQLSelect
		print @sSQLFrom
		print @sSQLUnion
		print @sSQL
		print @sSQL1
		print @sSQL2
		print @sSQL3
		print @sSQL3_01
		print @sSQL4
		print @sSQL5


		EXEC (@sSQLSelect+@sSQLFrom+@sSQLUnion+@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL3_01+@sSQL4+@sSQL5)
 END
 ELSE
 BEGIN
     	SET @sSQL3 ='
SELECT * FROM (
SELECT * FROM (
		SELECT #AV7515.DivisionID,
               #AV7515.TranMonth,
               #AV7515.TranYear,
               CreditAccountID,
               DebitAccountID,
               AccountID,
               CorAccountID,
               BankName,
               BegOriginalAmount,
               BegConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmount,
               EndOriginalAmount,
               EndConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS EndConvertedAmount,
               BegOriginalAmountDe,
               BegConvertedAmountDe * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmountDe,
               ReOriginalAmount,
               ReConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS ReConvertedAmount,
               DeOriginalAmount,
               DeConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS DeConvertedAmount,
               VoucherDate,
               ReVoucherNo,
               DeVoucherNo,
               VDescription,
               TDescription,
               BDescription,
               ObjectID,
               ObjectName,
               TransactionTypeID,
               D_C,
               Ana01ID,
               Ana02ID,
               Ana03ID,
               Ana04ID,
               Ana05ID,
               Ana06ID,
               Ana07ID,
               Ana08ID,
               Ana09ID,
               Ana10ID,
               #AV7515.BankAccountID,
               #AV7515.CurrencyID,
               BankAccountNo,
               #AV7515.BankID FROM #AV7515 
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = #AV7515.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
										'
		SET @sSQL3_01 = N'
		
		) A'

		SET @sSQL4 = N'
		UNION ALL
				SELECT * FROM (
					SELECT
					AV7516.DivisionID, 
					NULL AS TranMonth, 
					NULL AS TranYear,  
					NULL AS CreditAccountID, 
					NULL AS DebitAccountID, 
					NULL AS AccountID, 
					NULL AS CorAccountID,				
					AV7516.ObjectName AS  BankName,						
					(Select BegOriginalAmount from #Temp1 WHERE DivisionID = AV7516.DivisionID ) as BegOriginalAmount,
					(Select BegConvertedAmount from #Temp1 WHERE DivisionID = AV7516.DivisionID ) * ISNULL(AT1012.ExchangeRate, 1) as BegConvertedAmount,					 
					(Select EndOriginalAmount from #Temp2 WHERE DivisionID = AV7516.DivisionID ) as EndOriginalAmount,
					(Select EndConvertedAmount from #Temp2 WHERE DivisionID = AV7516.DivisionID ) * ISNULL(AT1012.ExchangeRate, 1) as EndConvertedAmount,	
						 
					ISNULL(BegOriginalAmountDe,0) AS BegOriginalAmountDe,
					ISNULL(BegConvertedAmountDe,	0) * ISNULL(AT1012.ExchangeRate, 1) AS BegConvertedAmountDe,									 
					0  AS ReOriginalAmount, 
					0  AS ReConvertedAmount,
					0  AS DeOriginalAmount, 
					0  AS DeConvertedAmount, 
					Convert(DateTime, NULL) AS VoucherDate,
					NULL  AS ReVoucherNo, 
					NULL  AS DeVoucherNo, 
					NULL AS VDescription, NULL AS TDescription, NULL AS BDescription, 
					NULL AS ObjectID, NULL AS  ObjectName,
					''TZZ'' AS TransactionTypeID, -- Gan <> NULL de Count tren Report
					NULL AS D_C, 
					Null as	Ana01ID,
					Null as	Ana02ID,
					Null as	Ana03ID,
					Null as	Ana04ID,
					Null as	Ana05ID,
					Null as	Ana06ID,
					Null as	Ana07ID,
					Null as	Ana08ID,
					Null as	Ana09ID,
					Null as	Ana10ID,
					AV7516.BankAccountID,  NULL AS CurrencyID, AV7516.BankAccountNo, 
					NULL AS BankID--, AV7516.ExchangeRate
		FROM		#AV7516 AV7516
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7516.DivisionID
		LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
		WHERE	AV7516.BankAccountID NOT IN (SELECT ISNULL(BankAccountID,'''') FROM #AV7515 ) 
				AND (ISNULL(BegOriginalAmountDe,0) <> 0 or ISNULL(BegConvertedAmountDe,0) <> 0)
		'
		SET @sSQL5 = N'	 
		
				)B

) C
Order by DivisionID,BankAccountID,Voucherdate,TransactionTypeID
'--+@Orderby

		print @sSQLSelect
		print @sSQLFrom
		print @sSQLUnion
		print @sSQL
		print @sSQL1
		print @sSQL2
		print @sSQL3
		print @sSQL3_01
		print @sSQL4
		print @sSQL5


		EXEC (@sSQLSelect+@sSQLFrom+@sSQLUnion+@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL3_01+@sSQL4+@sSQL5)
 END

 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

