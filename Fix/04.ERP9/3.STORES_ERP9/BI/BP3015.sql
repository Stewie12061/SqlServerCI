IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo tổng hợp tình hình thanh toán 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 19/12/2017 by Khả Vi 
---- 
---- Modified on by 
-- <Example>
----  
/*  EXEC BP3015 @DivisionID = 'DD', @CurrencyID = NULL, @FromAccountID = '1311', @ToAccountID = '171', @FromObjectID = '003', @ToObjectID = 'WKR', 
	@IsDate = 1, @FromDate = '2017-11-1 00:00:00', @ToDate = '2017-11-15 00:00:00', @FromMonth = 1, @ToMonth = 11, @FromYear = 2017, @ToYear = 2017, @TypeID = 1

	EXEC BP3015 @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @IsDate, @FromDate, @ToDate, @FromMonth, @ToMonth, @FromYear,
	@ToYear, @TypeID
*/


CREATE PROCEDURE [dbo].[BP3015] 
(
	@DivisionID VARCHAR(50),
	@CurrencyID VARCHAR(50), 
	@FromAccountID VARCHAR(50), 
	@ToAccountID VARCHAR(50), 
	@FromObjectID VARCHAR(50), 
	@ToObjectID VARCHAR(50), 
	@IsDate TINYINT, -- 1: Lấy theo ngày
					-- 0: Lấy theo kỳ 
	@FromDate DATETIME, 
	@ToDate DATETIME, 
	@FromMonth INT, 
	@ToMonth INT, 
	@FromYear INT, 
	@ToYear INT, 
	@TypeID INT -- Ngày hóa đơn, trường hợp IsDate = 1 
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQL3 NVARCHAR(MAX) = N'',
		@TypeDate NVARCHAR(50), 
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
		@sWhere2 NVARCHAR(MAX) = N''


IF ISNULL(@CurrencyID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.CurrencyID  = '''+@CurrencyID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID >= '''+@FromObjectID+''' '
IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID <= '''+@ToObjectID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '

IF ISNULL(@FromAccountID, '') <> '' AND ISNULL(@ToAccountID, '') = '' SET @sWhere1 = @sWhere1 + '
AND AT9000.DebitAccountID >= '''+@FromAccountID+''' '
IF ISNULL(@FromAccountID, '') = '' AND ISNULL(@ToAccountID, '') <> ''  SET @sWhere1 = @sWhere1 + '
AND AT9000.DebitAccountID <= '''+@ToAccountID+''' '
IF ISNULL(@FromAccountID, '') <> '' AND ISNULL(@ToAccountID, '') <> '' SET @sWhere1 = @sWhere1 + '
AND AT9000.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' '

IF ISNULL(@FromAccountID, '') <> '' AND ISNULL(@ToAccountID, '') = '' SET @sWhere2 = @sWhere2 + '
AND AT9000.CreditAccountID >= '''+@FromAccountID+''' '
IF ISNULL(@FromAccountID, '') = '' AND ISNULL(@ToAccountID, '') <> '' SET @sWhere2 = @sWhere2 + '
AND AT9000.CreditAccountID <= '''+@ToAccountID+''' '
IF ISNULL(@FromAccountID, '') <> '' AND ISNULL(@ToAccountID, '') <> '' SET @sWhere2 = @sWhere2 + '
AND AT9000.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' '


-- Lấy số dư nợ 
SET @sSQL = @sSQL + N'
SELECT ''00'' AS RPTransactionType, AT9000.TransactionTypeID, AT9000.OriginalAmountCN AS SignOriginalAmount, AT9000.TranMonth, AT9000.TranYear, 
AT9000.ObjectID, AT9000.CurrencyID, AT9000.DivisionID, AT9000.InvoiceDate, AT9000.VoucherDate
INTO #Temp_AT9000
FROM AT9000 WITH (NOLOCK) 
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID
INNER JOIN AT1202 WITH (NOLOCK) ON AT9000.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE AT1005.GroupID = ''G03'' 
AND AT9000.DivisionID = '''+@DivisionID+'''
'+@sWhere+'
'+@sWhere1+'
'
--Lấy số dư có 
SET @sSQL1 = @sSQL1 + N'
UNION ALL
SELECT ''01'' AS RPTransactionType, AT9000.TransactionTypeID, AT9000.OriginalAmountCN *(-1) AS SignOriginalAmount, AT9000.TranMonth, AT9000.TranYear, 
AT9000.ObjectID, AT9000.CurrencyID, AT9000.DivisionID, AT9000.InvoiceDate, AT9000.VoucherDate
FROM AT9000 WITH (NOLOCK) 
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
LEFT JOIN AT0000 A00 WITH (NOLOCK) on AT9000.DivisionID = A00.DefDivisionID
WHERE AT1005.GroupID = ''G03'' 
AND AT9000.DivisionID = '''+@DivisionID+''' 
'+@sWhere+'
'+@sWhere2+'
'

IF @IsDate = 0 -- Lấy theo kỳ 
BEGIN 
	SET @sSQL2 = @sSQL2 + N'
	SELECT T1.DivisionID, AV9999.MonthYear, T1.ObjectID, AT1202.ObjectName, T1.CurrencyID, AT1004.CurrencyName, T1.InvoiceDate, T1.VoucherDate, 
	SUM (CASE WHEN (T1.TranMonth + 100 * T1.TranYear >= '+CONVERT(VARCHAR(10), ISNULL(@FromMonth, ''), 120) + ' + 100 * ' +CONVERT(VARCHAR(10), ISNULL(@FromYear, ''), 120)+') 
	AND (T1.TranMonth + 100 * T1.TranYear <= '+CONVERT(VARCHAR(10), ISNULL(@ToMonth, ''), 120) + ' + 100 * ' +CONVERT(VARCHAR(10), ISNULL(@ToYear, ''), 120)+') AND (ISNULL(T1.TransactiontypeID, '''') <> ''T00'')
	AND  T1.RPTransactionType = ''01'' THEN - T1.SignOriginalAmount ELSE 0 END) AS OriginalCredit, 
	SUM (CASE WHEN ((T1.TranMonth + 100 * T1.TranYear <= '+CONVERT(VARCHAR(10), ISNULL(@ToMonth, ''), 120)+ ' + 100 * ' +CONVERT(VARCHAR(10), ISNULL(@ToYear, ''), 120)+') OR T1.TransactiontypeID = ''T00'') 
	AND T1.RPTransactionType = ''00'' THEN T1.SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing, 
	SUM (CASE WHEN ((T1.TranMonth + 100 * T1.TranYear <= '+CONVERT(VARCHAR(10), ISNULL(@ToMonth, ''), 120)+ ' + 100 * ' +CONVERT(VARCHAR(10), ISNULL(@ToYear, ''), 120)+') OR T1.TransactiontypeID = ''T00'') 
	AND T1.RPTransactionType = ''01'' THEN - T1.SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing
	INTO #Temp_AT9000_1 
	FROM #Temp_AT9000 T1 
	LEFT JOIN AV9999 WITH (NOLOCK) ON T1.DivisionID = AV9999.DivisionID AND T1.TranMonth = AV9999.TranMonth AND T1.TranYear = AV9999.TranYear 
	LEFT JOIN AT1202 WITH (NOLOCK) ON T1.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
	LEFT JOIN AT1004 WITH (NOLOCK) ON T1.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
	GROUP BY T1.DivisionID, AV9999.MonthYear, T1.ObjectID, AT1202.ObjectName, T1.CurrencyID, AT1004.CurrencyName, T1.InvoiceDate, T1.VoucherDate
	'
	SET @sSQL3 = @sSQL3 + N'
	SELECT DivisionID, MonthYear, ObjectID, ObjectName, CurrencyID, CurrencyName, 
	CASE WHEN DebitOriginalClosing - CreditOriginalClosing > 0 THEN DebitOriginalClosing - CreditOriginalClosing ELSE 0 END AS DebitOriginalClosing, 
	OriginalCredit
	FROM #Temp_AT9000_1
	WHERE OriginalCredit <> 0 
	OR DebitOriginalClosing - CreditOriginalClosing <> 0  
	ORDER BY ObjectID
	'
END
ELSE IF @IsDate = 1 -- Lấy theo ngày 
BEGIN
	IF ISNULL(@TypeID, '') <> '' 
	BEGIN 
		IF @TypeID = 0	---- Lấy theo ngày hóa đơn 
		SET @TypeDate = 'InvoiceDate'
		ELSE IF @TypeID = 1 	---- Lấy theo ngày hạch toán 
			SET @TypeDate = 'VoucherDate' 


		SET @sSQL2 = @sSQL2 + N'
		SELECT T1.DivisionID, AV9999.MonthYear, T1.ObjectID, AT1202.ObjectName, T1.CurrencyID, AT1004.CurrencyName, 
		SUM (CASE WHEN CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) >= ''' + CONVERT(VARCHAR(10), @FromDate, 101) + '''  
		AND CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''' 
		AND (IsNull(TransactiontypeID, '''') <> ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS OriginalCredit,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''' 
		OR TransactiontypeID = ''T00'') AND RPTransactionType = ''00'' THEN SignOriginalAmount ELSE 0 END) AS DebitOriginalClosing,
		SUM (CASE WHEN (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''' 
		OR TransactiontypeID = ''T00'') AND RPTransactionType = ''01'' THEN -SignOriginalAmount ELSE 0 END) AS CreditOriginalClosing
		INTO #Temp_AT9000_2
		FROM #Temp_AT9000 T1 
		LEFT JOIN AV9999 WITH (NOLOCK) ON T1.DivisionID = AV9999.DivisionID AND T1.TranMonth = AV9999.TranMonth AND T1.TranYear = AV9999.TranYear 
		LEFT JOIN AT1202 WITH (NOLOCK) ON T1.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
		LEFT JOIN AT1004 WITH (NOLOCK) ON T1.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
		GROUP BY T1.DivisionID, AV9999.MonthYear, T1.ObjectID, AT1202.ObjectName, T1.CurrencyID, AT1004.CurrencyName
		'
	END 
	ELSE 
	BEGIN
		SET @sSQL2 = @sSQL2 + N'
		SELECT NULL AS DivisionID, NULL AS MonthYear, NULL AS ObjectID, NULL AS ObjectName, NULL AS CurrencyID, NULL AS CurrencyName, 
		NULL AS OriginalCredit, NULL AS DebitOriginalClosing, NULL AS CreditOriginalClosing
		INTO #Temp_AT9000_2
		'
	END 
	

	SET @sSQL3 = @sSQL3 + N'
	SELECT DivisionID, MonthYear, ObjectID, ObjectName, CurrencyID, CurrencyName, 
	CASE WHEN DebitOriginalClosing - CreditOriginalClosing > 0 THEN DebitOriginalClosing - CreditOriginalClosing ELSE 0 END AS DebitOriginalClosing, 
	OriginalCredit
	FROM #Temp_AT9000_2
	WHERE OriginalCredit <> 0 
	OR DebitOriginalClosing - CreditOriginalClosing <> 0  
	ORDER BY ObjectID
	'
END 
	
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC(@sSQL+@sSQL1+@sSQL2+@sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
