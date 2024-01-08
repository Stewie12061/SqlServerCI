IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7405_ST]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7405_ST]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In chi tiet no phai thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/08/2003 by Nguyen Van Nhan
----
----- Edited by Nguyen Thi Ngoc Minh, Date 27/04/2004
----- Purpose: Cho phep chon loai ngay len bao cao theo ngay  va theo ky
----- Last Edited by Van Nhan, Date 15/09/2004
----- Last Edited by Quoc Huy, Date 26/07/2006
----- Last Edited by Thuy Tuyen, Date 24/08/2007 -- Lay Ten Tai Khoan
----- Edited by Dang Le Bao Quynh, Date 04/07/2008
----- Purpose: Bo sung view phuc in chi tiet phai thu theo ma phan tich
---- Modified on 13/01/2011 by Le Thi Thu Hien : Sua in theo ngay
---- Modified on 15/03/2012 by Le Thi Thu Hien : Bổ sung trường hợp in không có phát sinh thì không lên đầu kỳ
---- Modified on 25/10/2012 by Bao Anh : Bổ sung TableID, Status
---- Modified on 05/03/2013 by Khanh Van : In tu tai khoan den tai khoan cho Sieu Thanh
---- Modified on 27/05/2013 by Lê Thị Thu Hiền : Bổ sung thêm Ana06ID --> Ana10ID
---- Modified by on 15/10/2014 by Huỳnh Tấn Phú : Bổ sung điều kiện lọc theo 10 mã phân tích. 0022751: [VG] In số dư đầu kỳ lên sai dẫn đến số dư cuối kỳ sai. 
---- Modified by on 31/10/2014 by Mai Duyen : Sua loi khong in duoc bao cao
---- Modified on 12/11/2014 by Mai Duyen : Bổ sung thêm DatabaseName (tinh năng In báo cao chi tiet no phai thu 2 Database, KH SIEUTHANH)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 19/06/2017: Trả thêm 10 trường tên mã phân tích, tên TK tiếng Anh
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7405_ST]
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
					@FromObjectID  AS nvarchar(50),
					@ToObjectID  AS nvarchar(50),
					@SqlFind AS NVARCHAR(500),
					@DatabaseName as varchar(250)=''
	
 ASDECLARE @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@SQLwhere AS nvarchar(MAX),
		@SQLwhereAna AS nvarchar(MAX),
		@TypeDate AS nvarchar(20),
		@SQLObject AS nvarchar(MAX),
		@sqlGroup AS nvarchar(MAX),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@TableDBO as nvarchar(250)
		
		
If @DatabaseName  ='' 
	 Set @TableDBO=''
Else
	Set @TableDBO = '[' +  @DatabaseName + '].DBO.'
	
		

IF @TypeD = 1   --- Ngay HT
	SET @TypeDate ='InvoiceDate'
ELSE IF @TypeD=2  --- Nga HD
	SET @TypeDate = 'VoucherDate'
ELSE IF @TypeD=3   --Ngay Dao han
	SET @TypeDate = 'DueDate'

SET @FromPeriod = (@FromMonth + @FromYear * 100)	
SET @ToPeriod = (@ToMonth + @ToYear * 100)	

