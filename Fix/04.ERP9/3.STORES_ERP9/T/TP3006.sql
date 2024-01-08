IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo so sánh ngân sách và thực tế
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
	EXEC TP3006 @DivisionID='AS',@BudgetType='Q', @FromMonth = 11, @FromYear = 2018,@ToMonth = 11, @ToYear = 2018,@FromDate='01-01-2016',@ToDate='01-01-2018'
	EXEC TP3006 @DivisionID, @BudgetType, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @DepartmentList

*/


CREATE PROCEDURE [TP3006]
( 
		@DivisionID NVARCHAR(MAX),
		@BudgetType NVARCHAR(50),
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

IF ISNULL(@DivisionID, '') <> '' SET @sWhere = @sWhere + '
	AND T20.DivisionID IN ('''+@DivisionID+''')'
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T20.VoucherDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''  '
IF ISNULL(@BudgetType,'')<> ''SET @sWhere = @sWhere + N' 
	AND T20.BudgetType = '''+@BudgetType+''''
IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 >= '+Ltrim(@PeriodFrom)+''
IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 <= '+Ltrim(@PeriodTo)+''
IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''

SET @sSQL = @sSQL +'
SELECT T20.DivisionID, TD.DivisionName, T21.Ana02ID, T01.AnaName As Ana02Name, 
	SUM(T21.OriginalAmount) As OriginalAmount, SUM(T21.ConvertedAmount) As ConvertedAmount, 
	SUM(T21.ApprovalOAmount) As ApprovalOAmount, SUM(T21.ApprovalCAmount) As ApprovalCAmount,
	SUM(T90.ConvertedAmount) As T90ConvertedAmount, SUM(T90.OriginalAmount) As T90OriginalAmount
FROM TT2100 T20 WITH (NOLOCK) 
INNER JOIN TT2101 T21 WITH (NOLOCK) ON T21.APKMaster = T20.APK
LEFT JOIN AT9000 T90 WITH (NOLOCK) ON T90.InheritVoucherID = T20.APK AND T90.InheritTransactionID = T21.APK AND T90.InheritTableID = ''TT2100''
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana02ID = T01.AnaID AND T01.AnaTypeID = ''A02''
LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T20.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
LEFT JOIN AV9999 V99 ON T20.TranMonth = V99.TranMonth AND T20.TranYear = V99.TranYear AND T20.DivisionID = V99.DivisionID
LEFT JOIN AT1101 TD WITH (NOLOCK) ON T21.DivisionID = TD.DivisionID
WHERE 1=1 AND T20.Status = 1
'+@sWhere+'
GROUP BY T21.Ana02ID, T01.AnaName, T20.DivisionID,TD.DivisionName
'
PRINT (@sSQL)
--PRINT (@sWhere)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
