IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7409_VNA]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7409_VNA]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In Tong hop no phai tra
-- <Param>
---- LƯU Ý: Khi trả thêm trường thì VUI LÒNG thêm luôn tại mode SieuThanh để không bị lỗi union
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
---- Modified on 08/04/2015 by Thanh Sơn: Bổ sung trường AccountNameE
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Hải Long on 01/06/2017: Lấy bổ sung trường ObjectTypeID, ObjectTypeName cho khách hàng HHP
---- Modified by Phương Thảo on 21/06/2017: Fix lỗi Union thiếu trường khi in báo cáo 2 DB của Sieu Thanh
---- Modified by Bảo Thy on 07/09/2017: Lấy giá trị nguyên tệ khi in tất cả loại tiền (AR7438)
---- Modified by Hoàng Trúc on 07/08/2019: Bổ sung trường Note từ AT1202
---- Modified by Hoàng Trúc on 29/08/2019: Sửa lỗi in báo cáo tổng hợp nợ phải trả
---- Modified on 10/05/2021 by Huỳnh Thử : [TienTien] -- Tách Store
---- Modified on 13/12/2021 by Văn Tài	 : Xử lý vấn đề NVARCHAR -> VARCHAR để không tràn chuỗi
---- Modified on 16/08/2022 by Nhật Thanh: Bổ sung thêm điều kiện DivisionID khi join bảng
---- Modified on 01/11/2022 by Nhựt Trường: [2022/10/IS/0205] - Bổ sung thêm điều kiện DivisionID dùng chung khi join bảng danh mục đối tượng (AT1202) và fix lỗi truyền thiếu biến @FromMonth lấy dữ liệu.
---- Modified on 22/03/2023 by Thành Sang: Bổ sung Groupby VoucherID cho khách SAVI
---- Modified on 29/03/2023 by Văn Tài	 : [2023/03/IS/0234] [VNA] Bổ sung lấy cột Ana05ID - MPT hợp đồng.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7409_VNA] 	
					@DivisionID AS VARCHAR(50) ,
					@FromMonth AS INT,
					@FromYear  AS INT,
					@ToMonth  AS INT,
					@ToYear  AS INT,
					@TypeD AS tINYINT,  	
					@FromDate AS DATETIME,
					@ToDate AS DATETIME,
					@CurrencyID AS VARCHAR(50),
					@FromAccountID AS VARCHAR(50),
					@ToAccountID AS VARCHAR(50),
					@FromObjectID AS VARCHAR(50),
					@ToObjectID AS VARCHAR(50),
					@Groupby AS TINYINT ,
					@StrDivisionID AS VARCHAR(4000) = '' ,
					@DatabaseName  AS VARCHAR(250) = ''  ,
					@ReportDate AS DATETIME = NULL
 AS

DECLARE @sSQL AS varchar(MAX),
		@sSQL1 AS VARCHAR(MAX),
		@sSQLUnion AS VARCHAR(Max),
		@GroupTypeID AS VARCHAR(50),
		@GroupID AS VARCHAR(50),
		@TypeDate AS VARCHAR(50),
		@TableName AS VARCHAR(50),
		@SqlObject AS VARCHAR(4000) ,
		@SqlGroupBy AS VARCHAR(4000),
		@sGROUPBY AS VARCHAR(4000),
		@CustomerName INT,
		@CustomerSAVI AS VARCHAR(200) = ''
		
		
--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK))

IF @CustomerName = 44 -- SAVI
	SET @CustomerSAVI = 'D3.VoucherID,'
	
