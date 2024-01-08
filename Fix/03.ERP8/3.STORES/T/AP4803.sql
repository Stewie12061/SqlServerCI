IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP4803]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP4803]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Bao cao phan tich cong no phai thu khach hang sieu thi (ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 03/11/2004 by Hải Long
---- Modified by Tieu Mai on 29/11/2016: Fix lay chua dung theo yeu cau Angel
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhật Thanh on 19/04/2022: Bổ sung tính toán mới cho angel
-- <Example>
---- exec AP4803 'ANG','KCH.BCH.0002','KCH.BCH.0002','131','1318','VND','NT01','20190814'

CREATE PROCEDURE [dbo].[AP4803]
( 
				@DivisionID AS nvarchar(50), 
				@FromObjectID  AS nvarchar(50),  
				@ToObjectID  AS nvarchar(50),  
				@FromAccountID  AS nvarchar(50),  
				@ToAccountID  AS nvarchar(50),  
				@CurrencyID AS nvarchar(50),
				@DebtAgeStepID AS nvarchar(50),  	
				@ReportDate AS Datetime
) 
AS 
Declare @sSQL AS nvarchar(MAX),
		@sSQL0 AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL1_1 AS nvarchar(MAX),
		@sSQL1_2 AS nvarchar(MAX),		
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@sSQL4 AS nvarchar(MAX),
		@sSQL5 AS nvarchar(MAX),
		@sSELECT1 AS nvarchar(MAX),
		@GetColumnTitle AS tinyint,
		@AT1206Cursor AS cursor,
		@Description AS nvarchar(250),
		@Orders AS tinyint,
		@FromDay AS int,
		@ToDay AS int,
		@Title AS nvarchar(250),
		@ColumnCount AS int,
		@MaxDate AS int,
		@MinDate AS INT,
		@FromMonth INT,
		@FromYear INT
		
SET @sSELECT1 = ''

SET @FromMonth = MONTH(@ReportDate)
SET @FromYear = YEAR(@ReportDate)

--Lay thong tin thiet lap bao cao tu bang AT4710
SET @GetColumnTitle = 0

--- Lay tong hop cong no
exec AP7403 @DivisionID,@FromMonth,@FromYear,@FromMonth,@FromYear,2,@ReportDate,@ReportDate,@CurrencyID,@FromAccountID,@ToAccountID,@FromObjectID,@ToObjectID,0,N'',N''

--Lấy công nợ phải trả
--- Lấy dữ liệu giải trừ theo chứng từ PS Nợ
SET @sSQL = N' 
	SELECT 	DISTINCT AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, 
			AT0303.DebitVoucherID  AS VoucherID, 
			AT0303.DebitBatchID AS BatchID,
			SUM(ISNULL(AT0303.OriginalAmount,0)) AS GivedOriginalAmount,
			SUM(ISNULL(AT0303.ConvertedAmount,0)) AS GivedConvertedAmount,
			AT0303.DivisionID
	INTO #TEMP1			
	FROM AT0303 WITH (NOLOCK)
	WHERE	AT0303.DivisionID = ''' + @DivisionID + ''' AND
			AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),ISNULL(AT0303.CreditVoucherDate,''01/01/1900''),101), 101)  <= '''+CONVERT(nvarchar(10),@ReportDate,101)+'''
			AND CONVERT(DATE,CONVERT(VARCHAR(10), AT0303.GiveUpDate, 101)) <= ''' + CONVERT(varchar(10),@ReportDate,101)+'''
	GROUP BY AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, AT0303.DebitVoucherID, 
				AT0303.DebitBatchID, AT0303.DivisionID'