IF @TypeD in (1, 2, 3)   -- Theo ngay
	SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),D3.' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' + CONVERT(varchar(10), @FromDate, 101) + ''' AND ''' + CONVERT(varchar(10), @ToDate, 101) + ''') '
ELSE    ---Theo ky
	SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + str(@FromPeriod) + ' AND '+ str(@ToPeriod) + ')'
	
------ Loc ra cac phan tu
EXEC AP7404_ST  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere ,@DatabaseName

------- Xac dinh so du co cac doi tuong
EXEC AP7414_ST @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,@SqlFind,@DatabaseName

IF @TypeD = 4 ---  Tinh tu ky den ky
  BEGIN	
	
	SET @SQLwhere = '
		WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
	and (ISNULL(AV7404.AccountID, AV7414.AccountID) between ''' + @FromAccountID+ ''' AND ''' + @ToAccountID + ''')'
	SET @SQLwhereAna ='
		WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
	and (ISNULL(AV7404.AccountID, AV7424.AccountID) between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
			
	IF @CurrencyID <> '%'
		Begin
			SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) like ''' + @CurrencyID + ''' ' 
			SET @SQLwhereAna = @SQLwhereAna + ' AND  ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) like  ''' + @CurrencyID + ''' ' 
		End
	
   END
ELSE    ---- Xac dinh theo Ngay
  BEGIN
	
	SET @SQLwhere = '
		WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
		 AND AV7404.DivisionId = ''' + @DivisionID + '''	AND (ISNULL(AV7404.AccountID, AV7414.AccountID) between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') '
	SET @SQLwhereAna = '
		WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
		 AND AV7404.DivisionID = ''' + @DivisionID + '''	AND (ISNULL(AV7404.AccountID, AV7424.AccountID) between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
	
	IF @CurrencyID <> '%'
		Begin
			SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) like ''' + @CurrencyID + ''' ' 
			SET @SQLwhereAna = @SQLwhereAna + ' AND ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) like ''' + @CurrencyID + ''' ' 
		End
  END	
---In khong co ma phan tich 1
	SET @sSQL = '
		SELECT (ISNULL(AV7404.ObjectID, AV7414.ObjectID) + ISNULL(AV7404.AccountID, AV7414.AccountID)) AS GroupID,
			BatchID,
			VoucherID,
			TableID, Status,
			AV7404.DivisionID,
			TranMonth,
			TranYear, 
			Cast(ISNULL(AV7404.AccountID, AV7414.AccountID) AS char(20)) + 
			cast(ISNULL(AV7404.ObjectID, AV7414.ObjectID)  AS char(20)) + 
			cast(ISNULL(AV7404.CurrencyID,AV7414.CurrencyID) AS char(20)) + 
			cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
			Year(VoucherDate) * 10000 AS char(8)) + 
			cast(VoucherID AS char(20)) + 
			(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
			RPTransactionType,
			TransactionTypeID,
			ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS ObjectID,  
			ISNULL(AT1202.ObjectName,AV7414.ObjectName) AS ObjectName,
			AT1202.Address, AT1202.VATNo,
			DebitAccountID, CreditAccountID, 
			ISNULL(AV7404.AccountID, AV7414.AccountID) AS AccountID,
			ISNULL(AT1005.AccountName,AV7414.AccountName) AS AccountName,
			VoucherTypeID,
			VoucherNo,
			VoucherDate,
			InvoiceNo,			InvoiceDate,			Serial,			VDescription, 
			ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,
			TDescription,
			AV7404.Ana01ID,	AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
			AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
			ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CurrencyID,
			ExchangeRate,
			AV7404.CreateDate,
			Sum(Case When RPTransactionType = ''00'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS DebitOriginalAmount,
			Sum(Case When RPTransactionType = ''01'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
			Sum(Case When RPTransactionType = ''00'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
			Sum(Case When RPTransactionType = ''01'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
			ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
			ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
			sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
			sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
			cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
			cast(0 as decimal(28,8)) AS ClosingConvertedAmount,
			Duedate	
				
	FROM	AV7404_ST as  AV7404
	LEFT JOIN ' + @TableDBO +  'AT1202 as AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7404.ObjectID
	FULL JOIN AV7414_ST as AV7414 on AV7414.ObjectID = AV7404.ObjectID AND AV7414.AccountID = AV7404.AccountID			
	LEFT JOIN ' + @TableDBO +  'AT1005 as AT1005 on AT1005.AccountID = AV7404.AccountID ' + @SQLwhere + '
	
	GROUP BY BatchID, VoucherID, TableID, Status, AV7404.DivisionID, TranMonth, TranYear, 
			RPTransactionType, TransactionTypeID, AV7404.ObjectID, AV7414.ObjectID,
			DebitAccountID, CreditAccountID, AV7404.AccountID, AV7414.AccountID, 
			VoucherTypeID, VoucherNo, VoucherDate,AV7414.OpeningOriginalAmount, AV7414.OpeningConvertedAmount,
			InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
			AV7404.Ana01ID,	AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
			AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
			AV7404.CreateDate,
			AV7404.CurrencyID, AV7414.CurrencyID, ExchangeRate, AT1202.ObjectName, 
			AT1202.Address, AT1202.VATNo, 
			AV7414.ObjectName, AT1005.AccountName, AV7414.AccountName, Duedate '
SET @sSQL1 = '
	UNION ALL
	SELECT (ISNULL( AV7414.ObjectID, '''') + ISNULL( AV7414.AccountID, '''')) AS GroupID,
			NULL AS BatchID,
			NULL AS VoucherID,
			NULL as TableID,
			NULL as Status,
			AV7414.DivisionID,
			NULL AS TranMonth,
			NULL AS TranYear, 
			Cast(ISNULL(AV7414.AccountID , '''') AS char(20)) + 
			cast(ISNULL(AV7414.ObjectID, '''')  AS char(20)) + 
			cast(ISNULL(AV7414.CurrencyID, '''') AS char(20))  AS Orders,
			NULL AS RPTransactionType,
			NULL AS TransactionTypeID,
			ISNULL( AV7414.ObjectID,'''') AS ObjectID,  
			ISNULL(AV7414.ObjectName , '''') AS ObjectName,
			AT1202.Address, AT1202.VATNo,
			NULL AS DebitAccountID, 
			NULL AS CreditAccountID, 
			ISNULL(AV7414.AccountID, '''') AS AccountID,
			ISNULL(AV7414.AccountName, '''' ) AS AccountName,
			NULL AS VoucherTypeID,
			NULL AS VoucherNo,
			CONVERT(DATETIME, NULL) AS VoucherDate,
			NULL AS InvoiceNo,
			CONVERT(DATETIME, NULL) AS InvoiceDate,
			NULL AS Serial,
			NULL AS VDescription, 
			NULL AS BDescription,
			NULL AS TDescription,
			Cast (AV7414.Ana01ID as nvarchar(50)),
			Cast (AV7414.Ana02ID as nvarchar(50)),
			Cast (AV7414.Ana03ID as nvarchar(50)),
			Cast (AV7414.Ana04ID as nvarchar(50)),
			Cast (AV7414.Ana05ID as nvarchar(50)),
			Cast (AV7414.Ana06ID as nvarchar(50)),
			Cast (AV7414.Ana07ID as nvarchar(50)),
			Cast (AV7414.Ana08ID as nvarchar(50)),
			Cast (AV7414.Ana09ID as nvarchar(50)),
			Cast (AV7414.Ana10ID as nvarchar(50)),
			
			AV7414.CurrencyID AS CurrencyID,
			0 AS ExchangeRate,
			CONVERT(DATETIME, NULL)CreateDate,
			0 AS DebitOriginalAmount,
			0 AS CreditOriginalAmount,
			0 AS DebitConvertedAmount,
			0 AS CreditConvertedAmount,
			ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
			ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
			0 AS SignConvertedAmount,
			0 AS SignOriginalAmount,
			cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
			cast(0 as decimal(28,8)) AS ClosingConvertedAmount,
			CONVERT(DATETIME, NULL) AS Duedate	
				
	FROM	AV7414_ST  as AV7414
	LEFT JOIN ' + @TableDBO + 'AT1202 as AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7414.ObjectID
	WHERE	AV7414.ObjectID + AV7414.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
	
	'
	--print @sSQL
	--print @sSQL1
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7415_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
     EXEC ('  CREATE VIEW AV7415_ST AS ' + @sSQL + @sSQL1)
ELSE
     EXEC ('  ALTER VIEW AV7415_ST  AS ' + @sSQL + @sSQL1)

-----In co ma phan tich 1
--	SET @sSQL='
--	SELECT 	(ISNULL(AV7404.ObjectID, AV7424.ObjectID) + ISNULL(AV7404.AccountID, AV7424.AccountID) ) AS GroupID,
--			BatchID,
--			VoucherID,
--			TableID,
--			Status,
--			AV7404.DivisionID,
--			TranMonth,
--			TranYear, 
--			Cast(ISNULL(AV7404.AccountID, AV7424.AccountID) AS char(20)) + 
--			cast(ISNULL(AV7404.ObjectID, AV7424.ObjectID)  AS char(20)) + 
--			cast(ISNULL(AV7404.CurrencyID,AV7424.CurrencyID) AS char(20)) + 
--			cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
--			Year(VoucherDate)*10000 AS char(8)) + 
--			cast(VoucherID AS char(20)) + 
--			(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
--			RPTransactionType,
--			TransactionTypeID,
--			ISNULL(AV7404.ObjectID, AV7424.ObjectID) AS ObjectID,  
--			ISNULL(AT1202.ObjectName, AV7424.ObjectName) AS ObjectName,
--			AT1202.Address,
--			AT1202.VATNo,
--			DebitAccountID,
--			CreditAccountID, 
--			ISNULL(AV7404.AccountID, AV7424.AccountID) AS AccountID,
--			ISNULL(AT1005.AccountName, AV7424.AccountName) AS AccountName,
--			VoucherTypeID,
--			VoucherNo,
--			VoucherDate,
--			InvoiceNo,--			InvoiceDate,--			Serial,--			VDescription, 
--			ISNULL(TDescription, ISNULL(BDescription, VDescription)) AS BDescription,
--			TDescription,
--			ISNULL(AV7404.Ana01ID, AV7424.Ana01ID) AS Ana01ID,
--			AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
--			AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
--			ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) AS CurrencyID,
--			ExchangeRate,
--			AV7404.CreateDate,
--			Sum(Case When RPTransactionType = ''00'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS DebitOriginalAmount,
--			Sum(Case When RPTransactionType = ''01'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
--			Sum(Case When RPTransactionType = ''00'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
--			Sum(Case When RPTransactionType = ''01'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
--			ISNULL(AV7424.OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
--			ISNULL(AV7424.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
--			ISNULL(AV7424.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
--			ISNULL(AV7424.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
--			sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
--			sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
--			cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
--			cast(0 as decimal(28,8)) AS ClosingConvertedAmount
--	FROM	AV7404 
--	LEFT JOIN AT1202 on	AT1202.ObjectID = AV7404.ObjectID AND AT1202.DivisionID = AV7404.DivisionID 
--	FULL JOIN AV7424 on AV7424.ObjectID = AV7404.ObjectID  AND AV7424.DivisionID = AV7404.DivisionID 
--			AND AV7424.AccountID = AV7404.AccountID AND AV7424.Ana01ID = AV7404.Ana01ID					
--	LEFT JOIN AT1005 on AT1005.AccountID = AV7404.AccountID  AND AT1005.DivisionID = AV7404.DivisionID 
	
--	' + @SQLwhereAna + '
	
--	GROUP BY BatchID,VoucherID,TableID, Status, AV7404.DivisionID, TranMonth, TranYear, 
--			RPTransactionType, TransactionTypeID, AV7404.ObjectID, AV7424.ObjectID,
--			DebitAccountID, CreditAccountID, AV7404.AccountID, AV7424.AccountID, 
--			VoucherTypeID, VoucherNo, VoucherDate,AV7424.OpeningOriginalAmount, AV7424.OpeningConvertedAmount,AV7424.OpeningOriginalAmountAna01ID, AV7424.OpeningConvertedAmountAna01ID,
--			InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
--			ISNULL(AV7404.Ana01ID, AV7424.Ana01ID),	
--			AV7404.Ana02ID, AV7404.Ana03ID,	AV7404.Ana04ID,	AV7404.Ana05ID,
--			AV7404.Ana06ID,	AV7404.Ana07ID,	AV7404.Ana08ID,	AV7404.Ana09ID,	AV7404.Ana10ID,
--			AV7404.CreateDate,
--			AV7404.CurrencyID, AV7424.CurrencyID, ExchangeRate, AT1202.ObjectName, 
--			AT1202.Address, AT1202.VATNo, 
--			AV7424.ObjectName, AT1005.AccountName, AV7424.AccountName  '

---- Lấy số dư của đối tường mà không có phát sinh trong kỳ
--	SET @sSQL1=' UNION 
--	SELECT 	(ISNULL( AV7424.ObjectID,'''') + ISNULL(AV7424.AccountID,'''') ) AS GroupID,
--			NULL AS BatchID,
--			NULL AS VoucherID,
--			NULL as TableID,
--			NULL as Status,
--			AV7424.DivisionID,
--			NULL AS TranMonth,
--			NULL AS TranYear, 
--			Cast(ISNULL( AV7424.AccountID,'''') AS char(20)) + 
--			cast(ISNULL( AV7424.ObjectID, '''')  AS char(20)) + 
--			cast(ISNULL(AV7424.CurrencyID, '''') AS char(20))  AS Orders,
--			NULL AS RPTransactionType,
--			NULL AS TransactionTypeID,
--			ISNULL( AV7424.ObjectID, '''') AS ObjectID,  
--			ISNULL( AV7424.ObjectName , '''') AS ObjectName,
--			AT1202.Address,
--			AT1202.VATNo,
--			NULL AS DebitAccountID,
--			NULL AS CreditAccountID, 
--			ISNULL(AV7424.AccountID, '''') AS AccountID,
--			ISNULL( AV7424.AccountName, '''') AS AccountName,
--			NULL AS VoucherTypeID,
--			NULL AS VoucherNo,
--			CONVERT(DATETIME, NULL) AS VoucherDate,
--			NULL AS InvoiceNo,
--			CONVERT(DATETIME, NULL) AS InvoiceDate,
--			NULL AS Serial,
--			NULL AS VDescription, 
--			NULL AS BDescription,
--			NULL AS TDescription,
--			ISNULL( AV7424.Ana01ID, '''') AS Ana01ID,
--			NULL AS Ana02ID,
--			NULL AS Ana03ID,
--			NULL AS Ana04ID,
--			NULL AS Ana05ID,
--			NULL AS Ana06ID,
--			NULL AS Ana07ID,
--			NULL AS Ana08ID,
--			NULL AS Ana09ID,
--			NULL AS Ana10ID,
--			ISNULL( AV7424.CurrencyID , '''') AS CurrencyID,
--			0 AS ExchangeRate,
--			CONVERT(DATETIME, NULL) AS CreateDate,
--			0 AS DebitOriginalAmount,
--			0 AS CreditOriginalAmount,
--			0 AS DebitConvertedAmount,
--			0 AS CreditConvertedAmount,
--			ISNULL(AV7424.OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
--			ISNULL(AV7424.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
--			ISNULL(AV7424.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
--			ISNULL(AV7424.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
--			0 AS SignConvertedAmount,
--			0 AS SignOriginalAmount,
--			cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
--			cast(0 as decimal(28,8)) AS ClosingConvertedAmount
--	FROM AV7424 	
--	LEFT JOIN AT1202 on	AT1202.ObjectID = AV7424.ObjectID  AND AT1202.DivisionID = AV7424.DivisionID 
--	WHERE	AV7424.ObjectID + AV7424.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
--	 '
--	--PRINT(@sSQL)
--	--PRINT (@sSQL1)
--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7425]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--     EXEC ('  CREATE VIEW AV7425 AS ' + @sSQL + @sSQL1)
--ELSE
--     EXEC ('  ALTER VIEW AV7425  AS ' + @sSQL + @sSQL1)

--In khong co ma phan tich 1
SET @sSQL = '
SELECT AV7415.GroupID,
		BatchID,
		VoucherID,
		TableID,
		Status,
		AV7415.DivisionID,
		TranMonth,
		TranYear,
		RPTransactionType,
		TransactionTypeID,
		AV7415.ObjectID,
		AV7415.ObjectName,
		AV7415.Address,
		AV7415.VATNo,
		AT1202.S1,
		AT1202.S2,
		AT1202.S3,
		AT1202.Tel,
		AT1202.Fax,
		AT1202.Email,
		AV7415.DebitAccountID,
		A01.AccountName AS DebitAccountName,
		AV7415.CreditAccountID,
		A02.AccountName AS CreditAccountName,
		AV7415.AccountID,
		AV7415.AccountName,
		A03.AccountNameE,
		VoucherTypeID,
		VoucherNo,
		VoucherDate,
		InvoiceNo,
		InvoiceDate, 
		Serial,
		VDescription,
		BDescription,
		TDescription, 
		AV7415.Ana01ID,	AV7415.Ana02ID,	AV7415.Ana03ID,	AV7415.Ana04ID,	AV7415.Ana05ID,
		AV7415.Ana06ID,	AV7415.Ana07ID,	AV7415.Ana08ID,	AV7415.Ana09ID,	AV7415.Ana10ID,
		A11.AnaName AS Ana01Name, A12.AnaName AS Ana02Name, A13.AnaName AS Ana03Name, A14.AnaName AS Ana04Name, A15.AnaName AS Ana05Name,
		A16.AnaName AS Ana06Name, A17.AnaName AS Ana07Name, A18.AnaName AS Ana08Name, A19.AnaName AS Ana09Name, A20.AnaName AS Ana10Name,
		O01ID,	O02ID,	O03ID,	O04ID,	O05ID,
		AV7415.CurrencyID,
		ExchangeRate, 
		Sum(DebitOriginalAmount) AS DebitOriginalAmount,
		Sum(CreditOriginalAmount) AS CreditOriginalAmount,
		Sum(DebitConvertedAmount) AS DebitConvertedAmount,
		Sum(CreditConvertedAmount) AS CreditConvertedAmount,
		OpeningOriginalAmount, OpeningConvertedAmount,
		sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
		sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
		ClosingOriginalAmount,
		ClosingConvertedAmount ,
		CAST (TranMonth AS Varchar)  + ''/'' + CAST (TranYear AS Varchar) AS MonthYear,
		CONVERT(varchar(20), Duedate, 103) AS duedate,
		''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate,
		(case when' + str(@TypeD) + ' = 0 then ''30/' + Ltrim (str(@ToMonth)) + '/' + ltrim(str(@ToYear)) + ''' ELSE ''' + CONVERT(varchar(10), @ToDate,103) + ''' end) AS Todate '
SET @sSQL1 = '
FROM AV7415_ST as AV7415
INNER JOIN ' + @TableDBO + 'AT1202 as AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7415.ObjectID
LEFT JOIN ' + @TableDBO + 'AT1005 A01 on A01.AccountID  = AV7415.DebitAccountID
LEFT JOIN ' + @TableDBO + 'AT1005 A02 on A02.AccountID  = AV7415.CreditAccountID
LEFT JOIN ' + @TableDBO + 'AT1005 A03 on A03.AccountID  = AV7415.AccountID
LEFT JOIN ' + @TableDBO + 'AT1011 A11 on A11.AnaID = AV7415.Ana01ID AND A11.AnaTypeID = ''A01'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A12 on A12.AnaID = AV7415.Ana02ID AND A12.AnaTypeID = ''A02'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A13 on A13.AnaID = AV7415.Ana03ID AND A13.AnaTypeID = ''A03'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A14 on A14.AnaID = AV7415.Ana04ID AND A14.AnaTypeID = ''A04'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A15 on A15.AnaID = AV7415.Ana05ID AND A15.AnaTypeID = ''A05'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A16 on A16.AnaID = AV7415.Ana06ID AND A16.AnaTypeID = ''A06'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A17 on A17.AnaID = AV7415.Ana07ID AND A17.AnaTypeID = ''A07'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A18 on A18.AnaID = AV7415.Ana08ID AND A18.AnaTypeID = ''A08'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A19 on A19.AnaID = AV7415.Ana09ID AND A19.AnaTypeID = ''A09'' 
LEFT JOIN ' + @TableDBO + 'AT1011 A20 on A20.AnaID = AV7415.Ana10ID AND A20.AnaTypeID = ''A10'' 
WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
		OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
		OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0)
	
GROUP BY AV7415. GroupID, BatchID,VoucherID, TableID,Status,AV7415.DivisionID, TranMonth, TranYear, 
		RPTransactionType, TransactionTypeID, AV7415.ObjectID, 
		AV7415.Address, AV7415.VATNo,  
		AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
		AV7415.DebitAccountID, AV7415.CreditAccountID,
		AV7415. AccountID, A03.AccountNameE,
		VoucherTypeID, VoucherNo, VoucherDate, OpeningOriginalAmount, OpeningConvertedAmount,
		InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
		AV7415.Ana01ID,	AV7415.Ana02ID,	AV7415.Ana03ID,	AV7415.Ana04ID,	AV7415.Ana05ID,
		AV7415.Ana06ID,	AV7415.Ana07ID,	AV7415.Ana08ID,	AV7415.Ana09ID,	AV7415.Ana10ID, 
		A11.AnaName, A12.AnaName, A13.AnaName, A14.AnaName, A15.AnaName,
		A16.AnaName, A17.AnaName, A18.AnaName, A19.AnaName, A20.AnaName,
		O01ID,O02ID,O03ID, O04ID,O05ID,
		AV7415.CurrencyID, ExchangeRate, AV7415.ObjectName, 
		AV7415. AccountName, ClosingOriginalAmount, ClosingConvertedAmount, 
		A01.AccountName,  A02.AccountName,Duedate '

---print @sSQL
IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7405_ST]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
     EXEC ('  CREATE VIEW AV7405_ST AS ' + @sSQL+@sSQL1)
ELSE
     EXEC ('  ALTER VIEW AV7405_ST  AS ' + @sSQL+@sSQL1)

---In co ma phan tich 1

--SET @sSQL = '
--SELECT AV7425.GroupID, 
--		BatchID,
--		VoucherID,
--		TableID,
--		Status,
--		AV7425.DivisionID,
--		TranMonth,
--		TranYear,
--		RPTransactionType,
--		TransactionTypeID,
--		AV7425.ObjectID,
--		AV7425.ObjectName,
--		AV7425.Address,
--		AV7425.VATNo,
--		AT1202.S1,
--		AT1202.S2,
--		AT1202.S3,
--		AT1202.Tel,
--		AT1202.Fax,
--		AT1202.Email,
--		AV7425.DebitAccountID,
--		A01.AccountName AS DebitAccountName,
--		AV7425.CreditAccountID,
--		A02.AccountName AS CreditAccountName,
--		AV7425.AccountID,
--		AV7425.AccountName,
--		VoucherTypeID,
--		VoucherNo,
--		VoucherDate,
--		InvoiceNo,
--		InvoiceDate, 
--		Serial,
--		VDescription,
--		BDescription,
--		TDescription, 
--		AV7425.Ana01ID,	AV7425.Ana02ID,	AV7425.Ana03ID,	AV7425.Ana04ID,	AV7425.Ana05ID,
--		AV7425.Ana06ID,	AV7425.Ana07ID,	AV7425.Ana08ID,	AV7425.Ana09ID,	AV7425.Ana10ID,
--		A11.AnaName AS Ana01Name,
--		O01ID,	O02ID,	O03ID,	O04ID,	O05ID,
--		AV7425.CurrencyID,
--		ExchangeRate, 
--		Sum(DebitOriginalAmount) AS DebitOriginalAmount,
--		Sum(CreditOriginalAmount) AS CreditOriginalAmount,
--		Sum(DebitConvertedAmount) AS DebitConvertedAmount,
--		Sum(CreditConvertedAmount) AS CreditConvertedAmount,
--		OpeningOriginalAmount, 
--		OpeningConvertedAmount,
--		OpeningOriginalAmountAna01ID, 
--		OpeningConvertedAmountAna01ID,
--		sum(ISNULL(SignConvertedAmount,0)) AS SignConvertedAmount,
--		sum(ISNULL(SignOriginalAmount,0)) AS SignOriginalAmount,
--		ClosingOriginalAmount,
--		ClosingConvertedAmount,
--		CAST (TranMonth AS Varchar) + ''/'' + CAST (TranYear AS Varchar) AS MonthYear
--FROM	AV7425	 
--INNER JOIN AT1202 on AT1202.ObjectID = AV7425.ObjectID AND AT1202.DivisionID = AV7425.DivisionID
--LEFT JOIN AT1005 A01 on A01.AccountID  = AV7425.DebitAccountID AND A01.DivisionID  = AV7425.DivisionID
--LEFT JOIN AT1005 A02 on A02.AccountID  = AV7425.CreditAccountID AND A02.DivisionID  = AV7425.DivisionID
--LEFT JOIN AT1011 A11 on A11.AnaID = AV7425.Ana01ID AND A11.DivisionID=AV7425.DivisionID AND A11.AnaTypeID = ''A01'' 
--WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
--	OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
--	OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0 )
--GROUP BY
--	AV7425. GroupID, BatchID,VoucherID,TableID,Status,AV7425.DivisionID, TranMonth, TranYear, 
--	RPTransactionType, TransactionTypeID, AV7425.ObjectID, 
--	AV7425.Address, AV7425.VATNo, 
--	AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
--	AV7425.DebitAccountID, AV7425.CreditAccountID,
--	AV7425. AccountID, VoucherTypeID, VoucherNo, VoucherDate, OpeningOriginalAmount, OpeningConvertedAmount,OpeningOriginalAmountAna01ID, OpeningConvertedAmountAna01ID,
--	InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
--	AV7425.Ana01ID,	AV7425.Ana02ID,	AV7425.Ana03ID,	AV7425.Ana04ID,	AV7425.Ana05ID,
--	AV7425.Ana06ID,	AV7425.Ana07ID,	AV7425.Ana08ID,	AV7425.Ana09ID,	AV7425.Ana10ID, 
--	A11.AnaName,
--	O01ID,O02ID,O03ID, O04ID,O05ID,
--	AV7425.CurrencyID, ExchangeRate, AV7425.ObjectName, 
--	AV7425. AccountName, ClosingOriginalAmount, ClosingConvertedAmount, A01.AccountName, A02.AccountName '

----PRINT(@sSQL)
----PRINT(@sSQL1)
--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7406]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--     EXEC ('  CREATE VIEW AV7406 AS ' + @sSQL)
--ELSE
--     EXEC ('  ALTER VIEW AV7406  AS ' + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

