IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7403_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7403_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Tong hop no phai thu
-- <Param>
---- LƯU Ý: Khi trả thêm dữ liệu cho view AV7403 thì VUI LÒNG trả dữ liệu tại mode KH Sieu Thanh để tránh bị lỗi
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Huỳnh Thử, Date 10.05.2021 -- Tách Store Tiên Tiến
---- Modified on 21/07/2021 by Huỳnh Thử -- Check IsNull @ReportDate
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7403_TIENTIEN]	 	
					@DivisionID AS nvarchar(50) ,
					@FromMonth AS int,
					@FromYear  AS int,
					@ToMonth  AS int,
					@ToYear  AS int,
					@TypeD AS tinyint,  	--0 theo thang 
					                    	--1 theo ngay hoa don 
					                    	--2 theo ngay hach toan
					@FromDate AS datetime,
					@ToDate AS datetime,
					@CurrencyID AS nvarchar(50),
					@FromAccountID AS nvarchar(50),
					@ToAccountID AS nvarchar(50),
					@FromObjectID AS nvarchar(50),
					@ToObjectID AS nvarchar(50),
					@Groupby AS TINYINT,
					@StrDivisionID AS NVARCHAR(4000) = '',
					@DatabaseName as nvarchar(250) ='',
					@ReportDate AS DATETIME = NULL
					


 AS

DECLARE 
	@sSQL AS Nvarchar(max),
	@sSQL_0 AS Nvarchar(max),
	@sSQL1 AS nvarchar(MAX),
	@sSQL2 AS nvarchar(MAX),
	@sSQLUnion AS nvarchar(MAX),
	@GroupTypeID AS nvarchar(50),		
	@GroupID AS nvarchar(50),
	@TypeDate AS nvarchar(50),
    @TableName AS nvarchar(50),
    @SqlObject AS nvarchar(4000),
    @SqlGroupBy AS nvarchar(4000),
    @StrDivisionID_New AS NVARCHAR(4000),
	@ReportDivisionID AS NVARCHAR(50)

    
Declare @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF ISNULL(@ReportDate, '') = ''
	SET @ReportDate = GETDATE()
IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END

