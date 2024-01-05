IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số theo từng khách hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 18/12/2017 by Khả Vi 
---- 
---- Modified on by 
-- <Example>
----  
/*  EXEC BP3011 @DivisionID = 'DD', @TranYear = 2017, @CustomerID = '003', @CurrencyID = 'USD '
	
	EXEC BP3011 @DivisionID, @TranYear, @CustomerID, @CurrencyID
*/


CREATE PROCEDURE [dbo].[BP3011] 
(
	@DivisionID VARCHAR(50),
	@TranYear INT, 
	@CustomerID VARCHAR(50),
	@CurrencyID VARCHAR(50)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N''
SET @sWhere = ' AT9000.DivisionID = '''+@DivisionID+''' 
AND AT9000.TranYear = '''+CONVERT(VARCHAR(10), @TranYear, 120)+''' 
AND TransactionTypeID = ''T04'''

IF ISNULL(@CurrencyID, '') <> '' SET @sWhere = @sWhere + N'
AND AT1004.CurrencyID = '''+@CurrencyID+''''
IF ISNULL(@CustomerID, '') <> '' SET @sWhere = @sWhere + N'
AND AT9000.ObjectID = '''+@CustomerID+'''
'
SET @sSQL = N'SELECT * FROM 
(SELECT N''CustomerMonth'' + CONVERT(NVARCHAR(15), AT9000.TranMonth) AS TranMonth, AT9000.TranYear, AT9000.CurrencyID, AT1004.CurrencyName, 
AT9000.ObjectID AS CustomerID, AT1202.ObjectName AS CustomerName, CONVERT(DECIMAL(28,8), AVG(ISNULL(AT9000.Quantity, 0) * ISNULL(AT9000.UnitPrice, 0))) AS Sales 
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT9999 WITH (NOLOCK) ON AT9999.DivisionID = AT9000.DivisionID AND AT9000.TranMonth  = AT9999.TranMonth AND AT9000.TranYear = AT9999.TranYear
LEFT JOIN AT1004 WITH (NOLOCK) ON AT9000.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AT1202 WITH (NOLOCK) ON AT9000.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
WHERE '+@sWhere+'
GROUP BY AT9000.TranMonth, AT9000.TranYear, AT9000.CurrencyID, AT1004.CurrencyName, AT9000.ObjectID, AT1202.ObjectName
) AS P
PIVOT (MAX(Sales) FOR TranMonth IN ([CustomerMonth1], [CustomerMonth2], [CustomerMonth3],
[CustomerMonth4], [CustomerMonth5], [CustomerMonth6],
[CustomerMonth7], [CustomerMonth8], [CustomerMonth9],
[CustomerMonth10], [CustomerMonth11], [CustomerMonth12])) AS PivotTable
'
--PRINT @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