--- Lấy dữ liệu giải trừ theo chứng từ PS Có
SET @sSQL0 = N' 
	SELECT 	DISTINCT AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, 
			AT0303.CreditVoucherID AS VoucherID, 
			AT0303.CreditBatchID AS BatchID,
			SUM(ISNULL(AT0303.OriginalAmount,0)) AS GivedOriginalAmount,
			SUM(ISNULL(AT0303.ConvertedAmount,0)) AS GivedConvertedAmount,
			AT0303.DivisionID
	INTO #TEMP11			
	FROM AT0303 WITH (NOLOCK)
	WHERE	AT0303.DivisionID = ''' + @DivisionID + ''' AND
			AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),ISNULL(AT0303.CreditVoucherDate,''01/01/1900''),101), 101)  <= '''+CONVERT(nvarchar(10),@ReportDate,101)+'''
			AND CONVERT(DATE,CONVERT(VARCHAR(10), AT0303.GiveUpDate, 101)) <= ''' + CONVERT(varchar(10),@ReportDate,101)+'''
	GROUP BY AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, AT0303.CreditVoucherID, 
				AT0303.CreditBatchID, AT0303.DivisionID;'

--Tao #TEMP2 de lay du lieu len bao cao
SET @sSQL1 = N'
WITH AV4301_CTE
AS
(
	SELECT DivisionID, ObjectID, ObjectName, AccountID, ISNULL(DueDate,VoucherDate) AS DueDate, CurrencyID, 
			VoucherID, VoucherNo, BatchID, CurrencyIDCN, VoucherDate, O02ID,Max(DParameter03) AS DParameter03,
			SUM(ConvertedAmount) AS ConvertedAmount, 
			SUM(OriginalAmount) AS OriginalAmount,  
			SUM(OriginalAmountCN) AS OriginalAmountCN, O01ID, Note
		FROM AV4301
		WHERE DivisionID = ''' + @DivisionID + ''' AND
			AV4301.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			AV4301.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND 
			D_C=''D'' AND CONVERT(DATE,AV4301.VoucherDate,101) <= '''+LTRIM(CONVERT(DATE,@ReportDate,101))+''' AND 
			TransactionTypeID not in (''T09'',''T10'',''T14'')
		GROUP BY DivisionID, ObjectID, ObjectName, AccountID, ISNULL(DueDate,VoucherDate), CurrencyID, 
			VoucherID, VoucherNo, BatchID, CurrencyIDCN, VoucherDate, O02ID, O01ID, Note
)'

SET @sSQL1_1 = N'
SELECT	AV4301.DivisionID, AV4301.ObjectID, AV4301.ObjectName, AV4301.AccountID, NULL AS CorAccountID,
		AV4301.DueDate, AV4301.CurrencyID, 
		AV4301.VoucherID, AV4301.VoucherNo, AV4301.BatchID,
		ISNULL(A.GivedOriginalAmount,0) AS GivedOriginalAmount,
		ISNULL(A.GivedConvertedAmount,0) AS GivedConvertedAmount,
		AV4301.ConvertedAmount + (CASE WHEN AV4301.IsTax = 1 THEN 0
									ELSE ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 WITH (NOLOCK) WHERE DivisionID = AV4301.DivisionID
													AND TransactionTypeID = ''T14'' AND VoucherID = AV4301.VoucherID),0)
									END) AS ConvertedAmount,
		AV4301.OriginalAmount + (CASE WHEN AV4301.IsTax = 1 THEN 0
									ELSE ISNULL((SELECT SUM(OriginalAmount) FROM AT9000 WITH (NOLOCK) WHERE DivisionID = AV4301.DivisionID
													AND TransactionTypeID = ''T14'' AND VoucherID = AV4301.VoucherID),0)
									END) AS OriginalAmount, 
		AV4301.OriginalAmountCN + (CASE WHEN AV4301.IsTax = 1 THEN 0
									ELSE ISNULL((SELECT SUM(OriginalAmountCN) FROM AT9000 WITH (NOLOCK) WHERE DivisionID = AV4301.DivisionID
													AND TransactionTypeID = ''T14'' AND VoucherID = AV4301.VoucherID),0)
									END) AS OriginalAmountCN,	
		0 AS CreditConvertAmount,
		AV4301.CurrencyIDCN, AV4301.VoucherDate, AV4301.O02ID,
		AV4301.DParameter03, AV4301.O01ID, AV4301.Note
