IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu danh mục đối tượng có công nợ 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 29/06/2021
----Modified by ... on ... 
-- <Example>
---- 
/*-- <Example>
	EXEC TP9022 @DivisionID, @ObjectID, @UserID, @GetDate
----*/

CREATE PROCEDURE TP9022
( 
	@DivisionID VARCHAR(50),  --Biến môi trường
	@ObjectID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@GetDate DATETIME
) 
AS 

DECLARE @sSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)='',
		@sWhere NVARCHAR(MAX),
		@sSQLPermission NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@subQuery NVARCHAR(MAX)

	SET @sWhere = '1 = 1'
	SET @TotalRow = ''
	SET @OrderBy = ' ObjectID'

	SET @sWhere = @sWhere + ' AND (A01.DivisionID = N''' + @DivisionID + ''' OR A02.DivisionID = N''' + @DivisionID + ''') '

	IF ISNULL(@ObjectID, '') ! = ''
		SET @sWhere = @sWhere + ' AND (ISNULL(A01.ObjectID, '''') LIKE N''' + @ObjectID + ''' OR ISNULL(A02.ObjectID, '''') LIKE N''' + @ObjectID + ''') '

SET @sSQL = N'SELECT AT9000.DivisionID, AT9000.VoucherNo, AT9000.ObjectID, A02.ObjectName, ISNULL(AT9000.ConvertedAmount, 0) - ISNULL(AT0404.ConvertedAmount, 0) AS ConvertedAmount, 
DATEDIFF(DAY, AT9000.DueDate, '''+CONVERT(VARCHAR(10), @GetDate, 120)+''') AS [Date]
INTO #Temp_AP1032
FROM
(
	SELECT DivisionID, VoucherID, BatchID, TableID, VoucherNo, ObjectID, CreditAccountID AS AccountID, CurrencyID, SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount, 
	SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, DueDate
	FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+''' AND LEFT(CreditAccountID, 3) = ''331'' 
	AND CONVERT(VARCHAR(10), DueDate, 120) <= '''+CONVERT(VARCHAR(10), @GetDate, 120)+'''
	GROUP BY DivisionID, VoucherID, BatchID, TableID, VoucherNo, ObjectID, CreditAccountID, CurrencyID, DueDate
) AS AT9000
LEFT JOIN (
	SELECT DivisionID, CreditVoucherID AS VoucherID, CreditBatchID AS BatchID, CreditTableID AS TableID, ObjectID, AccountID, CurrencyID, 
	SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount, SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount
	FROM AT0404 WITH (NOLOCK) 
	WHERE DivisionID = '''+@DivisionID+''' AND LEFT(AccountID, 3) = ''331'' AND GiveUpDate <= '''+CONVERT(VARCHAR(20), @GetDate, 120)+'''
	GROUP BY DivisionID, CreditVoucherID, CreditBatchID, CreditTableID, ObjectID, AccountID, CurrencyID
) AS AT0404 ON AT9000.VoucherID = AT0404.VoucherID AND AT9000.BatchID = AT0404.BatchID AND AT9000.TableID = AT0404.TableID AND AT9000.ObjectID = AT0404.ObjectID
LEFT JOIN AT1202 A02 WITH(NOLOCK) ON A02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A02.ObjectID = AT9000.ObjectID
GROUP BY AT9000.DivisionID, AT9000.VoucherNo, AT9000.ObjectID, AT9000.OriginalAmount, AT0404.OriginalAmount, AT9000.ConvertedAmount, AT0404.ConvertedAmount, AT9000.DueDate, A02.ObjectName
HAVING ISNULL(AT9000.ConvertedAmount, 0) - ISNULL(AT0404.ConvertedAmount, 0) > 0 