BEGIN	
	Set @GroupTypeID ='O01'

	Set @GroupID  = (Case  @GroupTypeID 
						When 'O01' Then 'Object.O01ID' 		---- Nhom theo ma phan tich doi tuong
						When 'O02'  Then 'Object.O02ID' 
						When 'O03'  Then 'Object.O03ID' 
						When 'O04'  Then 'Object.O04ID'
						When 'O05'  Then 'Object.O05D' 
					End)

	If @GroupBy = 0    ---- Nhom theo doi tuong truoc , tai khoan sau
		set @SqlGroupBy = '  
			Object.O01ID AS GroupID,
			O1.AnaName AS  GroupName,
			D3.ObjectID AS GroupID1, 
			ObjectName AS GroupName1,
			D3.AccountID AS GroupID2,
			AccountName AS GroupName2, '
	else   		----- Nhom theo tai khoan truoc, doi tuong sau
		set @SqlGroupBy = ' 
			Object.O01ID AS GroupID,
			O1.AnaName AS  GroupName,
			D3.AccountID AS GroupID1,
			AccountName AS GroupName1, 
			D3.ObjectID AS GroupID2, 
			ObjectName AS GroupName2,'

	Exec AP7402  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID,  @ToObjectID, @StrDivisionID 

	IF @TypeD = 1	---- Theo ngay Hoa don
		SET @TypeDate = 'InvoiceDate'
	ELSE IF @TypeD = 2 	---- Theo ngay hach toan
		SET @TypeDate = 'VoucherDate'

	if @TypeD <> 0   ----- In theo ngay
	Begin
	SET @sSQL = ' 
	SELECT	D3.DivisionID, ' + @SqlGroupBy + '	
			D3.ObjectID,  ObjectName, Object.Address, Object.VATNo, 
			D3.AccountID, AccountName, AccountNameE, D3.CurrencyID,
			Object.S1, Object.S2,  Object.S3, 
			OS1.SName AS S1Name, OS2.SName AS S2Name, OS3.SName AS S3Name, 
			Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
			O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
			Object.Tel, Object.Fax, Object.Email,Object.Note,Object.RePaymentTermID,Object.DeAddress,Object.Note1,Object.ReDays,Object.ReCreditLimit,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END)  AS DebitOriginalOpening,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS DebitConvertedOpening,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalOpening,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS CreditConvertedOpening,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' AND
						   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' AND
						   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  AND
						   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCredit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  AND
						   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCredit,'
	SET @sSQL1 = '					   
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS DebitConvertedClosing,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing,
			SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS CreditConvertedClosing,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCreditYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCreditYTD,
			AT1201.ObjectTypeID, AT1201.ObjectTypeName
			'
	SET @sSQL2 = '
		FROM AV7402 D3 
			INNER JOIN AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
			LEFT JOIN AT1015 O1 WITH (NOLOCK)  on O1.AnaID = Object.O01ID AND O1.AnaTypeID = ''O01''
			LEFT JOIN AT1015 O2 WITH (NOLOCK)  on O2.AnaID = Object.O02ID AND O2.AnaTypeID = ''O02''
			LEFT JOIN AT1015 O3 WITH (NOLOCK)  on O3.AnaID = Object.O03ID AND O3.AnaTypeID = ''O03''
			LEFT JOIN AT1015 O4 WITH (NOLOCK)  on O4.AnaID = Object.O04ID AND O4.AnaTypeID = ''O04''
			LEFT JOIN AT1015 O5 WITH (NOLOCK)  on O5.AnaID = Object.O05ID AND O5.AnaTypeID = ''O05''
			LEFT JOIN AT1207 OS1 WITH (NOLOCK)  on OS1.S = Object.S1 AND OS1.STypeID = ''O01''
			LEFT JOIN AT1207 OS2 WITH (NOLOCK)  on OS2.S = Object.S2 AND OS2.STypeID = ''O02''
			LEFT JOIN AT1207 OS3 WITH (NOLOCK)  on OS3.S = Object.S3 AND OS3.STypeID = ''O03''
			INNER JOIN AT1005 AS Account WITH (NOLOCK) on Account.AccountID = D3.AccountID
			LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID  
			LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = D3.DivisionID
			LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''		
		GROUP BY	D3.DivisionID, D3.ObjectID,  D3.AccountID, ObjectName,  Object.Address, Object.VATNo, Object.Tel, Object.Fax, Object.Email,
					AccountName, AccountNameE, D3.CurrencyID, 
					Object.S1, Object.S2,  Object.S3, 
					OS1.SName, OS2.SName, OS3.SName, 
					Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID, AT1012.ExchangeDate,
					O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName, AT1201.ObjectTypeID, AT1201.ObjectTypeName, Object.Note,Object.RePaymentTermID,Object.DeAddress,Object.Note1,Object.ReDays,Object.ReCreditLimit'
	END
	ELSE
	BEGIN
		SET @sSQL = '
	SELECT	D3.DivisionID, ' + @SqlGroupBy + '	
			D3.ObjectID,
			ObjectName,
			Object.Address,
			Object.VATNo, 
			D3.AccountID,
			AccountName, AccountNameE,
			D3.CurrencyID,
			Object.S1, Object.S2, Object.S3, 
			OS1.SName AS S1Name, OS2.SName AS S2Name, OS3.SName AS S3Name, 
			Object.O01ID, Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID, 
			O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
			Object.Tel, Object.Fax, Object.Email, Object.Note,Object.RePaymentTermID,Object.DeAddress,Object.Note1,Object.ReDays,Object.ReCreditLimit,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END)  AS DebitOriginalOpening,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS DebitConvertedOpening,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END)  AS CreditOriginalOpening,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS CreditConvertedOpening,
			SUM (CASE WHEN (D3.TranMonth + 100 * D3.TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebit,
			SUM (CASE WHEN (D3.TranMonth + 100 * D3.TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebit,
			SUM (CASE WHEN (D3.TranMonth + 100 * D3.TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN - SignOriginalAmount ELSE 0 END) AS OriginalCredit,
			SUM (CASE WHEN (D3.TranMonth + 100 * D3.TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN - SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCredit,'
	SET @sSQL1 = '
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS DebitConvertedClosing,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing,
			SUM (CASE WHEN ((D3.TranMonth + 100 * D3.TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS CreditConvertedClosing,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (D3.TranMonth + D3.TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (D3.TranMonth + D3.TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (D3.TranMonth + D3.TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCreditYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (D3.TranMonth + D3.TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCreditYTD,
			AT1201.ObjectTypeID, AT1201.ObjectTypeName
			'	
	SET @sSQL2 = '
		FROM AV7402 D3 	
			INNER JOIN AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
			LEFT JOIN AT1015 O1 WITH (NOLOCK) on O1.AnaID = Object.O01ID AND O1.AnaTypeID = ''O01''
			LEFT JOIN AT1015 O2 WITH (NOLOCK) on O2.AnaID = Object.O02ID AND O2.AnaTypeID = ''O02''
			LEFT JOIN AT1015 O3 WITH (NOLOCK) on O3.AnaID = Object.O03ID AND O3.AnaTypeID = ''O03''
			LEFT JOIN AT1015 O4 WITH (NOLOCK) on O4.AnaID = Object.O04ID AND O4.AnaTypeID = ''O04''
			LEFT JOIN AT1015 O5 WITH (NOLOCK) on O5.AnaID = Object.O05ID AND O5.AnaTypeID = ''O05''
			LEFT JOIN AT1207 OS1 WITH (NOLOCK) on OS1.S = Object.S1 AND OS1.STypeID = ''O01''
			LEFT JOIN AT1207 OS2 WITH (NOLOCK) on OS2.S = Object.S2 AND OS2.STypeID = ''O02''
			LEFT JOIN AT1207 OS3 WITH (NOLOCK) on OS3.S = Object.S3 AND OS3.STypeID = ''O03''
			INNER JOIN AT1005 Account WITH (NOLOCK) on Account.AccountID = D3.AccountID 
			LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID 		
			LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = D3.DivisionID
			LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
	GROUP BY  D3.DivisionID, D3.ObjectID, D3.AccountID, ObjectName,  Object.Address, Object.VATNo, Object.Tel, Object.Fax, Object.Email,
			AccountName, AccountNameE, D3.CurrencyID, 
			Object.S1, Object.S2,  Object.S3, 
			OS1.SName, OS2.SName, OS3.SName, 
			Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,  AT1012.ExchangeDate,
			O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName, AT1201.ObjectTypeID, AT1201.ObjectTypeName, Object.Note,Object.RePaymentTermID,Object.DeAddress,Object.Note1,Object.ReDays,Object.ReCreditLimit'
	End

	print (@sSQL)
	print (@sSQL1)
	print (@sSQL2)
	IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7413]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		 EXEC ('  CREATE VIEW AV7413 AS ' + @sSQL + @sSQL1 + @sSQL2)
	ELSE
		 EXEC ('  ALTER VIEW AV7413  AS ' + @sSQL + @sSQL1 + @sSQL2)



	--Print @sSQL



	
	---- Bo phan so 0 	
	IF @CurrencyID <> '%'
		Set @sSQL =  ' 
			SELECT AV7413.DivisionID, 
    		GroupID,
			GroupName,
			GroupID1,
			GroupName1,
			GroupID2,
			GroupName2,
			AV7413.ObjectID,
			ObjectName,
			Address,
			VATNo,
			AV7413.AccountID,
			AccountName, AccountNameE,
			CurrencyID,		 
			S1, S2, S3, 
			S1Name, S2Name, S3Name, 
			O01ID, O02ID, O03ID, O04ID, O05ID,
			O01Name, O02Name, O03Name, O04Name, O05Name, 
			Tel, Fax, Email,
			CASE WHEN DebitOriginalOpening - CreditOriginalOpening < 0 THEN CreditOriginalOpening - DebitOriginalOpening ELSE 0 END AS CreditOriginalOpening,
			CASE WHEN DebitOriginalOpening - CreditOriginalOpening > 0 THEN DebitOriginalOpening - CreditOriginalOpening ELSE 0 END AS DebitOriginalOpening,
			DebitOriginalOpening - CreditOriginalOpening AS OriginalOpening,
			CASE WHEN DebitConvertedOpening - CreditConvertedOpening < 0 THEN CreditConvertedOpening - DebitConvertedOpening ELSE 0 END AS CreditConvertedOpening,
			CASE WHEN DebitConvertedOpening - CreditConvertedOpening > 0 THEN DebitConvertedOpening - CreditConvertedOpening ELSE 0 END AS DebitConvertedOpening,
 			DebitConvertedOpening - CreditConvertedOpening AS ConvertedOpening,
			OriginalDebit,
			ConvertedDebit,
			OriginalCredit,
			ConvertedCredit,
			CASE WHEN DebitOriginalClosing - CreditOriginalClosing < 0 THEN CreditOriginalClosing - DebitOriginalClosing ELSE 0 END AS CreditOriginalClosing,
			CASE WHEN DebitOriginalClosing - CreditOriginalClosing > 0 THEN DebitOriginalClosing - CreditOriginalClosing ELSE 0 END AS DebitOriginalClosing,
			DebitOriginalClosing - CreditOriginalClosing AS OriginalClosing,   
			CASE WHEN DebitConvertedClosing - CreditConvertedClosing < 0 THEN CreditConvertedClosing - DebitConvertedClosing ELSE 0 END AS CreditConvertedClosing,
			CASE WHEN DebitConvertedClosing - CreditConvertedClosing > 0 THEN DebitConvertedClosing - CreditConvertedClosing ELSE 0 END AS DebitConvertedClosing,
			DebitConvertedClosing - CreditConvertedClosing AS ConvertedClosing,
			OriginalDebitYTD,
			ConvertedDebitYTD,
			OriginalCreditYTD,
			ConvertedCreditYTD, ObjectTypeID, ObjectTypeName, Note,RePaymentTermID,DeAddress,Note1,ReDays,ReCreditLimit
		FROM AV7413 
		WHERE DebitOriginalOpening - CreditOriginalOpening <> 0 
			OR DebitConvertedOpening - CreditConvertedOpening <> 0 OR OriginalDebit <> 0 
			OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
			OR DebitOriginalClosing - CreditOriginalClosing <> 0 
			OR DebitConvertedClosing - CreditConvertedClosing <> 0 '
	
	Else
	
		Set @sSQL =  ' 
			SELECT AV7413.DivisionID, 
    		GroupID,
			GroupName,
			GroupID1,
			GroupName1,
			GroupID2,
			GroupName2,
			AV7413.ObjectID,
			ObjectName,
			Address,
			VATNo,
			AV7413.AccountID,
			AccountName, AccountNameE,
			''%'' AS CurrencyID,  	
			S1, S2, S3, 
			S1Name, S2Name, S3Name, 
			O01ID, O02ID, O03ID, O04ID, O05ID,
			O01Name, O02Name, O03Name, O04Name, O05Name, 
			Tel, Fax, Email,
			0 AS CreditOriginalOpening,
 			0 AS DebitOriginalOpening,
			0 AS OriginalOpening,
 			Case when Sum(DebitConvertedOpening)-SUM(CreditConvertedOpening) < 0 then  - Sum(DebitConvertedOpening) + SUM(CreditConvertedOpening) else 0 end AS CreditConvertedOpening,
			Case when Sum(DebitConvertedOpening)-SUM(CreditConvertedOpening) > 0 then  Sum(DebitConvertedOpening)-SUM(CreditConvertedOpening) else 0 end AS DebitConvertedOpening,
			Sum(DebitConvertedOpening)-SUM(CreditConvertedOpening) AS ConvertedOpening,
			sum(OriginalDebit) AS OriginalDebit,
			sum(ConvertedDebit) AS ConvertedDebit,
			sum(OriginalCredit) AS OriginalCredit,
			Sum(ConvertedCredit) AS ConvertedCredit,
			0 AS CreditOriginalClosing,
			0 AS DebitOriginalClosing,
			sum(DebitOriginalClosing - CreditOriginalClosing) AS OriginalClosing,
			Case when Sum(DebitConvertedClosing)-SUM(CreditConvertedClosing) < 0 then  - Sum(DebitConvertedClosing) + SUM(CreditConvertedClosing) else 0 end AS CreditConvertedClosing,
			Case when Sum(DebitConvertedClosing)-SUM(CreditConvertedClosing) > 0 then  Sum(DebitConvertedClosing)-SUM(CreditConvertedClosing) else 0 end AS DebitConvertedClosing,
			Sum(DebitConvertedClosing)-SUM(CreditConvertedClosing) AS ConvertedClosing,
			0 AS OriginalDebitYTD,
			0 AS ConvertedDebitYTD,
			0 AS OriginalCreditYTD,
			0 AS ConvertedCreditYTD, ObjectTypeID, ObjectTypeName, Note,RePaymentTermID,DeAddress,Note1,ReDays,ReCreditLimit
		FROM AV7413
		WHERE DebitOriginalOpening - CreditOriginalOpening <> 0  
			OR DebitConvertedOpening - CreditConvertedOpening <> 0 OR OriginalDebit <> 0 
			OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
			OR DebitOriginalClosing - CreditOriginalClosing <> 0 
			OR DebitConvertedClosing - CreditConvertedClosing <> 0
		
		GROUP BY AV7413.DivisionID, GroupID, GroupName, GroupID1, GroupName1, GroupID2, GroupName2,
			AV7413.ObjectID, ObjectName, Address, VATNo, AV7413.AccountID, AccountName, AccountNameE,
			S1, S2, S3, 
			S1Name, S2Name, S3Name, 
			O01ID, O02ID, O03ID, O04ID, O05ID,
			O01Name, O02Name, O03Name, O04Name, O05Name, 
			Tel, Fax, Email, ObjectTypeID, ObjectTypeName, Note,RePaymentTermID,DeAddress,Note1,ReDays,ReCreditLimit
			'


	print @sSQL

	--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7403]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	--    EXEC ('  CREATE VIEW AV7403 AS ' + @sSQL3)
	--ELSE
	--    EXEC ('  ALTER VIEW AV7403  AS ' + @sSQL3)


		--EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)
	IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7403]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		EXEC ('  CREATE VIEW AV7403 AS ' + @sSQL )
	ELSE
		EXEC ('  ALTER VIEW AV7403  AS ' + @sSQL )	
		--select @sSQL
		--select @sSQL1
		--select @sSQL2
		--select @sSQL3

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
