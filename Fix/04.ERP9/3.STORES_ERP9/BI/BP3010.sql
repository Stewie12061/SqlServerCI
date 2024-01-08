IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo lượng đơn hàng công ty 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 11/12/2017 by Khả Vi 
---- 
---- Modified on by 
-- <Example>
----  
/*  EXEC BP3010 @DivisionID = 'DD', @TranYear = 2017, @FromObjectID = '003', @ToObjectID = '014', @CurrencyID = 'VND' 
	
	EXEC BP3010 @DivisionID, @TranYear, @FromObjectID, @ToObjectID
*/


CREATE PROCEDURE [dbo].[BP3010] 
(
	@DivisionID VARCHAR(50),
	@TranYear INT, 
	@FromObjectID VARCHAR(50),
	@ToObjectID VARCHAR(50),
	@CurrencyID VARCHAR(50)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@SWhere NVARCHAR(MAX) = N''


SET @SWhere = @SWhere + N' OT2001.DivisionID = '''+@DivisionID+''' AND OT2001.TranYear = '''+CONVERT(VARCHAR(10), @Tranyear, 120)+''' AND  OT2001.IsConfirm = 1'
	
IF ISNULL(@CurrencyID, '') <> '' SET @SWhere = @SWhere + '
AND OT2001.CurrencyID = '''+@CurrencyID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere = @sWhere + '
AND OT2001.ObjectID  >= '''+@FromObjectID+''' '
IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND OT2001.ObjectID <= '''+@ToObjectID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND OT2001.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '

SET @sSQL = @sSQL + N'
SELECT N''VoucherMonth'' + CONVERT(NVARCHAR(15), OT2001.TranMonth) AS TranMonth, OT2001.TranYear, OT2001.CurrencyID, AT1004.CurrencyName, 
COUNT(SOrderID) AS CountVoucherID
INTO #OT2001
FROM OT2001 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2001.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+N''', ''@@@'')
WHERE '+@SWhere+'
GROUP BY OT2001.TranMonth, OT2001.TranYear, OT2001.CurrencyID, AT1004.CurrencyName
'
SET @sSQL1 = @sSQL1 + N'
SELECT * 
FROM (
	SELECT TranYear, TranMonth, CurrencyID, CurrencyName, CountVoucherID 
	FROM #OT2001 ) AS P 
PIVOT (MAX(CountVoucherID) FOR TranMonth IN ([VoucherMonth1], [VoucherMonth2], [VoucherMonth3], [VoucherMonth4], [VoucherMonth5], [VoucherMonth6], 
[VoucherMonth7], [VoucherMonth8], [VoucherMonth9], [VoucherMonth10], [VoucherMonth11], [VoucherMonth12])) AS PivotTable
'


--PRINT @sSQL
--PRINT @sSQL1
EXEC(@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