BEGIN
    SET @GroupTypeID ='O01'

	SET @GroupID = (Case @GroupTypeID 
						When 'O01'  Then 'Object.O01ID' 		---- Nhom theo ma phan tich
						When 'O02'  Then 'Object.O02ID' 
						When 'O03'  Then 'Object.O03ID' 
						When 'O04'  Then 'Object.O04ID'
						When 'O05'  Then 'Object.O05D' 
					END)


	IF @GroupBy= 0    ---- Nhom theo doi tuong , tai khoan
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

	EXEC AP7401_VNA @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @StrDivisionID

	IF @TypeD = 1	---- Theo ngay hoa don
		SET @TypeDate = 'CONVERT(nvarchar(10),InvoiceDate,101)'
	ELSE IF @TypeD = 2 	---- Theo ngay chung tu
		SET @TypeDate = 'CONVERT(nvarchar(10),VoucherDate,101)'

	IF @TypeD <> 0   ----- In theo ngay
	BEGIN
		SET @sSQL = ' 
		SELECT	D3.DivisionID, ' + @SqlGroupBy + '	
				D3.ObjectID,	ObjectName,	Object.Address,	Object.VATNo,
				D3.AccountID,	AccountName,
				D3.CurrencyID,
				Object.S1,	Object.S2,	Object.S3,
				Object.O01ID,Object.O02ID,Object.O03ID,	Object.O04ID,Object.O05ID,		
				Object.Tel,	Object.Fax,	Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' +  convert(varchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalOpening,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' +  convert(varchar(10), @FromDate, 101) + ''' OR TransactiontypeID = ''T00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedOpening,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(varchar(10), @FromDate, 101) + '''  
						   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(varchar(10), @FromDate, 101) + '''  
						   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebit,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(varchar(10), @FromDate, 101) + '''  
						   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + convert(varchar(10), @FromDate, 101) + ''' 
						   and CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <>''T00'') AND RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCredit,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
				SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' OR TransactiontypeID = ''SD'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedClosing,
				SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100 + '+STR(@FromMonth)+') AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
				SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100 + '+STR(@FromMonth)+') AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
				SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100 + '+STR(@FromMonth)+') AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
				SUM (CASE WHEN (TranMonth + TranYear * 100 > ' + str(@FromYear) + ' * 100 + '+STR(@FromMonth)+') AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(varchar(10), @ToDate, 101) + ''' AND (IsNull(TransactiontypeID, '''') <> ''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCreditYTD, Object.Note,
				D3.Ana05ID,
				D3.Ana05Name
		'
		SET @sSQL1 = '
		FROM	AV7401 D3 
		INNER JOIN AT1202 Object  on Object.DivisionID IN ('''+@DivisionID+''',''@@@'') and Object.ObjectID = D3.ObjectID
		LEFT JOIN AT1015 on AT1015.DivisionID in (''@@@'',Object.DivisionID) and AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID = ''' + @GroupTypeID + '''
		INNER JOIN AT1005 AS Account on Account.DivisionID in (''@@@'',D3.DivisionID) and Account.AccountID = D3.AccountID
		LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.DivisionID in (''@@@'',Object.DivisionID) and AT1201.ObjectTypeID = Object.ObjectTypeID
	
		GROUP BY D3.DivisionID, D3.ObjectID, ' + @CustomerSAVI + '
				D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, Object.O01ID, 
				Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
				Object.Tel, Object.Fax, Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
				Object.Address, Object.VATNo, AccountName, D3.CurrencyID, AT1015.AnaName,Object.Note,
				D3.Ana05ID,
				D3.Ana05Name,
				' 
	END
	ELSE
	BEGIN
		SET @sSQL = '
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
				Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
  				SUM (CASE WHEN (TranMonth + 100*TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END)  AS OriginalOpening,
  				SUM (CASE WHEN (TranMonth + 100*TranYear < '+str(@FromMonth)+' + 100*'+str(@FromYear)+') OR TransactiontypeID=''T00'' THEN SignConvertedAmount ELSE 0 END) AS ConvertedOpening ,
  				SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebit ,
  				SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebit,
  				SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCredit,
 				SUM (CASE WHEN (TranMonth + 100*TranYear >= '+str(@FromMonth)+' + 100*'+str(@FromYear)+') AND (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCredit,
 				SUM (CASE WHEN (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+')  OR TransactiontypeID=''T00'' THEN SignOriginalAmount ELSE 0 END) AS OriginalClosing,
 				SUM (CASE WHEN (TranMonth + 100*TranYear <= '+str(@ToMonth)+' + 100*'+str(@ToYear)+') OR TransactiontypeID=''T00''  THEN SignConvertedAmount ELSE 0 END) AS ConvertedClosing,
 				SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100 + '+STR(@FromMonth)+')  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN OriginalAmount ELSE 0 END) AS OriginalDebitYTD,
 				SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100 + '+STR(@FromMonth)+')  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''00'' THEN ConvertedAmount ELSE 0 END) AS ConvertedDebitYTD,
 				SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100 + '+STR(@FromMonth)+')  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN OriginalAmount ELSE 0 END) AS OriginalCreditYTD,
 				SUM (CASE WHEN (TranMonth + TranYear*100 > '+str(@FromYear)+'*100 + '+STR(@FromMonth)+')  AND (TranMonth +TranYear *100 < ='+str(@ToMonth)+' + '+str(@ToYear)+'*100)  AND (IsNull(TransactiontypeID,'''')<>''T00'' ) AND  RPTransactionType= ''01'' THEN ConvertedAmount ELSE 0 END) AS ConvertedCreditYTD, Object.Note,
				D3.Ana05ID,
				D3.Ana05Name
		'
		SET @sSQL1 = '
		FROM AV7401 D3 	
		INNER JOIN AT1202 Object  on Object.DivisionID IN ('''+@DivisionID+''',''@@@'') and Object.ObjectID = D3.ObjectID
		LEFT JOIN AT1015 on	AT1015.DivisionID in (''@@@'',Object.DivisionID) and AT1015.AnaID = Object.O01ID and AT1015.AnaTypeID =''' + @GroupTypeID + '''
		INNER JOIN AT1005 Account on Account.DivisionID in (''@@@'',D3.DivisionID) and Account.AccountID = D3.AccountID
		LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.DivisionID in (''@@@'',Object.DivisionID) and AT1201.ObjectTypeID = Object.ObjectTypeID	

		GROUP BY	D3.DivisionID, D3.ObjectID, ' + @CustomerSAVI + '
					D3.AccountID, ObjectName,  Object.S1, Object.S2,  Object.S3, 
					Object.O01ID,  Object.O02ID, Object.O03ID, Object.O04ID, Object.O05ID,
					Object.Tel, Object.Fax, Object.Email, AT1201.ObjectTypeID, AT1201.ObjectTypeName,
					Address, VATNo, AccountName, D3.CurrencyID,  AT1015.AnaName,Object.Note,
					D3.Ana05ID,
					D3.Ana05Name,
					' 
	END

	PRINT @sSQL
	PRINT(@sSQL1)
	PRINT(@GroupID)

	IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7419]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		 EXEC ('  CREATE VIEW AV7419 AS ' + @sSQL + @sSQL1 + @GroupID)
	ELSE
		 EXEC ('  ALTER VIEW AV7419  AS ' + @sSQL + @sSQL1 + @GroupID)



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
			Note,
			AV7419.Ana05ID,
			AV7419.Ana05Name
		 FROM AV7419 
		 WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
			OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
			OR OriginalClosing <> 0 OR ConvertedClosing <> 0 
		 GROUP BY DivisionID, GroupID,  GroupName,  GroupID1,   GroupName1,   GroupID2,   GroupName2,
				ObjectID,   ObjectName, Address, VATNo,  AccountID,  AccountName,		
				S1, S2, S3, O01ID,  O02ID, O03ID, O04ID, O05ID, Tel, Fax, Email, ObjectTypeID, ObjectTypeName,Note,
				AV7419.Ana05ID,
				AV7419.Ana05Name'

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
			ConvertedCreditYTD, Note,
			AV7419.Ana05ID,
			AV7419.Ana05Name
		FROM AV7419 
		WHERE OriginalOpening <> 0 OR ConvertedOpening <> 0 OR OriginalDebit <> 0 
			OR ConvertedDebit <> 0 OR OriginalCredit <> 0 OR ConvertedCredit <> 0 
			OR OriginalClosing <> 0 OR ConvertedClosing <> 0 '
		
	Print @sSQL 	
			
	IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7409]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		EXEC ('  CREATE VIEW AV7409 AS ' + @sSQL )
	ELSE
		EXEC ('  ALTER VIEW AV7409  AS ' + @sSQL )
	
			
END
			

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

