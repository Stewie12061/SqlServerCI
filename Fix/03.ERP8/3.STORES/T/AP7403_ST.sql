IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7403_ST]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7403_ST]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Tong hop no phai thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-----Created by Nguyen Van Nhan, Date 22.08.2003
-----
---- Last Edit by Van Nhan, Date 25.06.2004
---- Last Edit by Nguyen Quoc Huy, Date 25.07.2007
---- Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
---- Edited by: [AS] [Bảo Quỳnh] [15/11/2011] : Bổ sung các field name Phân loại 1,2,3 của đối tượng, 5 field name của mã phân tích đối tượng
---- Modified on 06/12/2011 by Le Thi Thu Hien : Sua ngay CONVERT(varchar(10),@TypeDate,101)
---- Modified on 16/01/2012 by Le Thi Thu Hien : CONVERT lai ngay
---- Modified on 22/02/2012 by Le Thi Thu Hien : Sua dieu kien WHERE
---- Modified on 13/04/2012 by Le Thi Thu Hien : Sửa OriginalAmount thành SignOriginalAmount
---- Modified on 28/12/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 14/11/2014 by Mai Duyen : Bổ sung thêm DatabaseName (tinh năng In báo cao tong hop no phai thu 2 Database, KH SIEUTHANH)
---- Modified on 11/11/2015 by Phuong Thao : Fix lỗi khi in 2 DB : Trả thêm trường AccountNameE (tinh năng In báo cao tong hop no phai thu 2 Database, KH SIEUTHANH)
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung with (nolock) và chỉnh sửa danh mục dùng chung
---- Modified on 11/11/2015 by Phuong Thao : Fix lỗi khi in 2 DB : Thêm dữ liệu Loại đối tượng (tinh năng In báo cao tong hop no phai thu 2 Database, KH SIEUTHANH)
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7403_ST]	 	
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
					@DatabaseName as nvarchar(250) =''


 AS

DECLARE 
	@sSQL AS Nvarchar(max),
	@sSQL1 AS nvarchar(MAX),
	@sSQL2 AS nvarchar(MAX),
	@GroupTypeID AS nvarchar(50),		
	@GroupID AS nvarchar(50),
	@TypeDate AS nvarchar(50),
    @TableName AS nvarchar(50),
    @SqlObject AS nvarchar(4000),
    @SqlGroupBy AS nvarchar(4000),
    @StrDivisionID_New AS NVARCHAR(4000),
	@TableDBO as nvarchar(250)

If @DatabaseName  ='' 
	 Set @TableDBO=''
Else
	Set @TableDBO = '[' +  @DatabaseName + '].DBO.'
	
	
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

Exec AP7402_ST  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID,  @ToObjectID, @StrDivisionID ,@DatabaseName

IF @TypeD = 1	---- Theo ngay Hoa don
	SET @TypeDate = 'InvoiceDate'
ELSE IF @TypeD = 2 	---- Theo ngay hach toan
	SET @TypeDate = 'VoucherDate'