SELECT AT9000.DivisionID, AT9000.VoucherNo, AT9000.ObjectID, A02.ObjectName, ISNULL(AT9000.ConvertedAmount, 0) - ISNULL(AT0404.ConvertedAmount, 0) AS ConvertedAmount, 
DATEDIFF(DAY, AT9000.DueDate, '''+CONVERT(VARCHAR(20), @GetDate, 120)+''') AS [Date], A02.ReDays
INTO #Temp_AP1033 
FROM
(
	SELECT DivisionID, VoucherID, BatchID, TableID, VoucherNo, ObjectID, DebitAccountID AS AccountID, CurrencyID, SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount, 
	SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount, DueDate
	FROM AT9000 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+''' AND LEFT(DebitAccountID, 3) = ''131''
	AND CONVERT(VARCHAR(10), DueDate, 120) <= '''+CONVERT(VARCHAR(20), @GetDate, 120)+'''
	GROUP BY DivisionID, VoucherID, BatchID, TableID, VoucherNo, ObjectID, DebitAccountID, CurrencyID, DueDate
) AS AT9000
LEFT JOIN (
	SELECT DivisionID, DebitVoucherID AS VoucherID, DebitBatchID AS BatchID, DebitTableID AS TableID, ObjectID, AccountID, CurrencyID, 
	SUM(ISNULL(OriginalAmount, 0)) AS OriginalAmount, SUM(ISNULL(ConvertedAmount, 0)) AS ConvertedAmount
	FROM AT0303 WITH (NOLOCK) 
	WHERE DivisionID = '''+@DivisionID+''' AND LEFT(AccountID, 3) = ''131'' AND GiveUpDate <= '''+CONVERT(VARCHAR(20), @GetDate, 120)+'''
	GROUP BY DivisionID, DebitVoucherID, DebitBatchID, DebitTableID, ObjectID, AccountID, CurrencyID
) AS AT0404 ON AT9000.VoucherID = AT0404.VoucherID AND AT9000.BatchID = AT0404.BatchID AND AT9000.TableID = AT0404.TableID AND AT9000.ObjectID = AT0404.ObjectID
LEFT JOIN AT1202 A02 WITH(NOLOCK) ON A02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A02.ObjectID = AT9000.ObjectID
GROUP BY AT9000.DivisionID, AT9000.VoucherNo, AT9000.ObjectID, AT9000.OriginalAmount, AT0404.OriginalAmount, AT9000.ConvertedAmount, AT0404.ConvertedAmount, AT9000.DueDate, A02.ReDays, A02.ObjectName
HAVING ISNULL(AT9000.ConvertedAmount, 0) - ISNULL(AT0404.ConvertedAmount, 0) > 0 '

SET @sSQL1 = N'
SELECT TOP 1 ISNULL(A01.DivisionID,A02.DivisionID) DivisionID, ISNULL(A01.ObjectID, A02.ObjectID) ObjectID, ISNULL(A03.ObjectName, A04.ObjectName) ObjectName, 
ISNULL(A03.Tel, A04.Tel) Tel, ISNULL(A03.VATNo, A04.VATNo) VATNo, 
SUM(A01.ConvertedAmount) PayableDebt, MAX(A01.Date) PayableDay, SUM(A02.ConvertedAmount) ReceiveDebt, MAX(A02.Date) ReceiveDay 
FROM #Temp_AP1032 A01
FULL JOIN #Temp_AP1033 A02 ON A01.DivisionID= A02.DivisionID AND A01.ObjectID = A02.ObjectID
LEFT JOIN AT1202 A03 WITH(NOLOCK) ON A03.DivisionID IN (A01.DivisionID,''@@@'') AND A03.ObjectID = A01.ObjectID
LEFT JOIN AT1202 A04 WITH(NOLOCK) ON A04.DivisionID IN (A02.DivisionID,''@@@'') AND A04.ObjectID = A02.ObjectID
WHERE  ' + @sWhere + '
GROUP BY ISNULL(A01.DivisionID,A02.DivisionID), ISNULL(A01.ObjectID, A02.ObjectID), ISNULL(A03.ObjectName, A04.ObjectName), ISNULL(A03.Tel, A04.Tel), ISNULL(A03.VATNo, A04.VATNo)

'
PRINT @sSQL
PRINT @sSQL1
EXEC(@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
