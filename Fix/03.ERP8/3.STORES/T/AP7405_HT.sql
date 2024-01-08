IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7405_HT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7405_HT]
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
---- Create on 10/05/2016 by Phan thanh hoàng vũ
---- Modified on 28/5/2019 by Kim Thư: Sửa store trả thẳng dữ liệu, ko qua view (cải thiện tốc độ)
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7405_HT]
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
					@StrDivisionID AS NVARCHAR(4000)
 AS
DECLARE @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQLUnionAll AS nvarchar(MAX),
		@SQLwhere AS nvarchar(MAX),
		@SQLwhereAna AS nvarchar(MAX),
		@sSQLOrderBy AS nvarchar(MAX),
		@TypeDate AS nvarchar(20),
		@SQLObject AS nvarchar(MAX),
		@sqlGroup AS nvarchar(MAX),
		@FromPeriod AS int,
		@ToPeriod AS int
		

		Declare @CustomerName INT
		--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		

		IF @TypeD = 1   --- Ngay HT
			SET @TypeDate ='InvoiceDate'
		ELSE IF @TypeD=2  --- Nga HD
			SET @TypeDate = 'VoucherDate'
		ELSE IF @TypeD=3   --Ngay Dao han
			SET @TypeDate = 'DueDate'

		SET @FromPeriod = (@FromMonth + @FromYear * 100)	
		SET @ToPeriod = (@ToMonth + @ToYear * 100)	

		--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_New AS NVARCHAR(4000)
		If @CustomerName = 51 --Customize khách hàng Hoàng trần
		begin
			IF isnull(@StrDivisionID, '') = Isnull(@DivisionID, '') 
				Set @StrDivisionID_New = ' and AV7404.DivisionID LIKE ''' + @DivisionID + '''' 
			ELSE 
				Set @StrDivisionID_New = ' and AV7404.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
		End
		Else
				Set @StrDivisionID_New = ' and AV7404.DivisionID LIKE ''' + @DivisionID + '''' 
		---------------<<<< Chuỗi DivisionID		
		
		


		IF @TypeD in (1, 2, 3)   -- Theo ngay
			SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),D3.' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' + CONVERT(varchar(10), @FromDate, 101) + ''' AND ''' + CONVERT(varchar(10), @ToDate, 101) + ''') '
		ELSE    ---Theo ky
			SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + str(@FromPeriod) + ' AND '+ str(@ToPeriod) + ')'
	
		------ Loc ra cac phan tu
		EXEC AP7404_HT  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere, @StrDivisionID

		------- Xac dinh so du co cac doi tuong
		EXEC AP7414_HT @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,'1=1', @StrDivisionID

		IF @TypeD = 4 ---  Tinh tu ky den ky	
			  BEGIN	
	
				SET @SQLwhere = '
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) between N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''') 
				and (ISNULL(AV7404.AccountID, AV7414.AccountID) between ''' + @FromAccountID+ ''' AND ''' + @ToAccountID + ''')'
				SET @SQLwhereAna ='
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''')
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
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) between N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''')
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7414.AccountID) between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') '
				SET @SQLwhereAna = '
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between N''' + @FromObjectID + ''' AND N''' + @ToObjectID + ''') 
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7424.AccountID) between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
	
				IF @CurrencyID <> '%'
					Begin
						SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) like ''' + @CurrencyID + ''' ' 
						SET @SQLwhereAna = @SQLwhereAna + ' AND ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) like ''' + @CurrencyID + ''' ' 
					End
			  END
		
	
		---In khong co ma phan tich 1
		SET @sSQL = '
			SELECT (ISNULL(AV7404.ObjectID, AV7414.ObjectID) + ISNULL(AV7404.AccountID, AV7414.AccountID)) AS GroupID,
				BatchID,VoucherID,TableID, Status,AV7404.DivisionID,TranMonth,TranYear, 
				Cast(ISNULL(AV7404.AccountID, AV7414.AccountID) AS char(20)) + 
				cast(ISNULL(AV7404.ObjectID, AV7414.ObjectID)  AS char(20)) + 
				cast(ISNULL(AV7404.CurrencyID,AV7414.CurrencyID) AS char(20)) + 
				cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
				Year(VoucherDate) * 10000 AS char(8)) + 
				cast(VoucherID AS char(20)) + 
				(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
				RPTransactionType,TransactionTypeID,
				ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS ObjectID,  
				ISNULL(AT1202.ObjectName,AV7414.ObjectName) AS ObjectName,
				AT1202.Address, AT1202.VATNo,
				DebitAccountID, CreditAccountID, 
				ISNULL(AV7404.AccountID, AV7414.AccountID) AS AccountID,
				ISNULL(AT1005.AccountName, AV7414.AccountName) AS AccountName,
				ISNULL(AT1005.AccountNameE, AV7414.AccountNameE) AS AccountNameE,
				VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate,Serial,VDescription, 
				ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,TDescription,
				ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CurrencyID,ExchangeRate,AV7404.CreateDate,
				Sum(Case When RPTransactionType = ''00'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS DebitOriginalAmount,
				Sum(Case When RPTransactionType = ''01'' then ISNULL(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
				Sum(Case When RPTransactionType = ''00'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
				Sum(Case When RPTransactionType = ''01'' then ISNULL(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
				ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
				ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
				sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,
				sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
				cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
				cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
				Parameter01, Parameter02,Parameter03, Parameter04,Parameter05, Parameter06,Parameter07, Parameter08,
				Parameter09, Parameter10	
		INTO #AV7415
		FROM	AV7404 
		LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7404.ObjectID
		FULL JOIN AV7414 on AV7414.ObjectID = AV7404.ObjectID AND AV7414.AccountID = AV7404.AccountID	
		LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7404.AccountID  AND AT1005.DivisionID = AV7404.DivisionID ' + @SQLwhere + '
		GROUP BY AV7404.DivisionID,BatchID, VoucherID, TableID, Status, AV7404.DivisionID, TranMonth, TranYear, 
				RPTransactionType, TransactionTypeID, AV7404.ObjectID, AV7414.ObjectID,
				DebitAccountID, CreditAccountID, AV7404.AccountID, AV7414.AccountID, 
				VoucherTypeID, VoucherNo, VoucherDate,AV7414.OpeningOriginalAmount, AV7414.OpeningConvertedAmount,
				InvoiceNo, InvoiceDate, Serial, VDescription,  BDescription, TDescription, 
				AV7404.CreateDate,AV7404.CurrencyID, AV7414.CurrencyID, ExchangeRate, AT1202.ObjectName, 
				AT1202.Address, AT1202.VATNo, 
				AV7414.ObjectName, AT1005.AccountName, AT1005.AccountNameE, AV7414.AccountName, AV7414.AccountNameE, Duedate,
				Parameter01, Parameter02,Parameter03, Parameter04,Parameter05, Parameter06,Parameter07, Parameter08,Parameter09, Parameter10 '
		SET @sSQL1 = '
			UNION ALL
			SELECT (ISNULL( AV7414.ObjectID, '''') + ISNULL( AV7414.AccountID, '''')) AS GroupID,
					NULL AS BatchID,NULL AS VoucherID,NULL as TableID,NULL as Status,
					NULL as DivisionID,
					NULL AS TranMonth,NULL AS TranYear, Cast(ISNULL(AV7414.AccountID , '''') AS char(20)) + 
					cast(ISNULL(AV7414.ObjectID, '''')  AS char(20)) + cast(ISNULL(AV7414.CurrencyID, '''') AS char(20))  AS Orders,
					NULL AS RPTransactionType,NULL AS TransactionTypeID,
					ISNULL( AV7414.ObjectID,'''') AS ObjectID,  ISNULL(AV7414.ObjectName , '''') AS ObjectName,
					AT1202.Address, AT1202.VATNo,NULL AS DebitAccountID, NULL AS CreditAccountID, 
					ISNULL(AV7414.AccountID, '''') AS AccountID,
					ISNULL(AV7414.AccountName, '''' ) AS AccountName,
					ISNULL(AV7414.AccountNameE, '''' ) AS AccountNameE,
					NULL AS VoucherTypeID,
					NULL AS VoucherNo,
					CONVERT(DATETIME, NULL) AS VoucherDate,
					NULL AS InvoiceNo,
					CONVERT(DATETIME, NULL) AS InvoiceDate,
					NULL AS Serial,
					NULL AS VDescription, 
					NULL AS BDescription,
					NULL AS TDescription,
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
					NULL as Parameter01, NULL as Parameter02,
					NULL as Parameter03, NULL as Parameter04,
					NULL as Parameter05, NULL as Parameter06,
					NULL as Parameter07, NULL as Parameter08,
					NULL as Parameter09, NULL as Parameter10
			FROM	AV7414 
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7414.ObjectID
			WHERE	AV7414.ObjectID + AV7414.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
			'
			
		--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7415]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		--	 EXEC ('  CREATE VIEW AV7415 AS ' + @sSQL + @sSQL1)
		--ELSE
		--	 EXEC ('  ALTER VIEW AV7415  AS ' + @sSQL + @sSQL1)
     

		SET @sSQL2 = ' SELECT
						 AV7415.GroupID,AV7415.BatchID,AV7415.VoucherID,AV7415.TableID,AV7415.Status,AV7415.DivisionID,AV7415.TranMonth,AV7415.TranYear,AV7415.RPTransactionType,AV7415.TransactionTypeID,
						AV7415.ObjectID,AV7415.ObjectName,AV7415.Address,AV7415.VATNo,AT1202.S1,AT1202.S2,AT1202.S3,AT1202.Tel,AT1202.Fax,AT1202.Email,
						AV7415.DebitAccountID,A01.AccountName AS DebitAccountName,AV7415.CreditAccountID, A02.AccountName AS CreditAccountName,
						AV7415.AccountID, AV7415.AccountName, AV7415.AccountNameE, AV7415.VoucherTypeID,AV7415.VoucherNo,AV7415.VoucherDate,AV7415.InvoiceNo,AV7415.InvoiceDate, AV7415.Serial,AV7415.VDescription,AV7415.BDescription,AV7415.TDescription,
						O01ID,	O02ID,	O03ID,	O04ID,	O05ID,AV7415.CurrencyID,AV7415.ExchangeRate,
						Sum(DebitOriginalAmount) AS DebitOriginalAmount,Sum(CreditOriginalAmount) AS CreditOriginalAmount,
						Sum(DebitConvertedAmount) AS DebitConvertedAmount,Sum(CreditConvertedAmount) AS CreditConvertedAmount,
						OpeningOriginalAmount,OpeningConvertedAmount,
						sum(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount,sum(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount,
						ClosingOriginalAmount,ClosingConvertedAmount ,
						CAST (AV7415.TranMonth AS Varchar)  + ''/'' + CAST (AV7415.TranYear AS Varchar) AS MonthYear,
						CONVERT(varchar(20), AV7415.Duedate, 103) AS duedate,
						''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate,
						(case when' + str(@TypeD) + ' = 0 then ''30/' + Ltrim (str(@ToMonth)) + '/' + ltrim(str(@ToYear)) + ''' ELSE ''' + CONVERT(varchar(10), @ToDate,103) + ''' end) AS Todate,
						Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10
				FROM #AV7415 AV7415 
				INNER JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7415.ObjectID
				LEFT JOIN AT1005 A01 WITH (NOLOCK) on A01.AccountID  = AV7415.DebitAccountID AND A01.DivisionID  = AV7415.DivisionID
				LEFT JOIN AT1005 A02 WITH (NOLOCK) on A02.AccountID  = AV7415.CreditAccountID AND A02.DivisionID  = AV7415.DivisionID
				WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
						OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
						OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0  AND '+@SqlFind+')
			
				GROUP BY AV7415.GroupID, AV7415.BatchID,AV7415.VoucherID, AV7415.TableID,AV7415.Status,AV7415.DivisionID, AV7415.TranMonth, AV7415.TranYear, 
						AV7415.RPTransactionType, AV7415.TransactionTypeID, AV7415.ObjectID, 
						AV7415.Address, AV7415.VATNo,  
						AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
						AV7415.DebitAccountID, AV7415.CreditAccountID,
						AV7415. AccountID, 
						AV7415.VoucherTypeID, AV7415.VoucherNo, AV7415.VoucherDate, AV7415.OpeningOriginalAmount, AV7415.OpeningConvertedAmount,
						AV7415.InvoiceNo, AV7415.InvoiceDate, AV7415.Serial, AV7415.VDescription,  AV7415.BDescription, AV7415.TDescription, 
						O01ID,O02ID,O03ID, O04ID,O05ID,
						AV7415.CurrencyID, AV7415.ExchangeRate, AV7415.ObjectName, 
						AV7415. AccountName, AV7415. AccountNameE, ClosingOriginalAmount, ClosingConvertedAmount, 
						A01.AccountName,  A02.AccountName,AV7415.Duedate,
						Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10'

		SET @sSQLOrderBy = '
		ORDER BY  AV7415.GroupID, AV7415.ObjectID, AV7415.VoucherDate, AV7415.VoucherNo'

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQLOrderBy)				
--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7405]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--	EXEC ('  CREATE VIEW AV7405 AS ' + @sSQL )
--ELSE
--	EXEC ('  ALTER VIEW AV7405  AS ' + @sSQL )



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