if @TypeD <> 0   ----- In theo ngay
Begin
SET @sSQL = ' 
SELECT	D3.DivisionID, ' + @SqlGroupBy + '	
		D3.ObjectID,  ObjectName, Object.Address, Object.VATNo, 
		D3.AccountID, AccountName, AccountNameE,
		D3.CurrencyID,
		Object.S1, Object.S2,  Object.S3, 
		OS1.SName AS S1Name, OS2.SName AS S2Name, OS3.SName AS S3Name, 
		Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
		O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
		Object.Tel, Object.Fax, Object.Email,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END)  AS DebitOriginalOpening,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS DebitConvertedOpening,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalOpening,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <  ''' + convert(nvarchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS CreditConvertedOpening,
        SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' AND
					   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebit,
        SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + ''' AND
					   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedDebit,
        SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  AND
					   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCredit,
		SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(nvarchar(10), @FromDate, 101) + '''  AND
					   CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS ConvertedCredit,'
SET @sSQL1 = '					   
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS DebitConvertedClosing,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS CreditConvertedClosing,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebitYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCreditYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + '*100) AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(nvarchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS ConvertedCreditYTD '
SET @sSQL2 = ' 		
	FROM AV7402_ST D3 
		INNER JOIN '+ @TableDBO +'AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
		LEFT JOIN '+ @TableDBO +'AT1015 O1 WITH (NOLOCK) on O1.AnaID = Object.O01ID AND O1.AnaTypeID = ''O01''
		LEFT JOIN '+ @TableDBO +'AT1015 O2 WITH (NOLOCK) on O2.AnaID = Object.O02ID AND O2.AnaTypeID = ''O02''
		LEFT JOIN '+ @TableDBO +'AT1015 O3 WITH (NOLOCK) on O3.AnaID = Object.O03ID AND O3.AnaTypeID = ''O03''
		LEFT JOIN '+ @TableDBO +'AT1015 O4 WITH (NOLOCK) on O4.AnaID = Object.O04ID AND O4.AnaTypeID = ''O04''
		LEFT JOIN '+ @TableDBO +'AT1015 O5 WITH (NOLOCK) on O5.AnaID = Object.O05ID AND O5.AnaTypeID = ''O05''
		LEFT JOIN '+ @TableDBO +'AT1207 OS1 WITH (NOLOCK) on OS1.S = Object.S1 AND OS1.STypeID = ''O01''
		LEFT JOIN '+ @TableDBO +'AT1207 OS2 WITH (NOLOCK) on OS2.S = Object.S2 AND OS2.STypeID = ''O02''
		LEFT JOIN '+ @TableDBO +'AT1207 OS3 WITH (NOLOCK) on OS3.S = Object.S3 AND OS3.STypeID = ''O03''
		INNER JOIN '+ @TableDBO +'AT1005 AS Account WITH (NOLOCK) on Account.AccountID = D3.AccountID 
	GROUP BY	D3.DivisionID, D3.ObjectID,  D3.AccountID, ObjectName,  Object.Address, Object.VATNo, Object.Tel, Object.Fax, Object.Email,
				AccountName, AccountNameE, D3.CurrencyID, 
				Object.S1, Object.S2,  Object.S3, 
				OS1.SName, OS2.SName, OS3.SName, 
				Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID, 
				O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName '
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
		AccountName,
		AccountNameE,
		D3.CurrencyID,
		Object.S1, Object.S2, Object.S3, 
		OS1.SName AS S1Name, OS2.SName AS S2Name, OS3.SName AS S3Name, 
		Object.O01ID, Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID, 
		O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
		Object.Tel, Object.Fax, Object.Email,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END)  AS DebitOriginalOpening,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS DebitConvertedOpening,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END)  AS CreditOriginalOpening,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear < ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS CreditConvertedOpening,
		SUM (CASE WHEN (TranMonth + 100 * TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebit,
		SUM (CASE WHEN (TranMonth + 100 * TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedDebit,
		SUM (CASE WHEN (TranMonth + 100 * TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN - SignOriginalAmount ELSE 0 END) AS OriginalCredit,
		SUM (CASE WHEN (TranMonth + 100 * TranYear >= ' + str(@FromMonth) + ' + 100 * ' + str(@FromYear) + ') AND (TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN - SignConvertedAmount ELSE 0 END) AS ConvertedCredit,'
SET @sSQL1 = '
		SUM (CASE WHEN ((TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS DebitConvertedClosing,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing,
		SUM (CASE WHEN ((TranMonth + 100 * TranYear <= ' + str(@ToMonth) + ' + 100 * ' + str(@ToYear) + ') OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS CreditConvertedClosing,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (TranMonth + TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalDebitYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (TranMonth + TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (TranMonth + TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCreditYTD,
		SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100) AND (TranMonth + TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND  RPTransactionType = ''01'' THEN -SignConvertedAmount ELSE 0 END) AS ConvertedCreditYTD '
SET @sSQL2 = ' 	
	FROM AV7402_ST D3 	
		INNER JOIN '+ @TableDBO +'AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = D3.ObjectID
		LEFT JOIN '+ @TableDBO +'AT1015 O1 WITH (NOLOCK) on O1.AnaID = Object.O01ID AND O1.AnaTypeID = ''O01''
		LEFT JOIN '+ @TableDBO +'AT1015 O2 WITH (NOLOCK) on O2.AnaID = Object.O02ID AND O2.AnaTypeID = ''O02''
		LEFT JOIN '+ @TableDBO +'AT1015 O3 WITH (NOLOCK) on O3.AnaID = Object.O03ID AND O3.AnaTypeID = ''O03''
		LEFT JOIN '+ @TableDBO +'AT1015 O4 WITH (NOLOCK) on O4.AnaID = Object.O04ID AND O4.AnaTypeID = ''O04''
		LEFT JOIN '+ @TableDBO +'AT1015 O5 WITH (NOLOCK) on O5.AnaID = Object.O05ID AND O5.AnaTypeID = ''O05''
		LEFT JOIN '+ @TableDBO +'AT1207 OS1 WITH (NOLOCK) on OS1.S = Object.S1 AND OS1.STypeID = ''O01''
		LEFT JOIN '+ @TableDBO +'AT1207 OS2 WITH (NOLOCK) on OS2.S = Object.S2 AND OS2.STypeID = ''O02''
		LEFT JOIN '+ @TableDBO +'AT1207 OS3 WITH (NOLOCK) on OS3.S = Object.S3 AND OS3.STypeID = ''O03''
		INNER JOIN '+ @TableDBO +'AT1005 Account WITH (NOLOCK) on Account.AccountID = D3.AccountID 
	
GROUP BY  D3.DivisionID, D3.ObjectID, D3.AccountID, ObjectName,  Object.Address, Object.VATNo, Object.Tel, Object.Fax, Object.Email,
		AccountName, AccountNameE, D3.CurrencyID, 
		Object.S1, Object.S2,  Object.S3, 
		OS1.SName, OS2.SName, OS3.SName, 
		Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,  
		O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName '
End

--PRINT(@sSQL)
--PRINT(@sSQL1)
--PRINT(@sSQL2)
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7413_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
     EXEC ('  CREATE VIEW AV7413_ST AS ' + @sSQL + @sSQL1 + @sSQL2)
ELSE
     EXEC ('  ALTER VIEW AV7413_ST  AS ' + @sSQL + @sSQL1 + @sSQL2)



--Print @sSQL


---- Bo phan so 0 
IF @CurrencyID <> '%'
	Set @sSQL =' 
	SELECT AV7413.DivisionID, 
    	AV7413.GroupID,
		AV7413.GroupName,
		AV7413.GroupID1,
		AV7413.GroupName1,
		AV7413.GroupID2,
		AV7413.GroupName2,
		AV7413.ObjectID,
		AV7413.ObjectName,
		AV7413.Address,
		AV7413.VATNo,
		AV7413.AccountID,
		AV7413.AccountName,
		AV7413.AccountNameE,
		AV7413.CurrencyID,		 
		AV7413.S1, AV7413.S2, AV7413.S3, 
		AV7413.S1Name, AV7413.S2Name, AV7413.S3Name, 
		AV7413.O01ID, AV7413.O02ID, AV7413.O03ID, AV7413.O04ID, AV7413.O05ID,
		AV7413.O01Name, AV7413.O02Name, AV7413.O03Name, AV7413.O04Name, AV7413.O05Name, 
		AV7413.Tel, AV7413.Fax, AV7413.Email,
		CASE WHEN AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening < 0 THEN AV7413.CreditOriginalOpening - AV7413.DebitOriginalOpening ELSE 0 END AS CreditOriginalOpening,
		CASE WHEN AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening > 0 THEN AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening ELSE 0 END AS DebitOriginalOpening,
		AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening AS OriginalOpening,
		CASE WHEN AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening < 0 THEN AV7413.CreditConvertedOpening - AV7413.DebitConvertedOpening ELSE 0 END AS CreditConvertedOpening,
		CASE WHEN AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening > 0 THEN AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening ELSE 0 END AS DebitConvertedOpening,
 		AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening AS ConvertedOpening,
		AV7413.OriginalDebit,
		AV7413.ConvertedDebit,
		AV7413.OriginalCredit,
		AV7413.ConvertedCredit,
		CASE WHEN AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing < 0 THEN AV7413.CreditOriginalClosing - AV7413.DebitOriginalClosing ELSE 0 END AS CreditOriginalClosing,
		CASE WHEN AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing > 0 THEN AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing ELSE 0 END AS DebitOriginalClosing,
		AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing AS OriginalClosing,   
		CASE WHEN AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing < 0 THEN AV7413.CreditConvertedClosing - AV7413.DebitConvertedClosing ELSE 0 END AS CreditConvertedClosing,
		CASE WHEN AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing > 0 THEN AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing ELSE 0 END AS DebitConvertedClosing,
		AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing AS ConvertedClosing,
		AV7413.OriginalDebitYTD,
		AV7413.ConvertedDebitYTD,
		AV7413.OriginalCreditYTD,
		AV7413.ConvertedCreditYTD,
		AT1201.ObjectTypeID, AT1201.ObjectTypeName   
	FROM AV7413_ST AV7413
	INNER JOIN AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = AV7413.ObjectID
	LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID 
	WHERE AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening <> 0 
		OR AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening <> 0 OR OriginalDebit <> 0 
		OR AV7413.ConvertedDebit <> 0 OR AV7413.OriginalCredit <> 0 OR AV7413.ConvertedCredit <> 0 
		OR AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing <> 0 
		OR AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing <> 0 '

Else
	Set @sSQL = ' 
	SELECT AV7413.DivisionID,
    	AV7413.GroupID,
		AV7413.GroupName,
		AV7413.GroupID1,
		AV7413.GroupName1,
		AV7413.GroupID2,
		AV7413.GroupName2,
		AV7413.ObjectID,
		AV7413.ObjectName,
		AV7413.Address,
		AV7413.VATNo,
		AV7413.AccountID,
		AV7413.AccountName,
		AV7413.AccountNameE,
		''%'' AS CurrencyID,  	
		AV7413.S1, AV7413.S2, AV7413.S3, 
		AV7413.S1Name, AV7413.S2Name, AV7413.S3Name, 
		AV7413.O01ID, AV7413.O02ID, AV7413.O03ID, AV7413.O04ID, AV7413.O05ID,
		AV7413.O01Name, AV7413.O02Name, AV7413.O03Name, AV7413.O04Name, AV7413.O05Name, 
		AV7413.Tel, AV7413.Fax, AV7413.Email,
		0 AS CreditOriginalOpening,
 		0 AS DebitOriginalOpening,
		0 AS OriginalOpening,
 		Case when Sum(AV7413.DebitConvertedOpening)-SUM(AV7413.CreditConvertedOpening) < 0 then  - Sum(AV7413.DebitConvertedOpening) + SUM(AV7413.CreditConvertedOpening) else 0 end AS CreditConvertedOpening,
		Case when Sum(AV7413.DebitConvertedOpening)-SUM(AV7413.CreditConvertedOpening) > 0 then  Sum(AV7413.DebitConvertedOpening)-SUM(AV7413.CreditConvertedOpening) else 0 end AS DebitConvertedOpening,
		Sum(DebitConvertedOpening)-SUM(CreditConvertedOpening) AS ConvertedOpening,
		sum(AV7413.OriginalDebit) AS OriginalDebit,
		sum(AV7413.ConvertedDebit) AS ConvertedDebit,
		sum(AV7413.OriginalCredit) AS OriginalCredit,
		Sum(AV7413.ConvertedCredit) AS ConvertedCredit,
		0 AS CreditOriginalClosing,
		0 AS DebitOriginalClosing,
		sum(AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing) AS OriginalClosing,
		Case when Sum(AV7413.DebitConvertedClosing)-SUM(AV7413.CreditConvertedClosing) < 0 then  - Sum(AV7413.DebitConvertedClosing) + SUM(AV7413.CreditConvertedClosing) else 0 end AS CreditConvertedClosing,
		Case when Sum(AV7413.DebitConvertedClosing)-SUM(AV7413.CreditConvertedClosing) > 0 then  Sum(AV7413.DebitConvertedClosing)-SUM(AV7413.CreditConvertedClosing) else 0 end AS DebitConvertedClosing,
		Sum(AV7413.DebitConvertedClosing)-SUM(AV7413.CreditConvertedClosing) AS ConvertedClosing,
		0 AS OriginalDebitYTD,
		0 AS ConvertedDebitYTD,
		0 AS OriginalCreditYTD,
		0 AS ConvertedCreditYTD,
		AT1201.ObjectTypeID, AT1201.ObjectTypeName
	FROM AV7413_ST AV7413
	INNER JOIN AT1202 Object WITH (NOLOCK) on Object.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Object.ObjectID = AV7413.ObjectID
	LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = Object.ObjectTypeID 
	WHERE AV7413.DebitOriginalOpening - AV7413.CreditOriginalOpening <> 0  
		OR AV7413.DebitConvertedOpening - AV7413.CreditConvertedOpening <> 0 OR AV7413.OriginalDebit <> 0 
		OR AV7413.ConvertedDebit <> 0 OR AV7413.OriginalCredit <> 0 OR AV7413.ConvertedCredit <> 0 
		OR AV7413.DebitOriginalClosing - AV7413.CreditOriginalClosing <> 0 
		OR AV7413.DebitConvertedClosing - AV7413.CreditConvertedClosing <> 0
	GROUP BY AV7413.DivisionID, AV7413.GroupID, AV7413.GroupName, AV7413.GroupID1, AV7413.GroupName1, AV7413.GroupID2, AV7413.GroupName2,
		AV7413.ObjectID, AV7413.ObjectName, AV7413.Address, AV7413.VATNo, AV7413.AccountID, AV7413.AccountName, AV7413.AccountNameE,		
		AV7413.S1, AV7413.S2, AV7413.S3, 
		AV7413.S1Name, AV7413.S2Name, AV7413.S3Name, 
		AV7413.O01ID, AV7413.O02ID, AV7413.O03ID, AV7413.O04ID, AV7413.O05ID,
		AV7413.O01Name, AV7413.O02Name, AV7413.O03Name, AV7413.O04Name, AV7413.O05Name, 
		AV7413.Tel, AV7413.Fax, AV7413.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName '

--print @sSQL

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7403_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
    EXEC ('  CREATE VIEW AV7403_ST AS ' + @sSQL)
ELSE
    EXEC ('  ALTER VIEW AV7403_ST  AS ' + @sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

