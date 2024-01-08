IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7408_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7408_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- In chi tiet cong no phai tra
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-----Created by Nguyen Van Nhan, Date 29/08/2003
---- Modified on 07/04/2021 by Huỳnh Thử : [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 02/06/2021 by Huỳnh Thử : [TienTien] -- Bổ sung BDescription
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- exec AP7408 @DivisionID=N'AS',@FromMonth=1,@FromYear=2013,@ToMonth=1,@ToYear=2013,@TypeD=4,@FromDate='2013-05-27 08:44:55.65',@ToDate='2013-05-27 08:44:55.65',@CurrencyID=N'VND',@FromAccountID=N'3111',@ToAccountID=N'3562',@FromObjectID=N'0000000001',@ToObjectID=N'SZ.0001'

CREATE PROCEDURE [dbo].[AP7408_TienTien]
					@DivisionID AS nvarchar(50),
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
					@SqlFind AS NVARCHAR(MAX),
					@DatabaseName as nvarchar(250) ='',
					@StrDivisionID AS NVARCHAR(4000) = null,
					@ReportDate AS DATETIME = NULL
 AS
Declare @sqlSelect nvarchar(Max),
		@sqlFrom nvarchar(Max),
        @sqlGroupBy nvarchar(Max);
Declare @sqlSelect1 nvarchar(Max),
		@sqlFrom1 nvarchar(Max),
        @sqlGroupBy1 nvarchar(Max);
Declare @sSQL AS nvarchar(Max),
		@SQLwhere AS nvarchar(Max),
		@SQLwhere1 AS nvarchar(Max),
		@sSQLUnion AS nvarchar(Max),
		@sSQLUnion1 AS nvarchar(Max),
		@SQLwhereAna AS nvarchar(Max),
		@TypeDate AS nvarchar(50),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@TmpDivisionID AS nvarchar(50),
        @SQLWhereAna04_CBD01 AS nvarchar(50) = '',
        @SQLWhereAna04_CBD02 AS nvarchar(50) = '',
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


Begin	
	
		
						IF @TypeD = 1 	---- Ngay Hoa don
							SET @TypeDate = 'InvoiceDate'
						ELSE IF @TypeD = 2 	---- Ngay chung tu
							SET @TypeDate = 'VoucherDate'
							   ELSE IF @TypeD = 3 	---- Theo Ngay dao han
								SET @TypeDate = 'DueDate'

						SET @FromPeriod = (@FromMonth + @FromYear * 100)	
						SET @ToPeriod = (@ToMonth + @ToYear * 100)	

						IF @TypeD in (1, 2, 3)   -- Theo ngay	
							SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' +	CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101)+''')  '
						ELSE    ---Theo ky
							SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + str(@FromPeriod) + ' AND ' + str(@ToPeriod) + ') '

						----------	 Xac dinh so phat sinh
						EXEC AP7407  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere, @StrDivisionID

						----------	  Xac dinh so du 
						EXEC AP7417 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,@SqlFind, @StrDivisionID

						BEGIN 

						SET @SQLwhere = '
							WHERE (isnull(AV7407.ObjectID, AV7417.ObjectID) between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')  and (isnull(AV7407.AccountID, AV7417.AccountID) between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''')  '
		
						SET @SQLwhereAna = '
							WHERE (isnull(AV7407.ObjectID, AV7427.ObjectID) between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')  and (isnull(AV7407.AccountID, AV7427.AccountID) between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''') '
		
						END 

		
						IF @CurrencyID <> '%'
							BEGIN
								SET @SQLwhere = @SQLwhere + ' and  isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) like  ''' + @CurrencyID + '''  ' 
								SET @SQLwhereAna = @SQLwhereAna + ' and  isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) like ''' + @CurrencyID + '''  ' 
							END

							--Khong co ma phan tich
							SET @sqlSelect = N'
							SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
									BatchID,
									VoucherID,
									AV7407.TableID, AV7407.Status,
									isnull(AV7407.DivisionID,AV7417.DivisionID) as DivisionID,
									TranMonth,
									TranYear, 
									Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
									RPTransactionType , TransactionTypeID,
									Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
									isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
									AT1202.Note,
									AT1202.Address, AT1202.VATNo,AT1202.Contactor,
									AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
									AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
									DebitAccountID, CreditAccountID, 
									Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
									Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
									VoucherTypeID,
									VoucherNo,
									VoucherDate,
									InvoiceNo,
									InvoiceDate,
									Serial,
									VDescription,
									ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,
									TDescription, 
									AV7407.Ana01ID,
									AV7407.Ana02ID,
									AV7407.Ana03ID,
									AV7407.Ana04ID,
									AV7407.Ana05ID,
									AV7407.Ana06ID,
									AV7407.Ana07ID,
									AV7407.Ana08ID,
									AV7407.Ana09ID,
									AV7407.Ana10ID,
									AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
									isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
									ExchangeRate,
									AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
									Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
									Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
									isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
									isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
									cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
									cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
									AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID '
			
						SET @sqlFrom  = ' 
							FROM		AV7407 WITH (NOLOCK) 
							FULL JOIN	AV7417 WITH (NOLOCK) ON AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID '+ @SQLWhereAna04_CBD01 +'
							LEFT JOIN 	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = Isnull(AV7407.ObjectID, AV7417.ObjectID) --AV7407.ObjectID 
							LEFT JOIN	AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV7407.AccountID ' 
							SET @sqlWhere  = @SQLwhere
							SET @sqlGroupBy =' 
							GROUP BY 	BatchID, VoucherID, AV7407.TableID, AV7407.Status, AV7407.DivisionID,AV7417.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7417.ObjectID,
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, AV7407.AccountID, AV7417.AccountID, 
										VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
										InvoiceNo, InvoiceDate, Serial, VDescription, BDescription,  TDescription,
										AV7407.Ana01ID,
										AV7407.Ana02ID,
										AV7407.Ana03ID,
										AV7407.Ana04ID,
										AV7407.Ana05ID,
										AV7407.Ana06ID,
										AV7407.Ana07ID,
										AV7407.Ana08ID,
										AV7407.Ana09ID,
										AV7407.Ana10ID,
										AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
										AV7407.CurrencyIDCN, AV7417.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
										AV7417.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7417.AccountName,Duedate,
										AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10 ,AV7407.Amount01Ana04ID '
							-- Lấy số dư của đối tường mà không có phát sinh trong kỳ
								--Khong co ma phan tich
							
								SET @sqlSelect1 = ' 
								UNION 
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
									BatchID,
									VoucherID,
									TableID, Status,
									AV7417.DivisionID,
									TranMonth,
									TranYear, 
									Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
									RPTransactionType , TransactionTypeID,
									Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
									isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
									AT1202.Note,
									AT1202.Address, AT1202.VATNo,AT1202.Contactor,
									AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
									AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
									DebitAccountID, CreditAccountID, 
									Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
									Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
									VoucherTypeID,
									VoucherNo,
									VoucherDate,
									InvoiceNo,
									InvoiceDate,
									Serial,
									--NULL AS VDescription,
									--NULL AS BDescription,
									--NULL AS TDescription,
									AV7407.VDescription,
									ISNULL(TDescription,ISNULL(BDescription,VDescription)) AS BDescription,
									AV7407.TDescription,
									--convert(varchar,AV7417.Ana01ID),
									--convert(varchar,AV7417.Ana02ID),
									--convert(varchar,AV7417.Ana03ID),
									--convert(varchar,AV7417.Ana04ID),
									--convert(varchar,AV7417.Ana05ID),
									--convert(varchar,AV7417.Ana06ID),
									--convert(varchar,AV7417.Ana07ID),
									--convert(varchar,AV7417.Ana08ID),
									--convert(varchar,AV7417.Ana09ID),
									--convert(varchar,AV7417.Ana10ID),
			
									Cast (AV7407.Ana01ID as nvarchar(50)),
									Cast (AV7407.Ana02ID as nvarchar(50)),
									Cast (AV7407.Ana03ID as nvarchar(50)),
									Cast (AV7407.Ana04ID as nvarchar(50)),
									Cast (AV7407.Ana05ID as nvarchar(50)),
									Cast (AV7407.Ana06ID as nvarchar(50)),
									Cast (AV7407.Ana07ID as nvarchar(50)),
									Cast (AV7407.Ana08ID as nvarchar(50)),
									Cast (AV7407.Ana09ID as nvarchar(50)),
									Cast (AV7407.Ana10ID as nvarchar(50)),
									AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
									isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
									ExchangeRate,
									AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
									Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
									Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
									isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
									isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
									cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
									cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
									AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID'
								SET @sqlFrom1  = ' 
								FROM AV7417 WITH (NOLOCK)
								LEFT JOIN AV7407 WITH (NOLOCK) on AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID ' + @SQLWhereAna04_CBD01 + '
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7417.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7417.AccountID ' 
								SET @sqlGroupBy1 =' 
								GROUP BY	BatchID, VoucherID, TableID, Status, AV7417.DivisionID, TranMonth, TranYear, 
											RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7417.ObjectID,
											AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
											AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
											DebitAccountID, CreditAccountID, AV7407.AccountID, AV7417.AccountID, 
											VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
											InvoiceNo, InvoiceDate, Serial,--- VDescription, BDescription,  TDescription,
											AV7407.Ana01ID,
											AV7407.Ana02ID,
											AV7407.Ana03ID,
											AV7407.Ana04ID,
											AV7407.Ana05ID,
											AV7407.Ana06ID,
											AV7407.Ana07ID,
											AV7407.Ana08ID,
											AV7407.Ana09ID,
											AV7407.Ana10ID,
											AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
											AV7407.CurrencyIDCN, AV7417.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
											AV7417.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7417.AccountName,Duedate,
											AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID,
											AV7407.TDescription, AV7407.BDescription, AV7407.VDescription'

						IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7418]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
							 EXEC ('  CREATE VIEW AV7418 	--Created by AP7408
								AS ' +  @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy +  
								@sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)
						ELSE
							 EXEC ('  ALTER VIEW AV7418  	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy + 
								@sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)

						--      PRINT @sqlSelect
						--		PRINT @sqlFrom
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy
						--		PRINT @sqlSelect1
						--		PRINT @sqlFrom1
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy1



								--In co ma phan tich
								SET @sqlSelect='
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7427.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7427.AccountID)))) AS GroupID,
										BatchID,
										VoucherID,
										AV7407.TableID, AV7407.Status,
										AV7407.DivisionID,
										TranMonth,
										TranYear, 
										Cast(Isnull(AV7407.AccountID, AV7427.AccountID)  AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7427.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
										RPTransactionType , TransactionTypeID,
										Isnull(AV7407.ObjectID, AV7427.ObjectID) AS ObjectID,
										isnull(AT1202.ObjectName,AV7427.ObjectName)  AS ObjectName,
										AT1202.Note,
										AT1202.Address,
										AT1202.VATNo,
										AT1202.Contactor,
										AT1202.S1, 
										AT1202.S2,
										AT1202.S3, 
										AT1202.Tel,
										AT1202.Fax, 
										AT1202.Email,
										AT1202.O01ID,
										AT1202.O02ID,
										AT1202.O03ID,
										AT1202.O04ID,
										AT1202.O05ID,
										DebitAccountID,
										CreditAccountID, 
										Isnull(AV7407.AccountID, AV7427.AccountID) AS AccountID, 
										Isnull(AT1005.AccountName, AV7427.AccountName) AS AccountName,
										VoucherTypeID,
										VoucherNo,
										VoucherDate,
										InvoiceNo,
										InvoiceDate,
										Serial,
										VDescription,
										ISNULL(TDescription,ISNULL(BDescription,VDescription)) as BDescription,
										TDescription,
										Isnull(AV7407.Ana01ID,AV7427.Ana01ID) AS Ana01ID,
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS CurrencyID,
										ExchangeRate,
										AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
										Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
										Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
										isnull(OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
										isnull(OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
										isnull(AV7427.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
										isnull(AV7427.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
										cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
										cast(0 as decimal(28,8)) AS ClosingConvertedAmount '
								SET @sqlFrom = ' 
								FROM AV7407 WITH (NOLOCK)
								FULL JOIN AV7427 WITH (NOLOCK) on AV7427.ObjectID = AV7407.ObjectID and AV7427.AccountID = AV7407.AccountID and AV7427.Ana01ID = AV7407.Ana01ID and AV7427.DivisionID = AV7407.DivisionID
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = Isnull(AV7407.ObjectID, AV7427.ObjectID) --AV7407.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7407.AccountID ' 
								SET @sqlWhere = @SQLwhereAna
								SET @sqlGroupBy = ' 
								GROUP BY BatchID, VoucherID, AV7407.TableID, AV7407.Status, AV7407.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7427.ObjectID,
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, AV7407.AccountID, AV7427.AccountID, 
										VoucherTypeID, VoucherNo, VoucherDate, AV7427.OpeningOriginalAmount,AV7427.OpeningConvertedAmount, AV7427.OpeningOriginalAmountAna01ID, AV7427.OpeningConvertedAmountAna01ID,
										InvoiceNo, InvoiceDate, Serial, VDescription, BDescription,  TDescription,
										AV7427.Ana01ID, AV7407.Ana01ID, 
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										AV7407.CurrencyIDCN, AV7427.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
										AV7427.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7427.AccountName '
							-- Lấy số dư của đối tường mà không có phát sinh trong kỳ
								--In co ma phan tich
								SET @sqlSelect1=' 
								UNION
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7427.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7427.AccountID)))) AS GroupID,
										BatchID,
										VoucherID,
										TableID, Status,
										AV7427.DivisionID,
										TranMonth,
										TranYear, 
										Cast(Isnull(AV7407.AccountID, AV7427.AccountID)  AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7427.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
										RPTransactionType , TransactionTypeID,
										Isnull(AV7407.ObjectID, AV7427.ObjectID) AS ObjectID,
										isnull(AT1202.ObjectName,AV7427.ObjectName)  AS ObjectName,
										AT1202.Note,
										AT1202.Address,
										AT1202.VATNo,
										AT1202.Contactor,
										AT1202.S1, 
										AT1202.S2,
										AT1202.S3, 
										AT1202.Tel,
										AT1202.Fax, 
										AT1202.Email,
										AT1202.O01ID,
										AT1202.O02ID,
										AT1202.O03ID,
										AT1202.O04ID,
										AT1202.O05ID,
										DebitAccountID,
										CreditAccountID, 
										Isnull(AV7407.AccountID, AV7427.AccountID) AS AccountID, 
										Isnull(AT1005.AccountName, AV7427.AccountName) AS AccountName,
										VoucherTypeID,
										VoucherNo,
										VoucherDate,
										InvoiceNo,
										InvoiceDate,
										Serial,
										AV7407.VDescription,
										ISNULL(TDescription,ISNULL(BDescription,VDescription)) as BDescription,
										AV7407.TDescription,
										--NULL as VDescription,
										--NULL as BDescription,
										--NULL as TDescription,
										Isnull(AV7407.Ana01ID,AV7427.Ana01ID) AS Ana01ID,
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS CurrencyID,
										ExchangeRate,
										AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
										Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
										Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
										isnull(OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
										isnull(OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
										isnull(AV7427.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
										isnull(AV7427.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
										cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
										cast(0 as decimal(28,8)) AS ClosingConvertedAmount '
								SET @sqlFrom1 = ' 
								FROM AV7427 WITH (NOLOCK) 
								LEFT JOIN AV7407 WITH (NOLOCK) on AV7427.ObjectID = AV7407.ObjectID and AV7427.AccountID = AV7407.AccountID And AV7427.DivisionID = AV7407.DivisionID
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7427.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7427.AccountID ' 
								SET @sqlGroupBy1 = ' 
								GROUP BY BatchID, VoucherID, TableID, Status, AV7427.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7427.ObjectID,
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, AV7407.AccountID, AV7427.AccountID, 
										VoucherTypeID, VoucherNo, VoucherDate, AV7427.OpeningOriginalAmount,AV7427.OpeningConvertedAmount, AV7427.OpeningOriginalAmountAna01ID, AV7427.OpeningConvertedAmountAna01ID,
										InvoiceNo, InvoiceDate, Serial,--- VDescription, BDescription,  TDescription,
										AV7427.Ana01ID, AV7407.Ana01ID, 
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										AV7407.CurrencyIDCN, AV7427.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
										AV7427.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7427.AccountName,AV7407.TDescription,AV7407.BDescription,AV7407.VDescription '

						IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7428]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
							 EXEC ('  CREATE VIEW AV7428 	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy
								+  @sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)
						ELSE
							 EXEC ('  ALTER VIEW AV7428  	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy
								+  @sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)

						--PRINT @sqlSelect
						--		PRINT @sqlFrom
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy
						--		PRINT @sqlSelect1
						--		PRINT @sqlFrom1
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy1


						--Khong co ma phan tich
					
							SET @sqlSelect =' SELECT  '


						SET @sqlSelect = @sqlSelect + '
							GroupID,BatchID,VoucherID,TableID, Status,V18.DivisionID,V18.TranMonth,V18.TranYear,RPTransactionType,TransactionTypeID,
							ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = V18.ObjectID) Note,V18.Address,V18.VATNo,Contactor,S1,S2,S3,V18.Tel,V18.Fax,V18.Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
							AccountID,AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = V18.DivisionID AND AccountID = V18.AccountID) AccountNameE,
							VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription
							,TDescription,
							Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
							Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,V18.CurrencyID,V18.ExchangeRate, 
							Sum(isnull(DebitOriginalAmount, 0)) AS DebitOriginalAmount,Sum(isnull(CreditOriginalAmount, 0)) AS CreditOriginalAmount,
							Sum(isnull(DebitConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1))  AS DebitConvertedAmount,Sum(isnull(CreditConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1))  AS CreditConvertedAmount,
							OpeningOriginalAmount,	OpeningConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS OpeningConvertedAmount,
							sum(isnull(SignConvertedAmount, 0) * ISNULL(AT1012.ExchangeRate, 1))  AS SignConvertedAmount,sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
							ClosingOriginalAmount,ClosingConvertedAmount * ISNULL(AT1012.ExchangeRate, 1) AS ClosingConvertedAmount,
							CAST (V18.TranMonth AS nvarchar)  + ''/'' + CAST (V18.TranYear AS nvarchar) AS MonthYear,
							convert (varchar(20), Duedate,103) AS duedate,
							''' + convert(varchar(10), @FromDate, 103) + ''' AS Fromdate,
							(case when' + str(@TypeD) + '= 4 then ''30/' + Ltrim (str(@ToMonth)) 
							+ '/'+ltrim(str(@ToYear)) + ''' ELSE ''' + convert(varchar(10), @ToDate, 103) + ''' end) AS Todate,
							Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,Amount01Ana04ID '
						SET @sqlFrom = ' 
						FROM AV7418 V18 WITH (NOLOCK)				
						LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = V18.DivisionID
						LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''	
						'
						SET @sqlWhere = ' 
						WHERE	DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 OR DebitConvertedAmount <> 0 
								OR CreditConvertedAmount <> 0 OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0  '
						SET @sqlGroupBy = ' 
						GROUP BY GroupID, BatchID,VoucherID, TableID, Status, V18.DivisionID, V18.TranMonth, V18.TranYear, RPTransactionType, TransactionTypeID, 
								ObjectID, ObjectName,Note, V18.Address,V18. VATNo,Contactor,S1,S2, S3, V18.Tel, V18.Fax, V18.Email,O01ID, O02ID, O03ID, O04ID, O05ID,
								DebitAccountID, CreditAccountID, AccountID, 
								VoucherTypeID, VoucherNo, VoucherDate, OpeningOriginalAmount, OpeningConvertedAmount,
								InvoiceNo, InvoiceDate, Serial, VDescription, BDescription
								, TDescription, 
								Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
								V18.CurrencyID, V18.ExchangeRate, ObjectName, AccountName, ClosingOriginalAmount, ClosingConvertedAmount,Duedate,
								Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,
								Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,Amount01Ana04ID,
								AT1012.ExchangeRate
						'
     
						--Co ma phan tich
						
						SET @sqlSelect1 =' SELECT  '
 

						SET @sqlSelect1 = @sqlSelect1 + '
							GroupID,BatchID,VoucherID,TableID, Status,AV7428.DivisionID,AV7428.TranMonth,AV7428.TranYear,RPTransactionType,TransactionTypeID,
							AV7428.ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = AV7428.ObjectID) Note,AV7428.Address,AV7428.VATNo,Contactor,S1,S2,S3,AV7428.Tel,AV7428.Fax,AV7428.Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,	CreditAccountID,
							AV7428.AccountID, AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7428.DivisionID AND AccountID = AV7428.AccountID) AccountNameE,
							VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription ,BDescription
							,TDescription,
							AV7428.Ana01ID,AV7428.Ana02ID,AV7428.Ana03ID,AV7428.Ana04ID,AV7428.Ana05ID,AV7428.Ana06ID,AV7428.Ana07ID,AV7428.Ana08ID,AV7428.Ana09ID,AV7428.Ana10ID,
							A11.AnaName AS Ana01Name,AV7428.CurrencyID,AV7428.ExchangeRate, 
							Sum(isnull(DebitOriginalAmount, 0)) AS DebitOriginalAmount,Sum(isnull(CreditOriginalAmount, 0)) AS CreditOriginalAmount,
							Sum(isnull(DebitConvertedAmount, 0)* ISNULL(AT1012.ExchangeRate, 1))  AS DebitConvertedAmount,Sum(isnull(CreditConvertedAmount, 0)* ISNULL(AT1012.ExchangeRate, 1))  AS CreditConvertedAmount,
							OpeningOriginalAmount,OpeningConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS OpeningConvertedAmount,OpeningOriginalAmountAna01ID,OpeningConvertedAmountAna01ID   * ISNULL(AT1012.ExchangeRate, 1) AS OpeningConvertedAmountAna01ID ,
							sum(isnull(SignConvertedAmount,0)* ISNULL(AT1012.ExchangeRate, 1))  AS SignConvertedAmount,sum(isnull(SignOriginalAmount,0)) AS SignOriginalAmount,
							ClosingOriginalAmount,ClosingConvertedAmount  * ISNULL(AT1012.ExchangeRate, 1) AS ClosingConvertedAmount, 
							CAST(AV7428.TranMonth AS nvarchar) + ''/'' + CAST(AV7428.TranYear AS nvarchar) AS MonthYear '
						SET @sqlFrom1 = ' 
						FROM AV7428	WITH (NOLOCK)
						LEFT JOIN AT1011 A11 WITH (NOLOCK) on A11.AnaID=AV7428.Ana01ID And A11.AnaTypeID = ''A01''			
						LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7428.DivisionID
						LEFT JOIN AT1012 WITH (NOLOCK) ON AT1012.CurrencyID = AT1101.BaseCurrencyID 
										AND AT1012.DivisionID = '''+@ReportDivisionID+'''
										AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AT1012.ExchangeDate,101),101) = '''+ CONVERT(NVARCHAR(10), @ReportDate ,101)+'''			
						'

						SET @sqlWhere1 = ' 
						WHERE DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
							OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
							OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0 '
						SET @sqlGroupBy1 = ' 
						GROUP BY GroupID, BatchID,VoucherID, TableID, Status, AV7428.DivisionID, AV7428.TranMonth, AV7428.TranYear, RPTransactionType, TransactionTypeID, AV7428.ObjectID, 
							AV7428.Address, AV7428.VATNo,Contactor,S1,S2, S3, AV7428.Tel, AV7428.Fax, AV7428.Email,O01ID, O02ID, O03ID, O04ID, O05ID,DebitAccountID, CreditAccountID, AV7428.AccountID, 
							VoucherTypeID, VoucherNo, VoucherDate, OpeningOriginalAmount, 
							OpeningConvertedAmount, OpeningOriginalAmountAna01ID, OpeningConvertedAmountAna01ID,
							InvoiceNo, InvoiceDate, Serial, VDescription, BDescription
							, TDescription, 
							AV7428.Ana01ID,AV7428.Ana02ID,AV7428.Ana03ID,AV7428.Ana04ID,AV7428.Ana05ID,AV7428.Ana06ID,AV7428.Ana07ID,AV7428.Ana08ID,AV7428.Ana09ID,AV7428.Ana10ID,
							A11.AnaName, AV7428.CurrencyID, AV7428.ExchangeRate, ObjectName, Note, ObjectName, AccountName, ClosingOriginalAmount, ClosingConvertedAmount, AT1012.ExchangeRate
						'

							BEGIN
	
								--PRINT '-- @sqlSelect'+ @sqlSelect
								--PRINT '-- @sqlFrom'+@sqlFrom
								--PRINT '-- @sqlWhere'+@sqlWhere
								--PRINT '-- @sqlGroupBy'+@sqlGroupBy
								--PRINT '-- @sSQLUnion'+@sSQLUnion

								PRINT '-- @sqlSelect'+ @sqlSelect
								PRINT '-- @sqlFrom'+@sqlFrom
								PRINT '-- @sqlWhere'+@sqlWhere
								PRINT '-- @sqlGroupBy'+@sqlGroupBy
								PRINT '-- @sSQLUnion'+@sSQLUnion

								PRINT '-- @sqlSelect'+ @sqlSelect1
								PRINT '-- @sqlFrom'+@sqlFrom1
								PRINT '-- @sqlWhere'+@sqlWhere1
								PRINT '-- @sqlGroupBy'+@sqlGroupBy1
								PRINT '-- @sSQLUnion'+@sSQLUnion1
									--Khong co ma phan tich		
									IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7408]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
										 EXEC ('  CREATE VIEW AV7408 --Created by AP7408
										 AS '  + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy +  @sSQLUnion )
									ELSE
										 EXEC ('  ALTER VIEW AV7408  --Created by AP7408
										 AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy + @sSQLUnion)		
					 
									--Co ma phan tich			
									IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7429]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
										EXEC ('  CREATE VIEW AV7429 --Created by AP7408
										AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
									ELSE
										EXEC ('  ALTER VIEW AV7429  --Created by AP7408
										AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
								END	
	
		End

		--print @sqlSelect
		--print @sqlFrom
		--print @sqlWhere
		--print @sqlGroupBy
		--print @sSQLUnion







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
