IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7405_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7405_TIENTIEN]
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
---- Modified on 07/04/2021 by Huỳnh Thử : [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 10/05/2021 by Huỳnh Thử : [TienTien] -- Print 1 DivisionID bỏ union all @@@
---- Modified on 26/05/2021 by Huỳnh Thử : [TienTien] -- Sửa lại cách lấy tồn đầu kỳ @@@
---- Modified on 28/05/2021 by Huỳnh Thử : [TienTien] -- Bổ sung VoucherID
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7405_TIENTIEN]
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
					@DatabaseName as varchar(250)='',
					@StrDivisionID AS NVARCHAR(4000),
					@ReportDate AS DATETIME = NULL
 AS
 SET NOCOUNT OFF 
DECLARE @sSQL AS nvarchar(MAX)='',
		@sSQL_1 AS nvarchar(MAX)='',
		@sSQL1 AS nvarchar(MAX)='',
		@sSQL2 AS nvarchar(MAX)='',
		@sSQL3 AS nvarchar(MAX)='',
		@sSQL_UNION AS nvarchar(MAX)='',
		@sSQL4 AS nvarchar(MAX)='',
		@sSQLUnionAll AS nvarchar(MAX),
		@SQLwhere AS nvarchar(MAX) = '',
		@SQLwhereAna AS nvarchar(MAX) = '',
		@sSQLwhere2 AS nvarchar(MAX) = '',
		@sSQLwhere5 AS nvarchar(MAX) = '',
		@TypeDate AS nvarchar(20)='',
		@SQLObject AS nvarchar(MAX)='',
		@sSQLGroupBy AS nvarchar(MAX)='',
		@FromPeriod AS int,
		@ToPeriod AS int,
		@sSQLWhere3 nvarchar(MAX)='',
		@sSQLCustomize AS NVARCHAR(MAX)='',
		@sSQLWhere4 AS nvarchar(MAX) = '',
		@sSQLWhereDateTime AS nvarchar(MAX) = '',
		@ReportDivisionID AS NVARCHAR(50)

		Declare @CustomerName INT
		--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF(@DivisionID <> 'AA')
	BEGIN
		SET @ReportDivisionID = 'AAAAAAAAAA'
	END
	ELSE
	BEGIN
		SET @ReportDivisionID  = @DivisionID
	END



	SET @sSQLCustomize = '					
					, SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) AS DebitOriginalAmount
					, SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) AS CreditOriginalAmount
					, SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS DebitConvertedAmount
					, SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS CreditConvertedAmount
	'

