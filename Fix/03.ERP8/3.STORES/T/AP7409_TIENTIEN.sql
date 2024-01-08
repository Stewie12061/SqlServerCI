IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7409_TIENTIEN]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7409_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In Tong hop no phai tra
-- <Param>
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Huỳnh Thử, Date 10.05.2021 -- Tách Store Tiên Tiến
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7409_TIENTIEN] 	
					@DivisionID AS nvarchar(50) ,
					@FromMonth AS int,
					@FromYear  AS int,
					@ToMonth  AS int,
					@ToYear  AS int,
					@TypeD AS tinyint,  	
					@FromDate AS datetime,
					@ToDate AS datetime,
					@CurrencyID AS nvarchar(50),
					@FromAccountID AS nvarchar(50),
					@ToAccountID AS nvarchar(50),
					@FromObjectID AS nvarchar(50),
					@ToObjectID AS nvarchar(50),
					@Groupby AS tinyint ,
					@StrDivisionID AS NVARCHAR(4000) = '' ,
					@DatabaseName  AS NVARCHAR(250) = ''  ,
					@ReportDate AS DATETIME = NULL
 AS

DECLARE @sSQL AS nvarchar(MAX),
		@sSQL_0 AS NVARCHAR(MAX),
		@sSQL1 AS NVARCHAR(MAX),
		@sSQLUnion AS nvarchar(Max),
		@GroupTypeID AS nvarchar(50),
		@GroupID AS nvarchar(50),
		@TypeDate AS nvarchar(50),
		@TableName AS nvarchar(50),
		@SqlObject AS nvarchar(4000) ,
		@SqlGroupBy AS nvarchar(4000),
		@sGROUPBY AS nvarchar(4000),
		@CustomerName INT,
		@ReportDivisionID AS NVARCHAR(50)
		

	IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END
	--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
		
SET @GroupTypeID ='O01'


SET @GroupID = (Case @GroupTypeID 
					When 'O01'  Then 'Object.O01ID' 		---- Nhom theo ma phan tich
					When 'O02'  Then 'Object.O02ID' 
					When 'O03'  Then 'Object.O03ID' 
					When 'O04'  Then 'Object.O04ID'
					When 'O05'  Then 'Object.O05D' 
				End)


If @GroupBy= 0    ---- Nhom theo doi tuong , tai khoan
	SET @SqlGroupBy = '
				Object.O01ID AS GroupID,
				AT1015.AnaName AS  GroupName,
				D3.ObjectID AS GroupID1, 
				ObjectName AS GroupName1,
				D3.AccountID AS GroupID2,
				AccountName AS GroupName2, '
else   		----- Nhom theo tai khoan, doi tuong
	SET @SqlGroupBy = '
				Object.O01ID AS GroupID,
				AT1015.AnaName AS  GroupName,
				D3.AccountID AS GroupID1,
				AccountName AS GroupName1, 
				D3.ObjectID AS GroupID2, 
				ObjectName AS GroupName2,'

Exec AP7401 @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @StrDivisionID

IF @TypeD = 1	---- Theo ngay hoa don
	SET @TypeDate = 'CONVERT(nvarchar(10),InvoiceDate,101)'
ELSE IF @TypeD = 2 	---- Theo ngay chung tu
	SET @TypeDate = 'CONVERT(nvarchar(10),VoucherDate,101)'