INTO #TEMP2		
FROM (	--- Lấy các dòng bán hàng định khoản Nợ 131
		SELECT *, 0 AS IsTax FROM AV4301_CTE
		UNION	--- Lấy các dòng VAT định khoản Nợ 131 nhưng dòng bán hàng gốc không định khoản Nợ 131
		SELECT AV4301.DivisionID, AV4301.ObjectID, AV4301.ObjectName, AV4301.AccountID, ISNULL(AV4301.DueDate,AV4301.VoucherDate) AS DueDate, AV4301.CurrencyID, 
			AV4301.VoucherID, AV4301.VoucherNo, AV4301.BatchID, AV4301.CurrencyIDCN, AV4301.VoucherDate, AV4301.O02ID,AV4301.DParameter03,
			SUM(AV4301.ConvertedAmount) AS ConvertedAmount, 
			SUM(AV4301.OriginalAmount) AS OriginalAmount,  
			SUM(AV4301.OriginalAmountCN) AS OriginalAmountCN,
			AV4301.O01ID,AV4301.Note,
			1 AS IsTax
		FROM AV4301
		LEFT JOIN AV4301_CTE ON AV4301.DivisionID = AV4301_CTE.DivisionID AND AV4301.VoucherID = AV4301_CTE.VoucherID AND LEFT(AV4301_CTE.AccountID,3) = ''131''
		WHERE AV4301.DivisionID = ''' + @DivisionID + ''' AND
			AV4301.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			AV4301.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND 
			AV4301.D_C=''D'' AND CONVERT(DATE,AV4301.VoucherDate,101) <= '''+LTRIM(CONVERT(DATE,@ReportDate,101))+''' AND 
			AV4301.TransactionTypeID = ''T14'' AND AV4301_CTE.VoucherID IS NULL
		GROUP BY AV4301.DivisionID, AV4301.ObjectID, AV4301.ObjectName, AV4301.AccountID, ISNULL(AV4301.DueDate,AV4301.VoucherDate), AV4301.CurrencyID, 
			AV4301.VoucherID, AV4301.VoucherNo, AV4301.BatchID, AV4301.CurrencyIDCN, AV4301.VoucherDate, AV4301.O02ID,AV4301.DParameter03, AV4301.O01ID, AV4301.Note
	) AV4301
