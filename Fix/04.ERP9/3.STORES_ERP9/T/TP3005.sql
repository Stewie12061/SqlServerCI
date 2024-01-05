IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP3005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP3005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo ngân sách nhu cầu vốn (SGNamPhat)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 25/08/2021
----Modified by: Lê Hoàng on date 06/09/2021 : Fix lỗi cú pháp
-- <Example>
---- 
/*<Example>
	EXEC TP3005 @DivisionID='AS',@BudgetType='Q', @FromMonth = 11, @FromYear = 2018,@ToMonth = 11, @ToYear = 2018
	EXEC TP3005 @DivisionID, @BudgetType, @FromMonth, @FromYear, @ToMonth, @ToYear

*/


CREATE PROCEDURE [TP3005]
( 
		@DivisionID NVARCHAR(MAX),
		@StrDivisionID NVARCHAR(MAX),
		@UserID NVARCHAR(50),
		@TranMonthFrom INT,
		@TranYearFrom INT,
		@TranMonthTo INT,
		@TranYearTo INT,
		@IsPeriod INT
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@PeriodFrom INT,	
		@PeriodTo INT,
		@YearFrom INT,
		@YearTo INT

SET @PeriodFrom = @TranMonthFrom+@TranYearFrom*100
SET @PeriodTo = @TranMonthTo+@TranYearTo*100

SET @YearFrom = @TranYearFrom
SET @YearTo = @TranYearTo

IF ISNULL(@DivisionID, '') <> '' SET @sWhere = @sWhere + '
	AND T20.DivisionID IN ('''+@DivisionID+''')'

--IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
--	AND T20.TranMonth + T20.TranYear * 100 >= '+Ltrim(@PeriodFrom)+''
--IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
--	AND T20.TranMonth + T20.TranYear * 100 <= '+Ltrim(@PeriodTo)+''
--IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
--	AND T20.TranMonth + T20.TranYear * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''

IF @IsPeriod = 0 --theo kỳ
BEGIN
 print 0
 SET @sWhere = @sWhere + '
	AND T20.BudgetType = ''M''
	AND T20.MonthBP + T20.YearBP * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND ' + Ltrim(@PeriodTo)
END
ELSE IF @IsPeriod = 1 --theo quý
BEGIN
 print 1
 SET @sWhere = @sWhere + '
	AND T20.BudgetType = ''Q''
	AND T20.MonthBP + T20.YearBP * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND ' + Ltrim(@PeriodTo)
END
ELSE IF @IsPeriod = 2 --theo năm
BEGIN
 print 2
 SET @sWhere = @sWhere + '
	AND T20.BudgetType = ''Y''
	AND T20.YearBP BETWEEN '+Ltrim(@YearFrom)+' AND '+Ltrim(@YearTo)
END

SET @sSQL = @sSQL +'
SELECT T20.DivisionID, TD.DivisionName, T20.BudgetKindID, T98.Description AS BudgetKindName,
	T20.BudgetType, T99.Description BudgetTypeName, FORMAT(CONVERT(INT,T20.MonthBP), ''0#'') MonthBP, T20.YearBP,
    ISNULL(T01.Notes,'''') AS AnaGroup,
    T21.Ana02ID, T01.AnaName As Ana02Name, 
	SUM(T21.OriginalAmount) As OriginalAmount, SUM(T21.ConvertedAmount) As ConvertedAmount, 
	SUM(T21.ApprovalOAmount) As ApprovalOAmount, SUM(T21.ApprovalCAmount) As ApprovalCAmount
FROM TT2100 T20 WITH (NOLOCK) 
INNER JOIN TT2101 T21 WITH (NOLOCK) ON T21.APKMaster = T20.APK
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana02ID = T01.AnaID AND T01.AnaTypeID = ''A02''
LEFT JOIN AT0099 T98 WITH (NOLOCK) ON T20.BudgetKindID = T98.ID AND T98.CodeMaster = ''BudgetKind'' AND T98.Disabled = 0
LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T20.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType'' AND T99.Disabled = 0
LEFT JOIN AV9999 V99 ON T20.TranMonth = V99.TranMonth AND T20.TranYear = V99.TranYear AND T20.DivisionID = V99.DivisionID
LEFT JOIN AT1101 TD WITH (NOLOCK) ON T21.DivisionID = TD.DivisionID
WHERE 1=1 AND T20.Status = 1
'+@sWhere+'
GROUP BY ISNULL(T01.Notes,''''), T21.Ana02ID, T01.AnaName, T20.DivisionID, TD.DivisionName, T20.BudgetKindID, T98.Description, 
		 T20.BudgetType, T99.Description, T20.MonthBP, T20.YearBP
ORDER BY YearBP, MonthBP DESC
'
--'+@sWhere+'
PRINT (@sSQL)
--PRINT (@sWhere)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
