IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP3001]
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
	EXEC TP3001 @ListDivisionID='AS',@BudgetType='', @FromMonth = 11, @FromYear = 2018,@ToMonth = 11, @ToYear = 2018,@FromDate='01-01-2016',@ToDate='01-01-2018',@DepartmentList = '12'',''234'
	EXEC TP3001 @ListDivisionID, @BudgetType, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @DepartmentList

*/


CREATE PROCEDURE [TP3001]
( 
		@ListDivisionID NVARCHAR(Max),
		@BudgetType NVARCHAR(Max),
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@FromDate DATETIME,
		@ToDate DATETIME
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
SELECT T20.DivisionID, TD.DivisionName, T21.Ana02ID, T01.AnaName As Ana02Name, T21.Notes,
	SUM(T21.OriginalAmount) As OriginalAmount, SUM(T21.ConvertedAmount) As ConvertedAmount, 
	SUM(T21.ApprovalOAmount) As ApprovalOAmount, SUM(T21.ApprovalCAmount) As ApprovalCAmount
FROM TT2100 T20 WITH (NOLOCK) 
INNER JOIN TT2101 T21 WITH (NOLOCK) ON T21.APKMaster = T20.APK AND T20.DivisionID = T21.DivisionID
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana02ID = T01.AnaID AND T01.AnaTypeID = ''A02''
LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T20.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
LEFT JOIN AT1101 TD WITH (NOLOCK) ON T20.DivisionID = TD.DivisionID
WHERE 1=1
'+@sWhere+'
GROUP BY T20.DivisionID,TD.DivisionName, T21.Ana02ID, T01.AnaName, T21.Notes
'
--PRINT (@sSQL)
--PRINT (@sWhere)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
