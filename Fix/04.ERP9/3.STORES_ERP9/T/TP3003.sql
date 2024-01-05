IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo đề nghị thanh toán
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
	EXEC TP3003 @DivisionID='AS', @FromMonth = 01, @FromYear = 2018, @ToMonth = 11, @ToYear = 2018,@DepartmentList = '12'',''234'
	EXEC TP3003 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @DepartmentList

	EXEC TP3003 @ListDivisionID, @BudgetType, @FromMonth, @FromYear, @ToMonth, @ToYear

*/


CREATE PROCEDURE [TP3003]
( 
		@ListDivisionID NVARCHAR(MAX),
		@BudgetType NVARCHAR(MAX),
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT 
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
IF (@FromMonth IS NOT NULL AND @ToMonth IS NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 >= '+Ltrim(@PeriodFrom)+''
IF (@FromMonth IS NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 <= '+Ltrim(@PeriodTo)+''
IF (@FromMonth IS NOT NULL AND @ToMonth IS NOT NULL) SET @sWhere = @sWhere + '
	AND T20.TranMonth + T20.TranYear * 100 BETWEEN '+Ltrim(@PeriodFrom)+' AND '+LTrim(@PeriodTo)+''

SET @sSQL = @sSQL +'
SELECT T20.DivisionID, TD.DivisionName, T20.TranMonth, T20.TranYear, 
	T21.Ana02ID, T01.AnaName As Ana02Name,
	T21.ApprovalOAmount As ApprovalCAmount, 
	T90.ConvertedAmount As T90ConvertedAmount, T90.VoucherNo
FROM TT2100 T20 WITH(NOLOCK)
LEFT JOIN TT2101 T21 WITH(NOLOCK) ON T20.APK = T21.APKMaster AND T20.DivisionID = T21.DivisionID
LEFT JOIN AT9000 T90 WITH(NOLOCK) ON T90.InheritTransactionID = T21.APK AND T90.InheritTableID = ''TT2100''
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana02ID = T01.AnaID AND T01.AnaTypeID = ''A02''
LEFT JOIN AT1101 TD WITH (NOLOCK) ON T21.DivisionID = TD.DivisionID
WHERE 1= 1
'+@sWhere+'
'
PRINT (@sSQL)
PRINT (@sWhere)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