Begin	

		IF @TypeD = 1   --- Ngay HT
			BEGIN
			SET @TypeDate ='InvoiceDate'
			SET @sSQLWhere3 = 'InvoiceDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
			END
		ELSE IF @TypeD=2  --- Ngay HD
			BEGIN
			SET @TypeDate = 'VoucherDate'
			SET @sSQLWhere3 = 'VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
			END
		ELSE IF @TypeD=3   --Ngay Dao han
			BEGIN
			SET @TypeDate = 'DueDate'
			SET @sSQLWhere3 = 'DueDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
				IF @CustomerName = 110 -- SONG BINH
				BEGIN
					SET @TypeDate = 'OrderDate'
					SET @sSQLWhere3 = 'OrderDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
					SET @sSQLWhereDateTime =  'VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
				END
			END

		SET @FromPeriod = (@FromMonth + @FromYear * 100)	
		SET @ToPeriod = (@ToMonth + @ToYear * 100)	

		--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_New AS NVARCHAR(4000)
		DECLARE @StrDivisionID_New1 AS NVARCHAR(4000)

	
		IF isnull(@StrDivisionID, '') = Isnull(@DivisionID, '') 
		BEGIN
			SET @StrDivisionID_New = ' AND AV7404.DivisionID LIKE ''' + @DivisionID + '''' 
			SET @StrDivisionID_New1 = ' AND AV7414.DivisionID LIKE ''' + @DivisionID + '''' 
		END
		ELSE
		BEGIN
			SET @StrDivisionID_New = ' AND AV7404.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
			SET @StrDivisionID_New1 = ' AND AV7414.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'

		END
		---------------<<<< Chuỗi DivisionID		

		IF @TypeD in (1, 2, 3)   -- Theo ngay
		BEGIN
			SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),D3.' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''') '
			IF @CustomerName = 110 AND @TypeD = 3 -- song binh
			BEGIN
					SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),OT2001.' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''') '
			END
		END
		ELSE    ---Theo ky
		BEGIN
			SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + STR(@FromPeriod) + ' AND '+ STR(@ToPeriod) + ')'
		END
	
		------ Loc ra cac phan tu
		EXEC AP7404  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere, @StrDivisionID
			
		------- Xac dinh so du co cac doi tuong
		EXEC AP7414 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,'1=1', @StrDivisionID

		IF @TypeD = 4 ---  Tinh tu ky den ky	
			  BEGIN	
	
				SET @SQLwhere = '
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
					 '+ @StrDivisionID_New + ' AND (ISNULL(AV7404.AccountID, AV7414.AccountID) BETWEEN ''' + @FromAccountID+ ''' AND ''' + @ToAccountID + ''')'
				SET @SQLwhereAna ='
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
					 '+ @StrDivisionID_New + ' AND (ISNULL(AV7404.AccountID, AV7424.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
				SET @sSQLWhere3 = '(TranMonth + 100 * TranYear BETWEEN ' + STR(@FromPeriod) + ' AND '+ STR(@ToPeriod) + ')'

				IF @CurrencyID <> '%'
					Begin
						SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
						SET @SQLwhereAna = @SQLwhereAna + ' AND  ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) LIKE  ''' + @CurrencyID + ''' ' 
					End
	
			   END
		ELSE    ---- Xac dinh theo Ngay
			  BEGIN
	
				SET @SQLwhere = '
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7414.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') '

				SET @SQLwhereAna = '
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7424.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
	
				IF @CurrencyID <> '%'
					Begin
						SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
						SET @SQLwhereAna = @SQLwhereAna + ' AND ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
					End
			  END

		---In khong co ma phan tich 1
		SET @sSQL = '

		           


			SELECT (
					ISNULL(AV7404.ObjectID, AV7414.ObjectID) + ISNULL(AV7404.AccountID, AV7414.AccountID)) AS GroupID
					, BatchID
					, AV7404.VoucherID
					, TableID
					, Status
					, AV7404.DivisionID
					, TranMonth
					, TranYear
					, CAST(ISNULL(AV7404.AccountID, AV7414.AccountID) AS CHAR(20)) 
						+ CAST(ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS CHAR(20)) 
						+ CAST(ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CHAR(20)) 
						+ CAST(DAY(VoucherDate) + MONTH(VoucherDate) * 100 
						+ YEAR(VoucherDate) * 10000 AS CHAR(8)) 
						+ CAST(AV7404.VoucherID AS CHAR(20)) 
						+ (CASE WHEN RPTransactionType = ''00'' THEN ''0'' ELSE ''1'' END) AS Orders
					, RPTransactionType
					, TransactionTypeID
					, ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS ObjectID
					, ISNULL(AT1202.ObjectName, AV7414.ObjectName) AS ObjectName
					, AT1202.Address
					, AT1202.VATNo
					, AT1202.TradeName
					, AT1202.Contactor
					, DebitAccountID
					, CreditAccountID
					, ISNULL(AV7404.AccountID, AV7414.AccountID) AS AccountID
					, ISNULL(AT1005.AccountName, AV7414.AccountName) AS AccountName
					, ISNULL(AT1005.AccountNameE, AV7414.AccountNameE) AS AccountNameE
					, VoucherTypeID
					, VoucherNo
					, VoucherDate
					, InvoiceNo
					, InvoiceDate
					, Serial
					, VDescription
					, ' + CASE WHEN @CustomerName = 109 THEN 'AV7404.BDescription' ELSE 'ISNULL(AV7404.TDescription, ISNULL(AV7404.BDescription, AV7404.VDescription))' END + ' AS BDescription
					, TDescription
					, AV7404.Ana01ID
					, AV7404.Ana02ID
					, AV7404.Ana03ID
					, AV7404.Ana04ID
					, AV7404.Ana05ID
					, AV7404.Ana06ID
					, AV7404.Ana07ID
					, AV7404.Ana08ID
					, AV7404.Ana09ID
					, AV7404.Ana10ID
					, ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CurrencyID
					, ExchangeRate
					, AV7404.CreateDate
					'+ @sSQLCustomize +'
					, ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount
					, ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount
					, SUM(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount
					, SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
					, CAST(0 AS DECIMAL(28,8)) AS ClosingOriginalAmount
					, CAST(0 AS DECIMAL(28,8)) AS ClosingConvertedAmount
					, Duedate
					, Parameter01
					, Parameter02
					, Parameter03
					, Parameter04
					, Parameter05
					, Parameter06
					, Parameter07
					, Parameter08
					, Parameter09
					, Parameter10
					, AV7404.OrderID AS OrderNo
					, AV7404.Orderdate AS OrderDate
					, AV7404.ClassifyID
					, 2 AS OriginalDecimals
					
					
		INTO #AV7415
		FROM	AV7404'
SET @sSQL_1 = ' 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7404.ObjectID
		FULL JOIN AV7414 ON AV7414.ObjectID = AV7404.ObjectID 
					AND AV7414.AccountID = AV7404.AccountID 
					AND AV7414.DivisionID = AV7404.DivisionID
	    
		LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV7404.AccountID ' + @SQLwhere + '
		GROUP BY AV7404.DivisionID
				, BatchID
				, AV7404.VoucherID
				, TableID
				, Status
				, AV7404.DivisionID
				, TranMonth
				, TranYear,'

		SET @sSQLGroupBy = 'RPTransactionType
				, TransactionTypeID
				, AV7404.ObjectID
				, AV7414.ObjectID
				, DebitAccountID
				, CreditAccountID
				, AV7404.AccountID
				, AV7414.AccountID
				, VoucherTypeID
				, VoucherNo
				, VoucherDate
				, AV7414.OpeningOriginalAmount
				, AV7414.OpeningConvertedAmount
				, InvoiceNo
				, InvoiceDate
				, Serial
				, VDescription
				, BDescription
				, TDescription
				, AV7404.Ana01ID
				, AV7404.Ana02ID
				, AV7404.Ana03ID
				, AV7404.Ana04ID
				, AV7404.Ana05ID
				, AV7404.Ana06ID
				, AV7404.Ana07ID
				, AV7404.Ana08ID
				, AV7404.Ana09ID
				, AV7404.Ana10ID
				, AV7404.CreateDate
				, AV7404.CurrencyID
				, AV7414.CurrencyID
				, ExchangeRate
				, AT1202.ObjectName
				, AT1202.Address
				, AT1202.VATNo
				, AT1202.TradeName
				, AT1202.Contactor
				, AV7404.Orderdate
				
				, AV7414.ObjectName
				, AT1005.AccountName
				, AT1005.AccountNameE
				, AV7414.AccountName
				, AV7414.AccountNameE
				, Duedate
				, AV7404.ClassifyID
				, Parameter01
				, Parameter02
				, Parameter03
				, Parameter04
				, Parameter05
				, Parameter06
				, Parameter07
				, Parameter08
				, Parameter09
				, Parameter10
				, AV7404.OrderID'
		SET @sSQL1 = '
			UNION ALL
			SELECT (ISNULL( AV7414.ObjectID, '''') + ISNULL( AV7414.AccountID, '''')) AS GroupID
					, NULL AS BatchID
					, NULL AS VoucherID
					, NULL AS TableID
					, NULL AS Status
					, AV7414.DivisionID
					, NULL AS TranMonth
					, NULL AS TranYear
					, CAST(ISNULL(AV7414.AccountID , '''') AS CHAR(20)) 
						+ CAST(ISNULL(AV7414.ObjectID, '''')  AS char(20)) 
						+ CAST(ISNULL(AV7414.CurrencyID, '''') AS char(20)) AS Orders
					, NULL AS RPTransactionType
					, NULL AS TransactionTypeID
					, ISNULL(AV7414.ObjectID,'''') AS ObjectID
					, ISNULL(AV7414.ObjectName , '''') AS ObjectName
					, AT1202.Address
					, AT1202.VATNo
					, AT1202.TradeName
					, AT1202.Contactor
					, NULL AS DebitAccountID
					, NULL AS CreditAccountID
					, ISNULL(AV7414.AccountID, '''') AS AccountID
					, ISNULL(AV7414.AccountName, '''' ) AS AccountName
					, ISNULL(AV7414.AccountNameE, '''' ) AS AccountNameE,
					NULL AS VoucherTypeID,
					NULL AS VoucherNo,
					CONVERT(DATETIME, NULL) AS VoucherDate,
					NULL AS InvoiceNo,
					CONVERT(DATETIME, NULL) AS InvoiceDate,
					NULL AS Serial,
					NULL AS VDescription, 
					NULL AS BDescription,
					NULL AS TDescription,
					NULL AS Ana01ID, 		
					NULL AS Ana02ID,
					NULL AS Ana03ID,
					NULL AS Ana04ID,
					NULL AS Ana05ID,
					NULL AS Ana06ID,
					NULL AS Ana07ID,
					NULL AS Ana08ID,
					NULL AS Ana09ID,
					NULL AS Ana10ID,
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
					CONVERT(DATETIME, NULL) AS Duedate,
					NULL AS Parameter01, NULL as Parameter02,
					NULL AS Parameter03, NULL as Parameter04,
					NULL AS Parameter05, NULL as Parameter06,
					NULL AS Parameter07, NULL as Parameter08,
					NULL AS Parameter09, NULL as Parameter10, 
					NULL AS OrderNo, 
					NULL AS OrderDate, 
					NULL AS ClassifyID,
					2 AS OriginalDecimals
					'+CASE WHEN @CustomerName = 110 THEN ',
					0 AS GiveOriginalAmount,
					0 AS GiveOriginalAmountCN' ELSE '' END +'
			FROM	AV7414 
			LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7414.ObjectID
			WHERE	AV7414.ObjectID + AV7414.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
			' + @StrDivisionID_New1

		--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7415]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		--	 EXEC ('  CREATE VIEW AV7415 AS ' + @sSQL + @sSQL1)
		--ELSE
		--	 EXEC ('  ALTER VIEW AV7415  AS ' + @sSQL + @sSQL1)

	 --print (@sSQL)
	 --print (@sSQLGroupBy)
	 --Print (@sSQL1)
	 IF(CHARINDEX(',', @StrDivisionID) > 0 )
	 BEGIN
	     SET @sSQL2 =  '  
		SELECT * FROM (
						 SELECT AV7415.VoucherID
						 , AV7415.GroupID
						 , AV7415.TableID
						 , AV7415.Status
						 , AV7415.DivisionID
						 , AV7415.TranMonth
						 , AV7415.TranYear
						 , AV7415.RPTransactionType
						 , AV7415.TransactionTypeID
						 , AV7415.ObjectID
						 , AV7415.ObjectName
						 , AV7415.Address
						 , AV7415.VATNo
						 , AT1202.S1
						 , AT1202.S2
						 , AT1202.S3
						 , AT1202.Tel
						 , AT1202.Fax
						 , AT1202.Email
						 , AT1202.TradeName
						 , AT1202.Contactor
						 , AV7415.DebitAccountID
						 , A01.AccountName AS DebitAccountName
						 , AV7415.CreditAccountID
						 , A02.AccountName AS CreditAccountName
						 , AV7415.AccountID
						 , AV7415.AccountName
						 , AV7415.AccountNameE
						 , AV7415.VoucherTypeID
						 , AV7415.VoucherNo
						 , AV7415.VoucherDate
						 , AV7415.InvoiceNo
						 , AV7415.InvoiceDate
						 , AV7415.Serial
						 , AV7415.VDescription
						 , AV7415.BDescription
						 , AV7415.TDescription
						 , AV7415.Ana01ID
						 , AV7415.Ana02ID
						 , AV7415.Ana03ID
						 , AV7415.Ana04ID
						 , AV7415.Ana05ID
						 , AV7415.Ana06ID
						 , AV7415.Ana07ID
						 , AV7415.Ana08ID
						 , AV7415.Ana09ID
						 , AV7415.Ana10ID
						 , A11.AnaName AS Ana01Name
						 , A12.AnaName AS Ana02Name
						 , A13.AnaName AS Ana03Name
						 , A14.AnaName AS Ana04Name
						 , A15.AnaName AS Ana05Name
						 , A16.AnaName AS Ana06Name
						 , A17.AnaName AS Ana07Name
						 , A18.AnaName AS Ana08Name
						 , A19.AnaName AS Ana09Name
						 , A10.AnaName AS Ana10Name
						 , O01ID
						 , O02ID
						 , O03ID
						 , O04ID
						 , O05ID
						 , AV7415.CurrencyID
						 , AV7415.ExchangeRate
						 , SUM(DebitOriginalAmount) AS DebitOriginalAmount
						 , SUM(CreditOriginalAmount) AS CreditOriginalAmount
						 , SUM(DebitConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS DebitConvertedAmount
						 , SUM(CreditConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS CreditConvertedAmount
						 , OpeningOriginalAmount
						 , OpeningConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS OpeningConvertedAmount
						 , SUM(ISNULL(SignConvertedAmount, 0)) * ISNULL(AT1012.ExchangeRate, 1) AS SignConvertedAmount
						 , SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
						 , ClosingOriginalAmount 
						 , ClosingConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS ClosingConvertedAmount
						 , CAST (AV7415.TranMonth AS Varchar)  + ''/'' + CAST (AV7415.TranYear AS Varchar) AS MonthYear
						 , CONVERT(varchar(20), AV7415.Duedate, 103) AS duedate
						 , ''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate
						 , (CASE WHEN' + STR(@TypeD) + ' = 0 THEN ''30/' + LTRIM (STR(@ToMonth)) + '/' + LTRIM(STR(@ToYear)) + ''' ELSE ''' + CONVERT(VARCHAR(10), @ToDate,103) + ''' end) AS Todate
						 , Parameter01
						 , Parameter02
						 , Parameter03
						 , Parameter04
						 , Parameter05
						 , Parameter06
						 , Parameter07
						 , Parameter08
						 , Parameter09
						 , Parameter10
						 , OrderNo
						 , AV7415.OrderDate
						 , AV7415.ClassifyID
						 , 2 AS OriginalDecimals
						'
			SET @sSQLWhere2 = '
				FROM #AV7415 AV7415 
				INNER JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7415.ObjectID
				LEFT JOIN AT1005 A01  WITH (NOLOCK) on A01.AccountID  = AV7415.DebitAccountID 
				LEFT JOIN AT1005 A02  WITH (NOLOCK) on A02.AccountID  = AV7415.CreditAccountID
				LEFT JOIN AT1011 A11  WITH (NOLOCK) on A11.AnaID = AV7415.Ana01ID AND A11.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A12  WITH (NOLOCK) on A12.AnaID = AV7415.Ana01ID AND A12.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13  WITH (NOLOCK) on A13.AnaID = AV7415.Ana01ID AND A13.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14  WITH (NOLOCK) on A14.AnaID = AV7415.Ana01ID AND A14.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15  WITH (NOLOCK) on A15.AnaID = AV7415.Ana01ID AND A15.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16  WITH (NOLOCK) on A16.AnaID = AV7415.Ana01ID AND A16.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17  WITH (NOLOCK) on A17.AnaID = AV7415.Ana01ID AND A17.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18  WITH (NOLOCK) on A18.AnaID = AV7415.Ana01ID AND A18.AnaTypeID = ''A08'' 
				LEFT JOIN AT1011 A19  WITH (NOLOCK) on A19.AnaID = AV7415.Ana01ID AND A19.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10  WITH (NOLOCK) on A10.AnaID = AV7415.Ana01ID AND A10.AnaTypeID = ''A10''
				LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7415.DivisionID
				LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
			 WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
						OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
						OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0)  AND ' + @SqlFind + '
						' 
			SET @sSQLWhere5 = '
				FROM #AV7415 AV7415 
				INNER JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7415.ObjectID
				LEFT JOIN AT1005 A01  WITH (NOLOCK) on A01.AccountID  = AV7415.DebitAccountID 
				LEFT JOIN AT1005 A02  WITH (NOLOCK) on A02.AccountID  = AV7415.CreditAccountID
				LEFT JOIN AT1011 A11  WITH (NOLOCK) on A11.AnaID = AV7415.Ana01ID AND A11.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A12  WITH (NOLOCK) on A12.AnaID = AV7415.Ana01ID AND A12.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13  WITH (NOLOCK) on A13.AnaID = AV7415.Ana01ID AND A13.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14  WITH (NOLOCK) on A14.AnaID = AV7415.Ana01ID AND A14.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15  WITH (NOLOCK) on A15.AnaID = AV7415.Ana01ID AND A15.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16  WITH (NOLOCK) on A16.AnaID = AV7415.Ana01ID AND A16.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17  WITH (NOLOCK) on A17.AnaID = AV7415.Ana01ID AND A17.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18  WITH (NOLOCK) on A18.AnaID = AV7415.Ana01ID AND A18.AnaTypeID = ''A08'' 
				LEFT JOIN AT1011 A19  WITH (NOLOCK) on A19.AnaID = AV7415.Ana01ID AND A19.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10  WITH (NOLOCK) on A10.AnaID = AV7415.Ana01ID AND A10.AnaTypeID = ''A10''
				LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7415.DivisionID
				LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
				LEFT JOIN	(	select AV7414.ObjectID, AV7414.AccountID, AV7414.CurrencyID, sum(OpeningConvertedAmount*ISNULL(ExchangeRate,1)) AS OpeCvtAmt, SUM(OpeningOriginalAmount) AS OpeOrgAmt from AV7414 
								LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7414.DivisionID
								LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''

								group by AV7414.ObjectID, AV7414.AccountID, AV7414.CurrencyID
							) V14 ON V14.ObjectID = AV7415.ObjectID AND V14.AccountID = AV7415.AccountID AND V14.CurrencyID = ''%''
				
			 WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
						OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
						OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0)  AND ' + @SqlFind + ' '

			SET @sSQL3 = '
				GROUP BY  AV7415.VoucherID
						, AV7415.GroupID
						, AV7415.TableID
						, AV7415.Status
						, AV7415.DivisionID
						, AV7415.TranMonth
						, AV7415.TranYear
						, AV7415.RPTransactionType
						, AV7415.TransactionTypeID
						, AV7415.ObjectID
						, AV7415.Address
						, AV7415.VATNo
						, AT1202.S1
						, AT1202.S2
						, AT1202.S3
						, AT1202.Tel
						, AT1202.Fax
						, AT1202.Email
						, AT1202.TradeName
						, AT1202.Contactor
						, AV7415.DebitAccountID
						, AV7415.CreditAccountID
						, AV7415. AccountID
						, AV7415.VoucherTypeID
						, AV7415.VoucherNo
						, AV7415.VoucherDate
						, AV7415.OpeningOriginalAmount
						, AV7415.OpeningConvertedAmount
						, AV7415.InvoiceNo
						, AV7415.InvoiceDate
						, AV7415.Serial
						, AV7415.VDescription
						, AV7415.BDescription
						, AV7415.TDescription
						, AV7415.Ana01ID
						, AV7415.Ana02ID
						, AV7415.Ana03ID
						, AV7415.Ana04ID
						, AV7415.Ana05ID
						, AV7415.Ana06ID
						, AV7415.Ana07ID
						, AV7415.Ana08ID
						, AV7415.Ana09ID
						, AV7415.Ana10ID
						, A11.AnaName
						, AV7415.OrderDate
						, AV7415.ClassifyID
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, AV7415.CurrencyID
						, AV7415.ExchangeRate
						, AV7415.ObjectName
						, AV7415.AccountName
						, AV7415.AccountNameE
						, ClosingOriginalAmount
						, ClosingConvertedAmount
						, A01.AccountName
						, A02.AccountName
						, AV7415.Duedate
						, A11.AnaName
						, A12.AnaName
						, A13.AnaName 
						, A14.AnaName
						, A15.AnaName
						, A16.AnaName
						, A17.AnaName
						, A18.AnaName
						, A19.AnaName
						, A10.AnaName
						, Parameter01
						, Parameter02
						, Parameter03
						, Parameter04
						, Parameter05
						, Parameter06
						, Parameter07
						, Parameter08
						, Parameter09
						, Parameter10
						, OrderNo
						, OriginalDecimals
						, AT1012.ExchangeRate
						
				'

			SET @sSQL_UNION = N'
			
			UNION ALL
						 SELECT '''' AS VoucherID
						 , AV7415.GroupID
						 , AV7415.TableID
						 , AV7415.Status
						 , ''@@@'' AS DivisionID
						 , AV7415.TranMonth
						 , AV7415.TranYear
						 , AV7415.RPTransactionType
						 , AV7415.TransactionTypeID
						 , AV7415.ObjectID
						 , AV7415.ObjectName
						 , AV7415.Address
						 , AV7415.VATNo
						 , AT1202.S1
						 , AT1202.S2
						 , AT1202.S3
						 , AT1202.Tel
						 , AT1202.Fax
						 , AT1202.Email
						 , AT1202.TradeName
						 , AT1202.Contactor
						 , AV7415.DebitAccountID
						 , A01.AccountName AS DebitAccountName
						 , AV7415.CreditAccountID
						 , A02.AccountName AS CreditAccountName
						 , AV7415.AccountID
						 , AV7415.AccountName
						 , AV7415.AccountNameE
						 , AV7415.VoucherTypeID
						 , AV7415.VoucherNo
						 , AV7415.VoucherDate
						 , AV7415.InvoiceNo
						 , AV7415.InvoiceDate
						 , AV7415.Serial
						 , AV7415.VDescription
						 , AV7415.BDescription
						 , AV7415.TDescription
						 , AV7415.Ana01ID
						 , AV7415.Ana02ID
						 , AV7415.Ana03ID
						 , AV7415.Ana04ID
						 , AV7415.Ana05ID
						 , AV7415.Ana06ID
						 , AV7415.Ana07ID
						 , AV7415.Ana08ID
						 , AV7415.Ana09ID
						 , AV7415.Ana10ID
						 , A11.AnaName AS Ana01Name
						 , A12.AnaName AS Ana02Name
						 , A13.AnaName AS Ana03Name
						 , A14.AnaName AS Ana04Name
						 , A15.AnaName AS Ana05Name
						 , A16.AnaName AS Ana06Name
						 , A17.AnaName AS Ana07Name
						 , A18.AnaName AS Ana08Name
						 , A19.AnaName AS Ana09Name
						 , A10.AnaName AS Ana10Name
						 , O01ID
						 , O02ID
						 , O03ID
						 , O04ID
						 , O05ID
						 , AV7415.CurrencyID
						 , AV7415.ExchangeRate
						 , SUM(DebitOriginalAmount) AS DebitOriginalAmount
						 , SUM(CreditOriginalAmount) AS CreditOriginalAmount
						 , SUM(DebitConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS DebitConvertedAmount
						 , SUM(CreditConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS CreditConvertedAmount
						 , SUM(OpeOrgAmt) AS OpeningOriginalAmount
						 , SUM(OpeCvtAmt)  AS OpeningConvertedAmount
						 , SUM(ISNULL(SignConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1))  AS SignConvertedAmount
						 , SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
						 , Sum(ClosingOriginalAmount) AS ClosingOriginalAmount
						 , Sum(ClosingConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS ClosingConvertedAmount
						 , CAST (AV7415.TranMonth AS Varchar)  + ''/'' + CAST (AV7415.TranYear AS Varchar) AS MonthYear
						 , CONVERT(varchar(20), AV7415.Duedate, 103) AS duedate
						 , ''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate
						 , (CASE WHEN' + STR(@TypeD) + ' = 0 THEN ''30/' + LTRIM (STR(@ToMonth)) + '/' + LTRIM(STR(@ToYear)) + ''' ELSE ''' + CONVERT(VARCHAR(10), @ToDate,103) + ''' end) AS Todate
						 , Parameter01
						 , Parameter02
						 , Parameter03
						 , Parameter04
						 , Parameter05
						 , Parameter06
						 , Parameter07
						 , Parameter08
						 , Parameter09
						 , Parameter10
						 , OrderNo
						 , AV7415.OrderDate
						 , AV7415.ClassifyID
						 , 2 AS OriginalDecimals'
			SET @sSQL4 = N'
			GROUP BY AV7415.GroupID
						, AV7415.TableID
						, AV7415.Status
						, AV7415.TranMonth
						, AV7415.TranYear
						, AV7415.RPTransactionType
						, AV7415.TransactionTypeID
						, AV7415.ObjectID
						, AV7415.Address
						, AV7415.VATNo
						, AT1202.S1
						, AT1202.S2
						, AT1202.S3
						, AT1202.Tel
						, AT1202.Fax
						, AT1202.Email
						, AT1202.TradeName
						, AT1202.Contactor
						, AV7415.DebitAccountID
						, AV7415.CreditAccountID
						, AV7415. AccountID
						, AV7415.VoucherTypeID
						, AV7415.VoucherNo
						, AV7415.VoucherDate
						, AV7415.InvoiceNo
						, AV7415.InvoiceDate
						, AV7415.Serial
						, AV7415.VDescription
						, AV7415.BDescription
						, AV7415.TDescription
						, AV7415.Ana01ID
						, AV7415.Ana02ID
						, AV7415.Ana03ID
						, AV7415.Ana04ID
						, AV7415.Ana05ID
						, AV7415.Ana06ID
						, AV7415.Ana07ID
						, AV7415.Ana08ID
						, AV7415.Ana09ID
						, AV7415.Ana10ID
						, A11.AnaName
						, AV7415.OrderDate
						, AV7415.ClassifyID
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, AV7415.CurrencyID
						, AV7415.ExchangeRate
						, AV7415.ObjectName
						, AV7415.AccountName
						, AV7415.AccountNameE
						, A01.AccountName
						, A02.AccountName
						, AV7415.Duedate
						, A11.AnaName
						, A12.AnaName
						, A13.AnaName 
						, A14.AnaName
						, A15.AnaName
						, A16.AnaName
						, A17.AnaName
						, A18.AnaName
						, A19.AnaName
						, A10.AnaName
						, Parameter01
						, Parameter02
						, Parameter03
						, Parameter04
						, Parameter05
						, Parameter06
						, Parameter07
						, Parameter08
						, Parameter09
						, Parameter10
						, OrderNo
						, OriginalDecimals
						, AT1012.ExchangeRate
						) A

						ORDER BY A.DivisionID, A.GroupID, A.ObjectID, A.VoucherDate, A.VoucherNo
	'


			PRINT(@sSQL)
			PRINT(@sSQL_1)
			PRINT(@sSQLGroupBy)
			PRINT(@sSQL1)
			PRINT(@sSQL2)
			PRINT(@sSQLWhere2)
			PRINT(@sSQL3)
			PRINT(@sSQL_UNION)
			PRINT @sSQLWhere2
			PRINT(@sSQL4)

			 EXEC (@sSQL + @sSQL_1 + @sSQLGroupBy + @sSQL1 + @sSQL2 + @sSQLWhere2 + @sSQL3 + @sSQL_UNION + @sSQLWhere5+ @sSQL4)
	 END
	 ELSE
     BEGIN
			  SET @sSQL2 =  '  
		
						 SELECT AV7415.VoucherID
						 , AV7415.GroupID
						 , AV7415.TableID
						 , AV7415.Status
						 , AV7415.DivisionID
						 , AV7415.TranMonth
						 , AV7415.TranYear
						 , AV7415.RPTransactionType
						 , AV7415.TransactionTypeID
						 , AV7415.ObjectID
						 , AV7415.ObjectName
						 , AV7415.Address
						 , AV7415.VATNo
						 , AT1202.S1
						 , AT1202.S2
						 , AT1202.S3
						 , AT1202.Tel
						 , AT1202.Fax
						 , AT1202.Email
						 , AT1202.TradeName
						 , AT1202.Contactor
						 , AV7415.DebitAccountID
						 , A01.AccountName AS DebitAccountName
						 , AV7415.CreditAccountID
						 , A02.AccountName AS CreditAccountName
						 , AV7415.AccountID
						 , AV7415.AccountName
						 , AV7415.AccountNameE
						 , AV7415.VoucherTypeID
						 , AV7415.VoucherNo
						 , AV7415.VoucherDate
						 , AV7415.InvoiceNo
						 , AV7415.InvoiceDate
						 , AV7415.Serial
						 , AV7415.VDescription
						 , AV7415.BDescription
						 , AV7415.TDescription
						 , AV7415.Ana01ID
						 , AV7415.Ana02ID
						 , AV7415.Ana03ID
						 , AV7415.Ana04ID
						 , AV7415.Ana05ID
						 , AV7415.Ana06ID
						 , AV7415.Ana07ID
						 , AV7415.Ana08ID
						 , AV7415.Ana09ID
						 , AV7415.Ana10ID
						 , A11.AnaName AS Ana01Name
						 , A12.AnaName AS Ana02Name
						 , A13.AnaName AS Ana03Name
						 , A14.AnaName AS Ana04Name
						 , A15.AnaName AS Ana05Name
						 , A16.AnaName AS Ana06Name
						 , A17.AnaName AS Ana07Name
						 , A18.AnaName AS Ana08Name
						 , A19.AnaName AS Ana09Name
						 , A10.AnaName AS Ana10Name
						 , O01ID
						 , O02ID
						 , O03ID
						 , O04ID
						 , O05ID
						 , AV7415.CurrencyID
						 , AV7415.ExchangeRate
						 , SUM(DebitOriginalAmount) AS DebitOriginalAmount
						 , SUM(CreditOriginalAmount) AS CreditOriginalAmount
						 , SUM(DebitConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS DebitConvertedAmount
						 , SUM(CreditConvertedAmount * ISNULL(AT1012.ExchangeRate, 1))  AS CreditConvertedAmount
						 , OpeningOriginalAmount
						 , OpeningConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS OpeningConvertedAmount
						 , SUM(ISNULL(SignConvertedAmount, 0)) * ISNULL(AT1012.ExchangeRate, 1) AS SignConvertedAmount
						 , SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
						 , ClosingOriginalAmount 
						 , ClosingConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS ClosingConvertedAmount
						 , CAST (AV7415.TranMonth AS Varchar)  + ''/'' + CAST (AV7415.TranYear AS Varchar) AS MonthYear
						 , CONVERT(varchar(20), AV7415.Duedate, 103) AS duedate
						 , ''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate
						 , (CASE WHEN' + STR(@TypeD) + ' = 0 THEN ''30/' + LTRIM (STR(@ToMonth)) + '/' + LTRIM(STR(@ToYear)) + ''' ELSE ''' + CONVERT(VARCHAR(10), @ToDate,103) + ''' end) AS Todate
						 , Parameter01
						 , Parameter02
						 , Parameter03
						 , Parameter04
						 , Parameter05
						 , Parameter06
						 , Parameter07
						 , Parameter08
						 , Parameter09
						 , Parameter10
						 , OrderNo
						 , AV7415.OrderDate
						 , AV7415.ClassifyID
						 , 2 AS OriginalDecimals
						'
			SET @sSQLWhere2 = '
				FROM #AV7415 AV7415 
				INNER JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7415.ObjectID
				LEFT JOIN AT1005 A01  WITH (NOLOCK) on A01.AccountID  = AV7415.DebitAccountID 
				LEFT JOIN AT1005 A02  WITH (NOLOCK) on A02.AccountID  = AV7415.CreditAccountID
				LEFT JOIN AT1011 A11  WITH (NOLOCK) on A11.AnaID = AV7415.Ana01ID AND A11.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A12  WITH (NOLOCK) on A12.AnaID = AV7415.Ana01ID AND A12.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13  WITH (NOLOCK) on A13.AnaID = AV7415.Ana01ID AND A13.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14  WITH (NOLOCK) on A14.AnaID = AV7415.Ana01ID AND A14.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15  WITH (NOLOCK) on A15.AnaID = AV7415.Ana01ID AND A15.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16  WITH (NOLOCK) on A16.AnaID = AV7415.Ana01ID AND A16.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17  WITH (NOLOCK) on A17.AnaID = AV7415.Ana01ID AND A17.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18  WITH (NOLOCK) on A18.AnaID = AV7415.Ana01ID AND A18.AnaTypeID = ''A08'' 
				LEFT JOIN AT1011 A19  WITH (NOLOCK) on A19.AnaID = AV7415.Ana01ID AND A19.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10  WITH (NOLOCK) on A10.AnaID = AV7415.Ana01ID AND A10.AnaTypeID = ''A10''
				LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7415.DivisionID
				LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''
			 WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
						OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
						OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0)  AND ' + @SqlFind + '
						' 
			SET @sSQL3 = '
				GROUP BY 
						  AV7415.VoucherID
						, AV7415.GroupID
						, AV7415.TableID
						, AV7415.Status
						, AV7415.DivisionID
						, AV7415.TranMonth
						, AV7415.TranYear
						, AV7415.RPTransactionType
						, AV7415.TransactionTypeID
						, AV7415.ObjectID
						, AV7415.Address
						, AV7415.VATNo
						, AT1202.S1
						, AT1202.S2
						, AT1202.S3
						, AT1202.Tel
						, AT1202.Fax
						, AT1202.Email
						, AT1202.TradeName
						, AT1202.Contactor
						, AV7415.DebitAccountID
						, AV7415.CreditAccountID
						, AV7415. AccountID
						, AV7415.VoucherTypeID
						, AV7415.VoucherNo
						, AV7415.VoucherDate
						, AV7415.OpeningOriginalAmount
						, AV7415.OpeningConvertedAmount
						, AV7415.InvoiceNo
						, AV7415.InvoiceDate
						, AV7415.Serial
						, AV7415.VDescription
						, AV7415.BDescription
						, AV7415.TDescription
						, AV7415.Ana01ID
						, AV7415.Ana02ID
						, AV7415.Ana03ID
						, AV7415.Ana04ID
						, AV7415.Ana05ID
						, AV7415.Ana06ID
						, AV7415.Ana07ID
						, AV7415.Ana08ID
						, AV7415.Ana09ID
						, AV7415.Ana10ID
						, A11.AnaName
						, AV7415.OrderDate
						, AV7415.ClassifyID
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, AV7415.CurrencyID
						, AV7415.ExchangeRate
						, AV7415.ObjectName
						, AV7415.AccountName
						, AV7415.AccountNameE
						, ClosingOriginalAmount
						, ClosingConvertedAmount
						, A01.AccountName
						, A02.AccountName
						, AV7415.Duedate
						, A11.AnaName
						, A12.AnaName
						, A13.AnaName 
						, A14.AnaName
						, A15.AnaName
						, A16.AnaName
						, A17.AnaName
						, A18.AnaName
						, A19.AnaName
						, A10.AnaName
						, Parameter01
						, Parameter02
						, Parameter03
						, Parameter04
						, Parameter05
						, Parameter06
						, Parameter07
						, Parameter08
						, Parameter09
						, Parameter10
						, OrderNo
						, OriginalDecimals
						, AT1012.ExchangeRate
						
				'
				
			PRINT(@sSQL)
			PRINT(@sSQL_1)
			PRINT(@sSQLGroupBy)
			PRINT(@sSQL1)
			PRINT(@sSQL2)
			PRINT(@sSQLWhere2)
			

			 EXEC (@sSQL + @sSQL_1 + @sSQLGroupBy + @sSQL1 + @sSQL2 + @sSQLWhere2 + @sSQL3 )
     END
			

			
			--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7405]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			--	EXEC ('  CREATE VIEW AV7405 AS ' + @sSQL + @sSQL1)
			--ELSE
			--	EXEC ('  ALTER VIEW AV7405  AS ' + @sSQL + @sSQL1)
End


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
