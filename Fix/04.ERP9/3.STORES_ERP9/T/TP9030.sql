IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu danh mục chi phí vượt chỉ tiêu ngân sách
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 09/07/2021
----Modified by ... on ... 
-- <Example>
---- 
/*-- <Example>
	EXEC TP9030 @DivisionID, @DivisionIDList, @FromDate, @ToDate, @PeriodList, @AnaID, @AnaName, @BudgetType, @UserID, @GetDate, @SearchWhere, @PageNumber, @PageSize
----*/

CREATE PROCEDURE TP9030
( 
	@DivisionID VARCHAR(50),  --Biến môi trường
	@DivisionIDList NVARCHAR(MAX), 
	@FromDate VARCHAR(50) = NULL,
	@ToDate VARCHAR(50) = NULL,
	@PeriodList NVARCHAR(250) = NULL,
	@AnaID NVARCHAR(50) = NULL,
	@AnaName NVARCHAR(250) = NULL,
	@BudgetType NVARCHAR(50) = NULL,
	@UserID NVARCHAR(50) = '',
	@GetDate DATETIME = NULL,
	@SearchWhere NVARCHAR(MAX) = NULL,
	@PageNumber INT = 0,
	@PageSize INT = 0
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
	SET @OrderBy = ' AnaID'

IF ISNULL(@SearchWhere, '') = ''
BEGIN
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND (A99.DivisionID IN (''' + @DivisionIDList + ''')) '
	ELSE 
		SET @sWhere = @sWhere + ' AND (A99.DivisionID = N''' + @DivisionID + ''') '

	IF ISNULL(@AnaID, '') ! = ''
		SET @sWhere = @sWhere + ' AND (ISNULL(A99.Ana02ID, '''') LIKE N''%' + @AnaID + '%'') '

	IF ISNULL(@AnaName, '') ! = ''
		SET @sWhere = @sWhere + ' AND (ISNULL(A01.AnaName, '''') LIKE N''%' + @AnaName + '%'') '

	IF ISNULL(@BudgetType, '') ! = ''
		SET @sWhere = @sWhere + ' AND (ISNULL(A99.BudgetType, '''') IN (''' + @BudgetType + ''')) '

END
ELSE IF ISNULL(@SearchWhere, '') != ''
BEGIN
	SET @sWhere = '1 = 1'
END

SET @sSQL = N'
DECLARE @firstMonthOfFiscalyear INT
SELECT TOP 1 @firstMonthOfFiscalyear = BeginMonth FROM AT1101 WITH(NOLOCK) WHERE DivisionID = N''' + @DivisionID + '''

;WITH MyQuarters(q, qDate, qDateEnd) as
(
	SELECT 1, DATEFROMPARTS(year(getdate()), @firstMonthOfFiscalyear, 1), -- First quarter date
	DATEADD(DAY, -1, DATEADD(MONTH, 3, DATEFROMPARTS(year(getdate()), @firstMonthOfFiscalyear, 1)))
    UNION ALL
    SELECT q+1, DATEADD(q, 1, qdate), -- next quarter start date
	DATEADD(DAY, -1, DATEADD(MONTH, 3, DATEADD(q, 1, qdate)))
    FROM MyQuarters
    WHERE q < 4 -- limiting the number of next quarters
 )
select * INTO #TempMyQuarters from MyQuarters

SELECT M.DivisionID, M.Ana02ID, MONTH(M.VoucherDate)+(YEAR(M.VoucherDate)*100) MonthYear, A01.q Quater, YEAR(M.VoucherDate) Years, 
SUM(ISNULL(M.ConvertedAmount,0)) CostAmount
INTO #TempAT9000
FROM AT9000 M WITH(NOLOCK) 
LEFT JOIN #TempMyQuarters A01 WITH(NOLOCK) ON MONTH(M.VoucherDate)*100+DAY(M.VoucherDate) BETWEEN MONTH(A01.qDate)*100+DAY(A01.qDate) AND MONTH(A01.qDateEnd)*100+DAY(A01.qDateEnd)
WHERE M.DivisionID = N''' + @DivisionID + ''' AND M.TransactionTypeID IN (''T02'',''T22'')
GROUP BY M.DivisionID, M.Ana02ID, MONTH(M.VoucherDate)+(YEAR(M.VoucherDate)*100), A01.q, YEAR(M.VoucherDate)

-----Tạo bảng tổng theo quý từ #TempAT9000
SELECT DivisionID, Ana02ID, CONCAT(Quater,''/'',Years) MonthYear, Quater, Years, SUM(CostAmount) CostAmount
INTO #TempAT9000Quater
FROM #TempAT9000
GROUP BY DivisionID, Ana02ID, Quater, Years
-----Tao bảng tổng theo năm từ #TempAT9000
SELECT DivisionID, Ana02ID, Years MonthYear, Years, SUM(CostAmount) CostAmount
INTO #TempAT9000Year
FROM #TempAT9000
GROUP BY DivisionID, Ana02ID, Years
 '

SET @sSQL1 = N'
SELECT A99.DivisionID, A99.Ana02ID AnaID, A01.AnaName, A05.Description BudgetType, A99.TranMonth, A99.TranYear
, CASE WHEN A99.BudgetType = ''M'' THEN CONCAT(FORMAT(A99.TranMonth, ''00''),''/'',A99.TranYear)
       WHEN A99.BudgetType = ''Q'' THEN CONCAT((A99.TranMonth-1)/3+1,''/'',A99.TranYear)
	   WHEN A99.BudgetType = ''Y'' THEN CONCAT(A99.TranYear,'''') END MonthYear
, SUM(ISNULL(A99.ConvertedAmount,0)) BudgetAmount
, ISNULL(A02.CostAmount,ISNULL(A03.CostAmount,ISNULL(A04.CostAmount,0))) CostAmount
, SUM(ISNULL(A99.ConvertedAmount,0)) - ISNULL(A02.CostAmount,ISNULL(A03.CostAmount,ISNULL(A04.CostAmount,0))) DifferenceAmount
INTO #Temp_TP9030 
FROM AT9090 A99 WITH(NOLOCK)
LEFT JOIN AT1011 A01 WITH(NOLOCK) ON A01.DivisionID IN (A99.DivisionID,''@@@'') AND A01.AnaID = A99.Ana02ID AND A01.AnaTypeID = ''A02''
LEFT JOIN #TempAT9000 A02 WITH(NOLOCK) ON A02.DivisionID = A99.DivisionID AND A02.Ana02ID = A99.Ana02ID 
										AND A99.BudgetType = ''M'' AND A02.MonthYear = A99.TranYear*100+A99.TranMonth  ---Tháng
LEFT JOIN #TempAT9000Quater A03 WITH(NOLOCK) ON A03.DivisionID = A99.DivisionID AND A03.Ana02ID = A99.Ana02ID 
										AND A99.BudgetType = ''Q'' AND A03.Years = A99.TranYear AND (A03.Quater-1)*3+1 = A99.TranMonth ---Quý
LEFT JOIN #TempAT9000Year A04 WITH(NOLOCK) ON A04.DivisionID = A99.DivisionID AND A04.Ana02ID = A99.Ana02ID 
										AND A99.BudgetType = ''Y'' AND A04.Years = A99.TranYear  ---Năm
LEFT JOIN AT0099 A05 WITH(NOLOCK) ON A05.CodeMaster = ''BudgetType'' AND A05.ID = A99.BudgetType
WHERE  ' + @sWhere + '
GROUP BY A99.DivisionID, A99.Ana02ID, A01.AnaName, A99.BudgetType, A05.Description, A05.OrderNo, A99.TranMonth, A99.TranYear, A02.CostAmount, A03.CostAmount, A04.CostAmount
HAVING SUM(ISNULL(A99.ConvertedAmount,0)) - ISNULL(A02.CostAmount,ISNULL(A03.CostAmount,ISNULL(A04.CostAmount,0))) < 0

DECLARE @Count INT
SELECT @Count = Count(AnaID) FROM #Temp_TP9030 
' + ISNULL(@SearchWhere, '') + '

IF '+STR(@PageSize)+' = 0
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
	FROM #Temp_TP9030 M WITH (NOLOCK)
	' + ISNULL(@SearchWhere, '') + '
	ORDER BY ' + @OrderBy + '
END
ELSE
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
	FROM #Temp_TP9030 M WITH (NOLOCK)
	' + ISNULL(@SearchWhere, '') + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
END
'
PRINT @sSQL
PRINT @sSQL1
EXEC(@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
