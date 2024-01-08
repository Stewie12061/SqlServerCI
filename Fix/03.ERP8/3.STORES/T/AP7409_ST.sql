IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7409_ST]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7409_ST]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In Tong hop no phai tra
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Nguyen Van Nhan, Date 22.08.2003
----
---- Last  Edit Van Nhan &  Thuy Tuyen Date 13/07/2006 
---- Modified on 24/11/2011 by Le Thi Thu Hien : Chinh sua where ngay
---- Modified on 16/01/2012 by Le Thi Thu Hien : Sua CONVERT ngay
---- Modified on 28/12/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 14/11/2014 by Mai Duyen : Bổ sung thêm DatabaseName (tinh năng In báo cao TH no phai tra 2 Database ,KH SIEUTHANH)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 21/06/2017: Fix lỗi Union thiếu trường khi in báo cáo 2 DB của Sieu Thanh
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7409_ST] 	
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
					@DatabaseName  AS NVARCHAR(250) = '' 
 AS

DECLARE @sSQL AS nvarchar(4000),
		@sSQL1 AS NVARCHAR(4000),
		@GroupTypeID AS nvarchar(50),
		@GroupID AS nvarchar(50),
		@TypeDate AS nvarchar(50),
		@TableName AS nvarchar(50),
		@SqlObject AS nvarchar(4000) ,
		@SqlGroupBy AS nvarchar(4000),
		@sGROUPBY AS nvarchar(4000),
		@TableDBO as nvarchar(250)

If @DatabaseName  ='' 
	 Set @TableDBO=''
Else
	Set @TableDBO = '[' +  @DatabaseName + '].DBO.'
		
		
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

Exec AP7401_ST @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @StrDivisionID,@DatabaseName

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
			Object.Tel,	Object.Fax,	Object.Email,
			AT1201.ObjectTypeID, AT1201.ObjectTypeName,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalOpening,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedOpening,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' 
					   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCredit,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
			SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedClosing,
			SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
			SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
			SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
			SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCreditYTD
	'
	SET @sSQL1 = N'
	FROM	AV7401_ST D3 
	INNER JOIN '+ @TableDBO +'AT1202 Object on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
	LEFT JOIN '+ @TableDBO +'AT1015 AT1015 on AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID = ''' + @GroupTypeID + '''
	INNER JOIN '+ @TableDBO +'AT1005 AS Account on Account.AccountID = D3.AccountID
	LEFT JOIN AT1201 on AT1201.ObjectTypeID = Object.ObjectTypeID
	GROUP BY D3.DivisionID, D3.ObjectID, 
			D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, Object.O01ID, 
			Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
			Object.Tel, Object.Fax, Object.Email,
			Object.Address, Object.VATNo, AccountName, D3.CurrencyID,  AT1015.AnaName,
			AT1201.ObjectTypeID, AT1201.ObjectTypeName, ' 
END


ELSE
BEGIN
	SET @sSQL = N'
	SELECT  D3.DivisionID, '+ @SqlGroupBy+'	
			D3.ObjectID,
			ObjectName,	
			Address, 
			VATNo,
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
			Object.Email,
			AT1201.ObjectTypeID, AT1201.ObjectTypeName,
  			SUM (CASE WHEN (TranMonth + 100*TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END)  AS OriginalOpening,
  			SUM (CASE WHEN (TranMonth + 100*TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedOpening ,
  			SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit ,
  			SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebit,
  			SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
 			SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCredit,
 			SUM (CASE WHEN (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+')  OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
 			SUM (CASE WHEN (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') OR TransactiontypeID=''T00''  THEN SignConvertedAmount ELSE 0 END) AS ConvertedClosing,
 			SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100)  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
 			SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100)  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
 			SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100)  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
 			SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100)  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCreditYTD
	'
	SET @sSQL1 = N'
	FROM AV7401_ST D3 	
	INNER JOIN '+ @TableDBO +'AT1202 Object on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
	LEFT JOIN '+ @TableDBO +'AT1015  AT1015 on	AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID =''' + @GroupTypeID + '''
	INNER JOIN '+ @TableDBO +'AT1005 Account on Account.AccountID = D3.AccountID
	LEFT JOIN AT1201 on AT1201.ObjectTypeID = Object.ObjectTypeID

	GROUP BY	D3.DivisionID, D3.ObjectID, D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, 
				Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
				Object.Tel, Object.Fax, Object.Email,
				Address, VATNo, AccountName, D3.CurrencyID,  AT1015.AnaName,
				AT1201.ObjectTypeID, AT1201.ObjectTypeName,
				 ' 
END

PRINT @sSQL
PRINT(@sSQL1)
PRINT(@GroupID)

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7419_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
     EXEC ('  CREATE VIEW AV7419_ST AS ' + @sSQL + @sSQL1 + @GroupID)
ELSE
     EXEC ('  ALTER VIEW AV7419_ST  AS ' + @sSQL + @sSQL1 + @GroupID)



---Print @sSQL

---- Bo phan so 0 
IF @CurrencyID = '%'
	SET @sSQL = '
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
		AccountName, 
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
		Email,
		ObjectTypeID, ObjectTypeName,
		0 AS CreditOriginalOpening ,  
 		0 AS DebitOriginalOpening ,  
		0 AS OriginalOpening,	
		Case when Sum(ConvertedOpening) < 0 then -Sum(ConvertedOpening) else 0 end AS CreditConvertedOpening ,   
		Case when Sum(ConvertedOpening) > 0 then Sum(ConvertedOpening) else 0 end AS DebitConvertedOpening ,   
		Sum(ConvertedOpening) AS ConvertedOpening,
		sum(OriginalDebit) AS OriginalDebit,   
		sum(ConvertedDebit) AS ConvertedDebit,   
		sum(OriginalCredit) AS OriginalCredit,  
		Sum(ConvertedCredit) AS ConvertedCredit,  
		0 AS CreditOriginalClosing ,  
		0 AS DebitOriginalClosing ,  
		sum(OriginalClosing) AS OriginalClosing ,	
		Case when Sum(ConvertedClosing) <0 then -Sum(ConvertedClosing) else 0 end AS CreditConvertedClosing ,   
		Case when Sum(ConvertedClosing) >0 then Sum(ConvertedClosing) else 0 end AS DebitConvertedClosing ,   
		Sum(ConvertedClosing) AS ConvertedClosing ,	
		0 AS OriginalDebitYTD,  
		0 AS ConvertedDebitYTD,  
		0 AS OriginalCreditYTD ,  
		0 AS ConvertedCreditYTD 	
			
	 FROM AV7419_ST  AV7419
	 WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
		OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
		OR OriginalClosing <> 0 OR ConvertedClosing <> 0 
	 GROUP BY DivisionID, GroupID,  GroupName,  GroupID1,   GroupName1,   GroupID2,   GroupName2,
			ObjectID,   ObjectName, Address, VATNo,  AccountID,  AccountName,		
			S1, S2, S3, O01ID,  O02ID, O03ID, O04ID, O05ID, Tel, Fax, Email '

ELSE
	SET @sSQL = '
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
		AccountName, 
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
		Email,
		ObjectTypeID, ObjectTypeName,
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
		ConvertedCreditYTD 
	FROM AV7419_ST  AV7419 
	WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
		OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
		OR OriginalClosing <> 0 OR ConvertedClosing <> 0 '
		
--- Print @sSQL 
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7409_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    EXEC ('  CREATE VIEW AV7409_ST AS ' + @sSQL)
ELSE
    EXEC ('  ALTER VIEW AV7409_ST  AS ' + @sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

