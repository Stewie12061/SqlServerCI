IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Ke thua du lieu tu phieu mua hang, bán hang, nhap - xuat kho, VCNB
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhật Quang on 14/03/2023 - Cập nhật: không hiện thị những phiếu đã kế thừa
-- <Example>
/****
exec AP0100 @DivisionID=N'CAG',@InheritTypeID=N'NK',@ObjectID=N'%',@FromMonth=4,@FromYear=2017,@ToMonth=4,@ToYear=2017,@FromDate=NULL,--'2017-04-19 00:00:00.000',
@ToDate=NULL,@IsDate = 0,@CurrencyID='%',@VoucherID=NULL
****/

CREATE PROCEDURE [dbo].[AP0100] 	
				@DivisionID AS VARCHAR(50),
				@InheritTypeID  AS VARCHAR(50), --'HDMH': Hoa don mua hang (T03), 'NK': Phieu nhap kho (T05), 'DHM': Don hang mua
				@ObjectID  AS VARCHAR(50),
				@FromMonth AS INT,
				@FromYear AS INT,
				@ToMonth AS INT,
				@ToYear AS INT,
				@FromDate AS DATETIME,
				@ToDate AS DATETIME,
				@IsDate TINYINT,
				@CurrencyID AS VARCHAR(50) = '%',
				@VoucherID VARCHAR(50),
				@PageNumber INT = 1,
				@PageSize INT = 25
AS
DECLARE @sSQL VARCHAR(MAX) = '', @sSQL1 VARCHAR(MAX) = '', @CustomerName INT, @TotalRow VARCHAR(50)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @ObjectID ='' SET @ObjectID = N'%'

