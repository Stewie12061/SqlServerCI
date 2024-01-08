IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số trung bình
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
/*  EXEC BP3012 @DivisionID = 'DD', @TranYear = 2017, @FromObjectID = '003', @ToObjectID = '014', @CurrencyID = 'USD'
	
	EXEC BP3012 @DivisionID, @TranYear, @FromObjectID, @ToObjectID
*/


CREATE PROCEDURE [dbo].[BP3012] 
(
	@DivisionID NVARCHAR(50),
	@TranYear INT, 
	@FromObjectID NVARCHAR(50),
	@ToObjectID NVARCHAR(50),
	@CurrencyID NVARCHAR(50)
)
AS

DECLARE @sSQL AS VARCHAR(MAX) = N'',
		@SWhere AS VARCHAR(MAX) = N''

		SET @SWhere = @SWhere + N' AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TranYear = '''+STR(@TranYear)+''' AND TransactionTypeID = ''T04'''

IF ISNULL(@CurrencyID, '') <> '' SET @SWhere = @SWhere + '
AND AT9000.CurrencyID = '''+@CurrencyID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID  >= '''+@FromObjectID+''' '
IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID <= '''+@ToObjectID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '

SET @sSQL = N'SELECT * FROM 
(SELECT AT9000.TranYear, N''VoucherMonth'' + CONVERT(NVARCHAR(15), AT9000.TranMonth) AS TranMonth, AT9000.CurrencyID, AT1004.CurrencyName, 
AVG(ISNULL(AT9000.Quantity, 0) * ISNULL(AT9000.UnitPrice, 0)) AS AvgVoucherID
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1004 WITH (NOLOCK) ON AT9000.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE '+@SWhere+'
GROUP BY AT9000.TranYear, AT9000.TranMonth, AT9000.CurrencyID, AT1004.CurrencyName) AS P
PIVOT (MAX(AvgVoucherID) FOR TranMonth IN ([VoucherMonth1], [VoucherMonth2], [VoucherMonth3],
[VoucherMonth4], [VoucherMonth5], [VoucherMonth6],
[VoucherMonth7], [VoucherMonth8], [VoucherMonth9],
[VoucherMonth10], [VoucherMonth11], [VoucherMonth12])) AS PivotTable
'
--PRINT @sSQL
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