INNER JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID in (''@@@'',AV4301.DivisionID) AND A05.AccountID = AV4301.AccountID AND A05.GroupID = ''G03''
LEFT JOIN (	SELECT	DivisionID, SUM(ISNULL(#TEMP1.GivedOriginalAmount,0)) AS GivedOriginalAmount,
					SUM(ISNULL(#TEMP1.GivedConvertedAmount,0)) AS GivedConvertedAmount,
					VoucherID,  BatchID, ObjectID, AccountID, CurrencyID
			FROM	#TEMP1
           	GROUP BY DivisionID, VoucherID,  BatchID, ObjectID, AccountID, CurrencyID) AS A
		ON 	AV4301.DivisionID = A.DivisionID AND 	AV4301.VoucherID = A.VoucherID AND
			AV4301.BatchID = A.BatchID AND
			AV4301.ObjectID = A.ObjectID AND
			AV4301.AccountID = A.AccountID AND
			AV4301.CurrencyIDCN =A.CurrencyID
'

SET @sSQL1_2 = '
UNION ALL
SELECT	AV4301.DivisionID, AV4301.ObjectID, AV4301.ObjectName, AV4301.AccountID, NULL AS CorAccountID,
		AV4301.DueDate, AV4301.CurrencyID, 
		AV4301.VoucherID, AV4301.VoucherNo, '''' AS BatchID,
		0 AS GivedOriginalAmount,0 AS GivedConvertedAmount, 0 AS ConvertedAmount, 0 AS OriginalAmount, 0 AS OriginalAmountCN,
		AV4301.ConvertedAmount - ISNULL(GivedConvertedAmount,0) AS CreditConvertAmount,
		AV4301.CurrencyIDCN, AV4301.VoucherDate, AV4301.O02ID,
		'''' AS DParameter03, AV4301.O01ID, AV4301.Note
FROM (	SELECT DivisionID, ObjectID, ObjectName, AccountID, ISNULL(DueDate,VoucherDate) AS DueDate, CurrencyID, 
			VoucherID, VoucherNo, BatchID, CurrencyIDCN, VoucherDate, O02ID,
			SUM(ConvertedAmount) AS ConvertedAmount, 
			SUM(OriginalAmount) AS OriginalAmount,  
			SUM(OriginalAmountCN) AS OriginalAmountCN, AV4301.O01ID, AV4301.Note
		FROM AV4301
		WHERE DivisionID = ''' + @DivisionID + ''' AND
			AV4301.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			AV4301.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND 
			D_C=''C'' AND CONVERT(DATE,AV4301.VoucherDate,101) <= '''+LTRIM(CONVERT(DATE,@ReportDate,101))+''' AND 
			TransactionTypeID not in (''T09'',''T10'')
		GROUP BY DivisionID, ObjectID, ObjectName, AccountID, ISNULL(DueDate,VoucherDate), CurrencyID, 
			VoucherID, VoucherNo, BatchID, CurrencyIDCN, VoucherDate, O02ID, AV4301.O01ID, AV4301.Note
	) AV4301
INNER JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID in (''@@@'',AV4301.DivisionID) AND A05.AccountID = AV4301.AccountID AND A05.GroupID = ''G03''
LEFT JOIN (	SELECT	DivisionID, SUM(ISNULL(#TEMP11.GivedOriginalAmount,0)) AS GivedOriginalAmount,
					SUM(ISNULL(#TEMP11.GivedConvertedAmount,0)) AS GivedConvertedAmount,
					VoucherID,  BatchID, ObjectID, AccountID, CurrencyID
			FROM	#TEMP11
           	GROUP BY DivisionID, VoucherID,  BatchID, ObjectID, AccountID, CurrencyID) AS A
		ON 	AV4301.DivisionID = A.DivisionID AND AV4301.VoucherID = A.VoucherID AND
			AV4301.BatchID = A.BatchID AND
			AV4301.ObjectID = A.ObjectID AND
			AV4301.AccountID = A.AccountID AND
			AV4301.CurrencyIDCN =A.CurrencyID
'
		
--PRINT @sSQL1
			

--Xu ly lay du lieu tu moc tro ve truoc hay tro ve sau
SET @MaxDate =  CASE WHEN ISNULL((	SELECT TOP 1 ToDay
									FROM	AT1206 
									WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
											DivisionID in (@DivisionID,'@@@') AND
											Orders = (	SELECT	Max(Orders)
														FROM	AT1206 
														WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND AT1206.DivisionID in (@DivisionID,'@@@'))),0) <> - 1 
					THEN ISNULL((	SELECT TOP 1 ToDay
									FROM	AT1206 
									WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
											DivisionID in (@DivisionID,'@@@') AND
											Orders = (	SELECT	Max(Orders)
														FROM	AT1206 
														WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND AT1206.DivisionID in (@DivisionID,'@@@'))),0)
					ELSE 10000 END

IF @MaxDate > 10000 
	SET @MaxDate = 10000
	
SET @MinDate =  CASE WHEN ISNULL((	SELECT TOP 1 ToDay
									FROM	AT1206 
									WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
											DivisionID in (@DivisionID,'@@@') AND
											Orders = (	SELECT	Min(Orders)
														FROM	AT1206 
														WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
																AT1206.DivisionID in (@DivisionID,'@@@'))),0) <> - 1 
					THEN ISNULL((	SELECT TOP 1 ToDay
									FROM	AT1206 
									WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
											DivisionID in (@DivisionID,'@@@') AND
											Orders = (	SELECT	Min(Orders)
														FROM	AT1206 
														WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
																AT1206.DivisionID in (@DivisionID,'@@@'))),0)
					ELSE -10000 END

IF @MinDate < -10000 
	SET @MinDate = -10000
			
--PRINT @MaxDate
--PRINT @MinDate			
		
--Lay du lieu
SET @ColumnCount = (SELECT	Count(Orders)
					FROM	AT1206 
					WHERE	replace(DebtAgeStepID,'''','''''') =  @DebtAgeStepID 
							AND	AT1206.DivisionID in (@DivisionID,'@@@') )
																	
IF @ColumnCount < 10
	BEGIN
		DECLARE @i AS tinyint
		SET @i = @ColumnCount
		WHILE @i < 10
			BEGIN
				SET @i = @i + 1
				SET @sSELECT1 = @sSELECT1 + '
						N'''' AS Title' + ltrim(str(@i)) + ', 
						0 AS OriginalAmount' + ltrim(str(@i)) + ', 
						0 AS ConvertedAmount' + ltrim(str(@i)) + ','														
			END
	END
		   
SET @AT1206Cursor = CURSOR SCROLL KEYSET FOR
		SELECT	Description, Orders, FromDay, ToDay, replace(Title,'''','''''') AS Title
		FROM	AT1206 WITH (NOLOCK) 
		WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
				AT1206.DivisionID in (@DivisionID,'@@@')			
		ORDER BY Orders
OPEN @AT1206Cursor
FETCH NEXT FROM @AT1206Cursor INTO  @Description, @Orders, @FromDay, @ToDay, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ToDay = -1
	BEGIN	
		SET @sSELECT1 = @sSELECT1 + 'N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', 
				( CASE WHEN
					(DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') >= ' + ltrim(str(@FromDay)) + ')	
					THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) 		
					ELSE 0 end) 
					as ConvertedAmount' + ltrim(str(@Orders)) + ','
	END
	ELSE ---(@ToDay = -1)
	BEGIN
		SET @sSELECT1 = @sSELECT1 + 'N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ',
		( CASE WHEN
			(DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') >= ' + ltrim(str(@FromDay)) + '
			AND DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') < ' + ltrim(str(@ToDay)) + ')
			THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) 
			ELSE 0 end) 
			as ConvertedAmount' + ltrim(str(@Orders)) + ','
	
	END
FETCH NEXT FROM @AT1206Cursor INTO  @Description, @Orders, @FromDay, @ToDay, @Title
END
CLOSE @AT1206Cursor
DEALLOCATE @AT1206Cursor 	

--------------------
--PRINT @sSELECT1
Set @sSQL2 = N'
	SELECT	#TEMP2.DivisionID, DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') AS Days, 
			' + @sSELECT1 + '
			( CASE WHEN
					(DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') >= 0 AND ISNULL(#TEMP2.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP2.DParameter03, '''') <> ''Ho tro trung bay'')	
					THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) ELSE 0 end) 
					as ConvertedAmount100, 
			( CASE WHEN
					(DATEDIFF(day, #TEMP2.DueDate, ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') < 0 AND ISNULL(#TEMP2.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP2.DParameter03, '''') <> ''Ho tro trung bay'')	
					THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) ELSE 0 end) 
					as ConvertedAmount101, 
			(CASE WHEN (ISNULL(#TEMP2.DParameter03, '''') = ''Goi dau'') THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) ELSE 0 END) AS ConvertedAmount102,
			(CASE WHEN (ISNULL(#TEMP2.DParameter03, '''') = ''Ho tro trung bay'') THEN SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) ELSE 0 END) AS ConvertedAmount103,
			SUM(CreditConvertAmount) AS ConvertedAmount0,
			CurrencyIDCN,  #TEMP2.ObjectID, #TEMP2.ObjectName, #TEMP2.CurrencyID, #TEMP2.BatchID, #TEMP2.DParameter03, #TEMP2.O02ID, AT1015.AnaName as O02IDName, SUM(ISNULL(#TEMP2.ConvertedAmount,0)) as ConvertedAmount,
			AV7403.OriginalClosing, AV7403.ConvertedClosing, #TEMP2.O01ID, #TEMP2.Note
	INTO #TEMP3			
	FROM	#TEMP2 
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.DivisionID = #TEMP2.DivisionID AND AT1015.AnaID = #TEMP2.O02ID AND AT1015.AnaTypeID = ''O02''
	LEFT JOIN (SELECT GroupID1, SUM(OriginalClosing) AS OriginalClosing, SUM(ConvertedClosing) AS ConvertedClosing FROM AV7403 GROUP BY GroupID1) AV7403 ON GroupID1 = #TEMP2.ObjectID'

Set @sSQL3 = ' 
	WHERE 	(#TEMP2.ObjectID between  '''+@FromObjectID+''' AND '''+@ToObjectID + ''') AND
			#TEMP2.DivisionID = ''' + @DivisionID + ''' 	 AND 	
			#TEMP2.CurrencyIDCN like ''' + @CurrencyID + ''' AND
			--ISNULL(#TEMP2.TransactionTypeID, '''') not in (''T09'',''T10'') AND
			(#TEMP2.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' or #TEMP2.CorAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''') 
			--AND #TEMP2.DueDate IS NOT NULL 
	GROUP BY	#TEMP2.ObjectID, #TEMP2.ObjectName, #TEMP2.CurrencyID,
				#TEMP2.DivisionID, #TEMP2.VoucherDate, #TEMP2.VoucherNo, 
				#TEMP2.DueDate, CurrencyIDCN, #TEMP2.GivedConvertedAmount,
				#TEMP2.VoucherID, #TEMP2.BatchID, #TEMP2.DueDate, #TEMP2.DParameter03, #TEMP2.O02ID, AT1015.AnaName, AV7403.OriginalClosing, AV7403.ConvertedClosing,
				#TEMP2.O01ID,#TEMP2.Note
	--HAVING (SUM(ISNULL(#TEMP2.ConvertedAmount,0)) - ISNULL(#TEMP2.GivedConvertedAmount,0) <> 0 OR ISNULL(AV7403.ConvertedClosing,0) <> 0 OR SUM(CreditConvertAmount) > 0)
	HAVING (ISNULL(AV7403.ConvertedClosing,0) <> 0)
'
		

Set @sSQL4 = N'
SELECT	#TEMP3.ObjectID, #TEMP3.ObjectName, #TEMP3.O02ID, #TEMP3.O02IDName, #TEMP3.CurrencyID, 
		--SUM(ConvertedAmount1+ConvertedAmount2+ConvertedAmount3+ConvertedAmount4+ConvertedAmount5+
		--ConvertedAmount6+ConvertedAmount7+ConvertedAmount8+ConvertedAmount9+ConvertedAmount10+ConvertedAmount101+ConvertedAmount102+ConvertedAmount103) AS TotalConvertedAmount, 	
		OriginalClosing, ConvertedClosing,
		#TEMP3.DParameter03,
		#TEMP3.Title1, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount1) ELSE 0 END) AS ConvertedAmount1,
		#TEMP3.Title2, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount2) ELSE 0 END) AS ConvertedAmount2,
		#TEMP3.Title3, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount3) ELSE 0 END) AS ConvertedAmount3,
		#TEMP3.Title4, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount4) ELSE 0 END) AS ConvertedAmount4,
		#TEMP3.Title5, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount5) ELSE 0 END) AS ConvertedAmount5,
		#TEMP3.Title6, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount6) ELSE 0 END) AS ConvertedAmount6,
		#TEMP3.Title7, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount7) ELSE 0 END) AS ConvertedAmount7,
		#TEMP3.Title8, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount8) ELSE 0 END) AS ConvertedAmount8,
		#TEMP3.Title9, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount9) ELSE 0 END) AS ConvertedAmount9,
		#TEMP3.Title10, (CASE WHEN (ISNULL(#TEMP3.DParameter03, '''') <> ''Goi dau'' AND ISNULL(#TEMP3.DParameter03, '''') <> ''Ho tro trung bay'') THEN SUM(#TEMP3.ConvertedAmount10) ELSE 0 END) AS ConvertedAmount10,
		SUM(#TEMP3.ConvertedAmount0) AS ConvertedAmount0,
		SUM(#TEMP3.ConvertedAmount100) AS ConvertedAmount100,	
		SUM(#TEMP3.ConvertedAmount101) AS ConvertedAmount101,
		SUM(#TEMP3.ConvertedAmount102) AS ConvertedAmount102,
		SUM(#TEMP3.ConvertedAmount103) AS ConvertedAmount103, SUM(ISNULL(#TEMP3.ConvertedAmount,0)) as ConvertedAmount,
		#TEMP3.O01ID,#TEMP3.Note
INTO	#TEMP4				
FROM	#TEMP3 
GROUP BY #TEMP3.ObjectID, #TEMP3.ObjectName, #TEMP3.DivisionID, #TEMP3.CurrencyID,
		#TEMP3.Title1,#TEMP3.Title2,#TEMP3.Title3,#TEMP3.Title4,#TEMP3.Title5,
		#TEMP3.Title6,#TEMP3.Title7,#TEMP3.Title8,#TEMP3.Title9,#TEMP3.Title10, 
		#TEMP3.DParameter03, #TEMP3.O02ID, #TEMP3.O02IDName, OriginalClosing, ConvertedClosing, #TEMP3.O01ID,#TEMP3.Note
'

Set @sSQL5 = N'
SELECT	#TEMP4.ObjectID, #TEMP4.ObjectName, #TEMP4.O02ID, #TEMP4.O02IDName, --SUM(#TEMP4.TotalConvertedAmount) AS TotalConvertedAmount,
		#TEMP4.OriginalClosing, #TEMP4.ConvertedClosing,
		N''Phát sinh có chưa giải trừ'' as Title0, -SUM(#TEMP4.ConvertedAmount0) AS ConvertedAmount0,		
		#TEMP4.Title1, SUM(#TEMP4.ConvertedAmount1) AS ConvertedAmount1,
		#TEMP4.Title2, SUM(#TEMP4.ConvertedAmount2) AS ConvertedAmount2,
		#TEMP4.Title3, SUM(#TEMP4.ConvertedAmount3) AS ConvertedAmount3,
		#TEMP4.Title4, SUM(#TEMP4.ConvertedAmount4) AS ConvertedAmount4,
		#TEMP4.Title5, SUM(#TEMP4.ConvertedAmount5) AS ConvertedAmount5,
		#TEMP4.Title6, SUM(#TEMP4.ConvertedAmount6) AS ConvertedAmount6,
		#TEMP4.Title7, SUM(#TEMP4.ConvertedAmount7) AS ConvertedAmount7,
		#TEMP4.Title8, SUM(#TEMP4.ConvertedAmount8) AS ConvertedAmount8,
		#TEMP4.Title9, SUM(#TEMP4.ConvertedAmount9) AS ConvertedAmount9,
		#TEMP4.Title10, SUM(#TEMP4.ConvertedAmount10) AS ConvertedAmount10,		
		N''Quá hạn'' as Title100, SUM(#TEMP4.ConvertedAmount100) AS ConvertedAmount100,
		N''Trong hạn'' as Title101, SUM(#TEMP4.ConvertedAmount101) AS ConvertedAmount101,
		N''Gối đầu'' as Title102, SUM(#TEMP4.ConvertedAmount102) AS ConvertedAmount102,
		N''Hỗ trợ trưng bày'' as Title103, SUM(#TEMP4.ConvertedAmount103) AS ConvertedAmount103,
		N''Trong hạn'' as Title104, SUM(#TEMP4.ConvertedAmount101) AS ConvertedAmount104, SUM(ISNULL(#TEMP4.ConvertedAmount,0)) as ConvertedAmount,
		#TEMP4.O01ID,#TEMP4.Note
FROM	#TEMP4		
--WHERE	(#TEMP4.ConvertedAmount100 <> 0 OR #TEMP4.ConvertedAmount101 <> 0) 
GROUP BY #TEMP4.ObjectID, #TEMP4.ObjectName, #TEMP4.O02ID, #TEMP4.O02IDName,
		#TEMP4.Title1,#TEMP4.Title2,#TEMP4.Title3,#TEMP4.Title4,#TEMP4.Title5,
		#TEMP4.Title6,#TEMP4.Title7,#TEMP4.Title8,#TEMP4.Title9,#TEMP4.Title10,
		#TEMP4.OriginalClosing, #TEMP4.ConvertedClosing, #TEMP4.O01ID,#TEMP4.Note
ORDER BY #TEMP4.O02ID, #TEMP4.O01ID, #TEMP4.ObjectID
'

EXEC (@sSQL + @sSQL0 + @sSQL1 + @sSQL1_1 + @sSQL1_2 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)
print @sSQL
print @sSQL0
print @sSQL1
print @sSQL1_1
print @sSQL1_2
print @sSQL2
print @sSQL3
print @sSQL4
print @sSQL5
















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