IF @CustomerName = 57 -------- ANGEL
BEGIN
	CREATE TABLE #AP0100_AT9000 (	DivisionID		nvarchar (50),
									TableID			varchar (50),
									TypeID			varchar (50),
									VoucherID		nvarchar (50),
									VoucherNo		nvarchar (50),
									VoucherDate		datetime,
									InvoiceDate		datetime,
									InvoiceNo		nvarchar (50),
									Serial			nvarchar (50),
									Description		nvarchar (250),
									CurrencyID		nvarchar (50),
									ObjectID		nvarchar (50),
									ObjectName		nvarchar (250),
									ImWareHouseID	varchar (50),
									OriginalAmount	decimal(28, 8),
									ConvertedAmount	decimal(28, 8),
									TVoucherID		nvarchar (50),
									TBatchID		nvarchar (50),
									DueDate			datetime,
									EndOriginalAmount	decimal(28, 8),
									EndConvertedAmount	decimal(28, 8)
								)

	IF ISNULL(@InheritTypeID,'') IN ('HDMH','%')
	BEGIN
		SET @sSQL = '
		INSERT INTO #AP0100_AT9000
		SELECT ROW_NUMBER() OVER (ORDER BY A90.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A90.DivisionID, ''AT9000'' AS TableID, ''HDMH'' AS TypeID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial,
		A90.BDescription AS Description,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, '''' AS ImWareHouseID, SUM(A90.OriginalAmount) AS OriginalAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		ISNULL(A90.VoucherID,'''') TVoucherID, ISNULL(A90.BatchID,'''') TBatchID, A90.DueDate, 
		--CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = A90.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit,
		(SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) AS EndOriginalAmount,
		(SUM(A90.ConvertedAmount) - ISNULL(A91.ConvertedAmount,0)) AS EndConvertedAmount
		FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN (SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9010 A91 WITH (NOLOCK) 
			GROUP BY DivisionID, TVoucherID, TBatchID) A91 on A91.DivisionID = A90.DivisionID AND A91.TVoucherID = A90.VoucherID AND A91.TBatchID = A90.BatchID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
		--LEFT JOIN (SELECT AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(OriginalAmount) AS OriginalAmount
		--	FROM AT0404 WITH (NOLOCK)
		--	GROUP BY AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID) A04 ON A90.DivisionID = A04.DivisionID AND A90.VoucherID = A04.DebitVoucherID AND A90.BatchID = A04.DebitBatchID
		WHERE A90.DivisionID = '''+@DivisionID+'''
		AND ISNULL(A90.ObjectID,''%'') LIKE '''+@ObjectID+'''
		AND A90.CurrencyID LIKE '''+@CurrencyID+'''		
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A90.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A90.TranMonth + A90.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A90.TransactionTypeID in (''T03'',''T13'')
		GROUP BY A90.DivisionID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, ISNULL(A90.VoucherID,''''), ISNULL(A90.BatchID,''''), A90.DueDate,
		A91.OriginalAmount, A91.ConvertedAmount
		HAVING (SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) <> 0
		ORDER BY A90.VoucherNo'
	END
	
	IF ISNULL(@InheritTypeID,'') IN ('CPMH','%')
	BEGIN
		SET @sSQL = @sSQL + '
		INSERT INTO #AP0100_AT9000
		SELECT ROW_NUMBER() OVER (ORDER BY A90.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A90.DivisionID, ''AT9000'' AS TableID, ''CPMH'' AS TypeID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription AS Description,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, '''' AS ImWareHouseID, SUM(A90.OriginalAmount) AS OriginalAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		ISNULL(A90.VoucherID,'''') TVoucherID, ISNULL(A90.BatchID,'''') TBatchID, A90.DueDate, 
		--CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = A90.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit,
		(SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0) ) AS EndOriginalAmount,
		(SUM(A90.ConvertedAmount) - ISNULL(A91.ConvertedAmount,0)) AS EndConvertedAmount
		FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN (SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9010 A91 WITH (NOLOCK) 
			GROUP BY DivisionID, TVoucherID, TBatchID) A91 on A91.DivisionID = A90.DivisionID AND A91.TVoucherID = A90.VoucherID AND A91.TBatchID = A90.BatchID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
		--LEFT JOIN (SELECT AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(OriginalAmount) AS OriginalAmount
		--	FROM AT0404 WITH (NOLOCK)
		--	GROUP BY AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID) A04 ON A90.DivisionID = A04.DivisionID AND A90.VoucherID = A04.DebitVoucherID AND A90.BatchID = A04.DebitBatchID
		WHERE A90.DivisionID = '''+@DivisionID+'''
		AND ISNULL(A90.ObjectID,''%'') LIKE '''+@ObjectID+'''
		AND A90.CurrencyID LIKE '''+@CurrencyID+'''		
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A90.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A90.TranMonth + A90.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A90.TransactionTypeID = ''T23''
		GROUP BY A90.DivisionID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, ISNULL(A90.VoucherID,''''), ISNULL(A90.BatchID,''''), A90.DueDate,
		A91.OriginalAmount, A91.ConvertedAmount
		HAVING (SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) <> 0
		ORDER BY A90.VoucherNo
		'
	END
	
	IF ISNULL(@InheritTypeID,'') IN ('HBTL','%')
	BEGIN
		SET @sSQL1 = @sSQL1 +  '
		INSERT INTO #AP0100_AT9000
		SELECT ROW_NUMBER() OVER (ORDER BY A90.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A90.DivisionID, ''AT9000'' AS TableID, ''HBTL'' AS TypeID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription AS Description,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, '''' AS ImWareHouseID, SUM(A90.OriginalAmount) AS OriginalAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		ISNULL(A90.VoucherID,'''') TVoucherID, ISNULL(A90.BatchID,'''') TBatchID, A90.DueDate, 
		--CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = A90.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit,
		(SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0) ) AS EndOriginalAmount,
		(SUM(A90.ConvertedAmount) - ISNULL(A91.ConvertedAmount,0)) AS EndConvertedAmount
		FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN (SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9010 A91 WITH (NOLOCK) 
			GROUP BY DivisionID, TVoucherID, TBatchID) A91 on A91.DivisionID = A90.DivisionID AND A91.TVoucherID = A90.VoucherID AND A91.TBatchID = A90.BatchID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
		--LEFT JOIN (SELECT AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(OriginalAmount) AS OriginalAmount
		--	FROM AT0404 WITH (NOLOCK)
		--	GROUP BY AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID) A04 ON A90.DivisionID = A04.DivisionID AND A90.VoucherID = A04.DebitVoucherID AND A90.BatchID = A04.DebitBatchID
		WHERE A90.DivisionID = '''+@DivisionID+'''
		AND ISNULL(A90.ObjectID,''%'') LIKE '''+@ObjectID+'''
		AND A90.CurrencyID LIKE '''+@CurrencyID+'''
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A90.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A90.TranMonth + A90.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A90.TransactionTypeID = ''T24''
		GROUP BY A90.DivisionID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, ISNULL(A90.VoucherID,''''), ISNULL(A90.BatchID,''''), A90.DueDate,
		A91.OriginalAmount, A91.ConvertedAmount
		HAVING (SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) <> 0
		ORDER BY A90.VoucherNo
		'
	END
	
	IF ISNULL(@InheritTypeID,'') IN ('PTH','%')
	BEGIN
		SET @sSQL1 = @sSQL1 +  '
		INSERT INTO #AP0100_AT9000
		SELECT ROW_NUMBER() OVER (ORDER BY A90.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A90.DivisionID, ''AT9000'' AS TableID, ''HDMH'' AS TypeID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription AS Description,
		A90.CurrencyID, A90.CreditObjectID as ObjectID, A02.ObjectName, '''' AS ImWareHouseID, SUM(A90.OriginalAmount) AS OriginalAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		ISNULL(A90.VoucherID,'''') TVoucherID, ISNULL(A90.BatchID,'''') TBatchID, A90.DueDate, 
		--CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = A90.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit,
		(SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) AS EndOriginalAmount,
		(SUM(A90.ConvertedAmount) - ISNULL(A91.ConvertedAmount,0)) AS EndConvertedAmount
		FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN (SELECT DivisionID, TVoucherID, TBatchID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9010 A91 WITH (NOLOCK) 
			GROUP BY DivisionID, TVoucherID, TBatchID) A91 on A91.DivisionID = A90.DivisionID AND A91.TVoucherID = A90.VoucherID AND A91.TBatchID = A90.BatchID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.CreditObjectID = A02.ObjectID
		--LEFT JOIN (SELECT AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(OriginalAmount) AS OriginalAmount
		--	FROM AT0404 WITH (NOLOCK)
		--	GROUP BY AT0404.DivisionID, DebitVoucherID, AT0404.DebitBatchID) A04 ON A90.DivisionID = A04.DivisionID AND A90.VoucherID = A04.DebitVoucherID AND A90.BatchID = A04.DebitBatchID
		WHERE A90.DivisionID = '''+@DivisionID+'''
		AND ISNULL(A90.CreditObjectID,''%'') LIKE '''+@ObjectID+'''
		AND A90.CurrencyID LIKE '''+@CurrencyID+'''
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A90.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A90.TranMonth + A90.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A90.TransactionTypeID = ''T99''
		GROUP BY A90.DivisionID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, A90.BDescription,
		A90.CurrencyID, A90.CreditObjectID, A02.ObjectName, ISNULL(A90.VoucherID,''''), ISNULL(A90.BatchID,''''), A90.DueDate,
		A91.OriginalAmount, A91.ConvertedAmount
		HAVING (SUM(A90.OriginalAmount) -	ISNULL(A91.OriginalAmount,0)) <> 0
		ORDER BY A90.VoucherNo
		'
	END
	--PRINT(@sSQL)
	--PRINT(@sSQL1)
	EXEC(@sSQL+@sSQL1)

	SELECT * FROM #AP0100_AT9000 ORDER BY VoucherNo
	DROP TABLE #AP0100_AT9000
END
ELSE ---- << ANGEL
BEGIN
	IF ISNULL(@InheritTypeID,'') = 'HDMH'
	BEGIN
		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY A90.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A90.DivisionID, ''AT9000'' AS TableID, ''HDMH'' AS TypeID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial,
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, '''' AS ImWareHouseID, SUM(A90.OriginalAmount) AS OriginalAmount, SUM(A90.ConvertedAmount) AS ConvertedAmount, 
		ISNULL(A90.TVoucherID,'''') TVoucherID, ISNULL(A90.TBatchID,'''') TBatchID, A90.DueDate, 
		CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND InheritVoucherID = '''+ISNULL(@VoucherID,'')+''') = A90.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit 
		FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A90.ObjectID = A02.ObjectID
		LEFT JOIN AT9010 AT09 WITH (NOLOCK) ON AT09.DivisionID = A90.DivisionID AND AT09.InheritVoucherID = A90.VoucherID 
		WHERE A90.DivisionID = '''+@DivisionID+'''
		AND A90.VoucherID NOT IN (
			SELECT InheritVoucherID
			FROM AT9010
			WHERE InheritVoucherID = A90.VoucherID
		)
		AND A90.ObjectID LIKE '''+@ObjectID+'''
		AND A90.CurrencyID LIKE '''+@CurrencyID+'''
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A90.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A90.TranMonth + A90.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A90.TransactionTypeID = ''T03''
		GROUP BY A90.DivisionID, A90.VoucherID, A90.VoucherNo, A90.VoucherDate, A90.InvoiceDate, A90.InvoiceNo, A90.Serial, 
		A90.CurrencyID, A90.ObjectID, A02.ObjectName, ISNULL(A90.TVoucherID,''''), ISNULL(A90.TBatchID,''''), A90.DueDate
		ORDER BY A90.VoucherNo'
	END
	ELSE
	IF ISNULL(@InheritTypeID,'') = 'NK'
	BEGIN
		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY A06.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, A06.DivisionID, ''AT2006'' AS TableID, ''NK'' AS TypeID, A06.VoucherID, A06.VoucherNo, A06.VoucherDate, A06.ObjectID, A02.ObjectName, 
		A06.WareHouseID AS ImWareHouseID, NULL AS InvoiceDate, '''' AS InvoiceNo, '''' AS Serial, '''' TVoucherID, '''' AS TBatchID, SUM(A07.OriginalAmount) OriginalAmount,
		SUM(A07.ConvertedAmount) ConvertedAmount, NULL AS DueDate,
		CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = A06.VoucherID THEN ''1'' ELSE ''0'' END AS IsInherit 
		FROM AT2006 A06
		INNER JOIN AT2007 A07 ON A06.DivisionID = A06.DivisionID AND A06.VoucherID = A07.VoucherID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectID = A02.ObjectID
		WHERE A06.DivisionID = '''+@DivisionID+'''
		AND A06.VoucherID NOT IN (
			SELECT InheritVoucherID
			FROM AT9010
			WHERE InheritVoucherID = A06.VoucherID
		)
		AND A06.ObjectID LIKE '''+@ObjectID+'''
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),A06.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND A06.TranMonth + A06.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND A06.KindVoucherID IN (1,3,5,7,9)
		GROUP BY A06.DivisionID, A06.VoucherID, A06.VoucherNo, A06.VoucherDate, A06.ObjectID, A02.ObjectName, A06.WareHouseID
		ORDER BY A06.VoucherNo
		'
	END
	ELSE
	IF ISNULL(@InheritTypeID,'') = 'DHM'
	BEGIN
		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY O31.VoucherNo) AS RowNum, ' + @TotalRow + ' AS TotalRow, O31.DivisionID, ''OT3001'' AS TableID, ''DHM'' AS TypeID, O31.POrderID AS VoucherID, O31.VoucherNo, O31.OrderDate AS VoucherDate, NULL AS InvoiceDate, 
		'''' AS InvoiceNo, '''' AS Serial, '''' AS ImWareHouseID, O31.ObjectID, A02.ObjectName, O31.CurrencyID, '''' TVoucherID, '''' AS TBatchID, 
		SUM(O32.OriginalAmount) OriginalAmount, SUM(O32.ConvertedAmount) ConvertedAmount, '''' DebitAccountID, '''' CreditAccountID, NULL AS DueDate,
		CASE WHEN (SELECT ISNULL(InheritVoucherID,'''') FROM AT9010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+ISNULL(@VoucherID,'')+''') = O31.POrderID THEN ''1'' ELSE ''0'' END AS IsInherit 
		FROM OT3001 O31
		INNER JOIN OT3002 O32 ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND O31.ObjectID = A02.ObjectID
		WHERE O31.DivisionID = '''+@DivisionID+'''
		AND O31.POrderID NOT IN (
			SELECT InheritVoucherID
			FROM AT9010
			WHERE InheritVoucherID = O31.POrderID
		)
		AND O31.ObjectID LIKE '''+@ObjectID+'''
		'+CASE WHEN ISNULL(@IsDate,0) = 1 THEN 'AND CONVERT(VARCHAR(10),O31.OrderDate,120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		ELSE 'AND O31.TranMonth + O31.TranYear*100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth + @ToYear*100)+' ' END+'
		AND O31.CurrencyID LIKE '''+@CurrencyID+'''
		AND O31.OrderStatus not in (0, 9) AND  O31.[Disabled] = 0 
		GROUP BY O31.DivisionID, O31.POrderID, O31.VoucherNo, O31.OrderDate, O31.ObjectID, A02.ObjectName, O31.CurrencyID
		ORDER BY O31.VoucherNo
		'
	END
	PRINT(@sSQL)
	EXEC(@sSQL)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

