IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo kế hoạch ngân sách trường
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 15/11/2018
-- <Example>
---- 
/*<Example>
	EXEC TP3002 @ListDivisionID='AS',@BudgetType='Q', @FromMonth = 11, @FromYear = 2018,@ToMonth = 11, @ToYear = 2018,@FromDate='01-01-2016',@ToDate='01-01-2018',@AnaList = '12'',''234'
	EXEC TP3002 @DivisionID, @BudgetType, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @AnaList

*/


CREATE PROCEDURE [TP3002]
( 
		@ListDivisionID NVARCHAR(MAX),
		@BudgetType NVARCHAR(MAX),
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@FromDate DATETIME,
		@ToDate DATETIME,
		@AnaList NVARCHAR(MAX)	 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@PeriodFrom INT,	
		@PeriodTo INT

SET @PeriodFrom = @FromMonth+@FromYear*100
SET @PeriodTo = @ToMonth+@ToYear*100

IF ISNULL(@ListDivisionID, '') <> '' SET @sWhere = @sWhere + '
	AND T20.DivisionID IN ('''+@ListDivisionID+''')'
IF ISNULL(@AnaList, '') <> '' SET @sWhere = @sWhere + ' 
	AND T20.DepartmentID IN (''' + @AnaList + ''')'
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''  '
IF ISNULL(@BudgetType,'')<> ''SET @sWhere = @sWhere + N' 
	AND T20.BudgetType = '''+@BudgetType+''''
IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
	AND T20.MonthBP + T20.YearBP * 100 >= '+Ltrim(@PeriodFrom)+''
IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.MonthBP + T20.YearBP * 100 <= '+Ltrim(@PeriodTo)+''
IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.MonthBP + T20.YearBP * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''

SET @sSQL = @sSQL +'
SELECT T20.DivisionID, AT1101.DivisionName, T20.TranMonth, T20.TranYear, V99.MonthYear, T20.BudgetType, T99.Description As BudgetTypeName, 
(Case '''+ISNULL(@BudgetType,'')+'''
		When ''Y'' then CONVERT (Varchar(50),(V99.TranYear))
		When ''Q'' then CONVERT (Varchar(50),(V99.Quarter)) 
		else '''' End) as Period, 
	T20.VoucherDate, T21.Ana03ID as DepartmentID, T11.AnaName As DepartmentName, T21.Ana02ID, T01.AnaName As Ana02Name, 
	T21.OriginalAmount, T21.ConvertedAmount, 
	T21.ApprovalOAmount As ApprovalOAmount, T21.ApprovalCAmount As ApprovalCAmount,  T21.Notes
FROM TT2100 T20 WITH (NOLOCK) 
INNER JOIN TT2101 T21 WITH (NOLOCK) ON T21.APKMaster = T20.APK
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana02ID = T01.AnaID AND T01.AnaTypeID = ''A02''
LEFT JOIN AT1011 T11 WITH (NOLOCK) ON T21.Ana03ID = T11.AnaID AND T11.AnaTypeID = ''A03''
LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T20.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
LEFT JOIN AV9999 V99 ON T20.TranMonth = V99.TranMonth AND T20.TranYear = V99.TranYear AND T20.DivisionID = V99.DivisionID
INNER JOIN AT1101 WITH(NOLOCK) ON T20.DivisionID = AT1101.DivisionID
WHERE 1=1 
'+@sWhere+'
'
PRINT (@sSQL)
--PRINT (@sWhere)
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