IF @TypeD <> 0   ----- In theo ngay
BEGIN
	SET @sSQL = N' 
	SELECT	D3.DivisionID, ' + @SqlGroupBy + '	
			D3.ObjectID,	ObjectName,	Object.Address,	Object.VATNo,
			D3.AccountID,	AccountName,
			D3.CurrencyID,
			Object.S1,	Object.S2,	Object.S3,
			Object.O01ID,Object.O02ID,Object.O03ID,	Object.O04ID,Object.O05ID,		
			Object.Tel,	Object.Fax,	Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalOpening,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedOpening,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType= ''00'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' 
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCredit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedClosing,'
	SET @sSQL_0 = N'
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebitYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
			SUM (CASE WHEN (D3.TranMonth + D3.TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCreditYTD, Object.Note
	'
	SET @sSQL1 = N'
	FROM	AV7401 D3 
	INNER JOIN AT1202 Object on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
	LEFT JOIN AT1015 on AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID = ''' + @GroupTypeID + '''
	INNER JOIN AT1005 AS Account on Account.AccountID = D3.AccountID
	LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = D3.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
	GROUP BY D3.DivisionID, D3.ObjectID, 
			D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, Object.O01ID, 
			Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
			Object.Tel, Object.Fax, Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
			Object.Address, Object.VATNo, AccountName, D3.CurrencyID,  AT1015.AnaName,Object.Note,AT1012.ExchangeRate, ' 
END
ELSE
BEGIN
	SET @sSQL = N'
	SELECT  D3.DivisionID, '+ @SqlGroupBy+'	
			D3.ObjectID,
			Object.ObjectName,	
			Object.Address, 
			Object.VATNo,
			D3.AccountID,
			AccountName,
			D3.CurrencyID,
			Object.S1, 
			Object.S2,  
			Object.S3, 
			Object.O01ID,  
			Object.O02ID, 
			Object.O03ID, 
			Object.O04ID, 
			Object.O05ID,
			Object.Tel, 
			Object.Fax, 
			Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
  			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END)  AS OriginalOpening,
  			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedOpening ,
  			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit ,
  			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebit,
  			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
 			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCredit,
 			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+')  OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
 			SUM (CASE WHEN (D3.TranMonth + 100*D3.TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') OR TransactiontypeID=''T00''  THEN SignConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedClosing,'
	SET @sSQL_0 = N'
 			SUM (CASE WHEN (D3.TranMonth + D3.TranYear*100 > '+str(@FromYear)+'*100)  AND (D3.TranMonth +D3.TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
 			SUM (CASE WHEN (D3.TranMonth + D3.TranYear*100 > '+str(@FromYear)+'*100)  AND (D3.TranMonth +D3.TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedDebitYTD,
 			SUM (CASE WHEN (D3.TranMonth + D3.TranYear*100 > '+str(@FromYear)+'*100)  AND (D3.TranMonth +D3.TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
 			SUM (CASE WHEN (D3.TranMonth + D3.TranYear*100 > '+str(@FromYear)+'*100)  AND (D3.TranMonth +D3.TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) ELSE 0 END) AS ConvertedCreditYTD, Object.Note
	'									   
	SET @sSQL1 = N'						   
	FROM AV7401 D3 						   
	INNER JOIN AT1202 Object on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
	LEFT JOIN AT1015 on	AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID =''' + @GroupTypeID + '''
	INNER JOIN AT1005 Account on Account.AccountID = D3.AccountID
	LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID	
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = D3.DivisionID
	LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''

	GROUP BY	D3.DivisionID, D3.ObjectID, D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, 
				Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
				Object.Tel, Object.Fax, Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
				Object.Address, Object.VATNo, AccountName, D3.CurrencyID,  AT1015.AnaName,Object.Note,AT1012.ExchangeRate, ' 
END

PRINT @sSQL
PRINT @sSQL_0
PRINT(@sSQL1)
PRINT(@GroupID)

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7419]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
     EXEC ('  CREATE VIEW AV7419 AS ' + @sSQL + @sSQL_0 + @sSQL1 + @GroupID)
ELSE
     EXEC ('  ALTER VIEW AV7419  AS ' + @sSQL + @sSQL_0 + @sSQL1 + @GroupID)



---Print @sSQL
	
---- Bo phan so 0 
IF @CurrencyID = '%'
	SET @sSQL =   '
		SELECT DivisionID, 
		GroupID,
		GroupName, 
		GroupID1, 
		GroupName1, 
		GroupID2, 
		GroupName2, 
		ObjectID, 
		ObjectName,
		Address, 
		VATNo,
		AccountID, 
		AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7419.DivisionID AND AccountID = AV7419.AccountID) AccountNameE,
		''%'' AS CurrencyID,
		S1, 
		S2,  
		S3, 
		O01ID,  
		O02ID, 
		O03ID, 
		O04ID, 
		O05ID, 
		Tel, 
		Fax, 
		Email, ObjectTypeID, ObjectTypeName,
		SUM((Case when OriginalOpening < 0 then abs(OriginalOpening) else 0 end)) AS CreditOriginalOpening,
		SUM((Case when OriginalOpening >= 0 then abs(OriginalOpening) else 0 end)) AS DebitOriginalOpening,
		SUM(OriginalOpening) AS OriginalOpening, 
		Case when Sum(ConvertedOpening) < 0 then -Sum(ConvertedOpening) else 0 end AS CreditConvertedOpening ,   
		Case when Sum(ConvertedOpening) > 0 then Sum(ConvertedOpening) else 0 end AS DebitConvertedOpening ,   
		Sum(ConvertedOpening) AS ConvertedOpening,
		sum(OriginalDebit) AS OriginalDebit,   
		sum(ConvertedDebit) AS ConvertedDebit,   
		sum(OriginalCredit) AS OriginalCredit,  
		Sum(ConvertedCredit) AS ConvertedCredit,  
		SUM((Case when OriginalClosing < 0 then abs(OriginalClosing) else 0 end)) AS CreditOriginalClosing,
		SUM((Case when OriginalClosing >= 0 then abs(OriginalClosing) else 0 end)) AS DebitOriginalClosing,	  
		sum(OriginalClosing) AS OriginalClosing ,	
		Case when Sum(ConvertedClosing) <0 then -Sum(ConvertedClosing) else 0 end AS CreditConvertedClosing ,   
		Case when Sum(ConvertedClosing) >0 then Sum(ConvertedClosing) else 0 end AS DebitConvertedClosing ,   
		Sum(ConvertedClosing) AS ConvertedClosing ,	
		0 AS OriginalDebitYTD,  
		0 AS ConvertedDebitYTD,  
		0 AS OriginalCreditYTD ,  
		0 AS ConvertedCreditYTD,
		Note 	
			
	 FROM AV7419 
	 WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
		OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
		OR OriginalClosing <> 0 OR ConvertedClosing <> 0 
	 GROUP BY DivisionID, GroupID,  GroupName,  GroupID1,   GroupName1,   GroupID2,   GroupName2,
			ObjectID,   ObjectName, Address, VATNo,  AccountID,  AccountName,		
			S1, S2, S3, O01ID,  O02ID, O03ID, O04ID, O05ID, Tel, Fax, Email, ObjectTypeID, ObjectTypeName,Note'

ELSE
	SET @sSQL =  '
		SELECT DivisionID, 
		GroupID, 
		GroupName, 
		GroupID1, 
		GroupName1, 
		GroupID2, 
		GroupName2, 
		ObjectID, 
		ObjectName,
		Address, 
		VATNo,
		AccountID, 
		AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7419.DivisionID AND AccountID = AV7419.AccountID) AccountNameE,
		CurrencyID,
		S1, 
		S2,  
		S3, 
		O01ID,  
		O02ID, 
		O03ID, 
		O04ID, 
		O05ID, 
		Tel, 
		Fax, 
		Email, ObjectTypeID, ObjectTypeName,
		(Case when OriginalOpening < 0 then abs(OriginalOpening) else 0 end) AS CreditOriginalOpening,
		(Case when OriginalOpening >= 0 then abs(OriginalOpening) else 0 end) AS DebitOriginalOpening,
		OriginalOpening, 
		(Case when ConvertedOpening < 0 then abs(ConvertedOpening) else 0 end) AS CreditConvertedOpening,
		(Case when ConvertedOpening >= 0 then abs(ConvertedOpening) else 0 end) AS DebitConvertedOpening,
		ConvertedOpening, 
		OriginalDebit, 
		ConvertedDebit, 
		OriginalCredit,
		ConvertedCredit,
		(Case when OriginalClosing < 0 then abs(OriginalClosing) else 0 end) AS CreditOriginalClosing,
		(Case when OriginalClosing >= 0 then abs(OriginalClosing) else 0 end) AS DebitOriginalClosing,	 
		OriginalClosing, 
		(Case when ConvertedClosing < 0 then abs(ConvertedClosing) else 0 end) AS CreditConvertedClosing,
		(Case when ConvertedClosing >= 0 then abs(ConvertedClosing) else 0 end) AS DebitConvertedClosing,
		ConvertedClosing,
		OriginalDebitYTD,
		ConvertedDebitYTD, 
		OriginalCreditYTD, 
		ConvertedCreditYTD, Note 
	FROM AV7419 
	WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
		OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
		OR OriginalClosing <> 0 OR ConvertedClosing <> 0 '
		
Print @sSQL 
--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7409]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--    EXEC ('  CREATE VIEW AV7409 AS ' + @sSQL)
--ELSE
--    EXEC ('  ALTER VIEW AV7409  AS ' + @sSQL)

			
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7409]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV7409 AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW AV7409  AS ' + @sSQL )
	
			
			

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

