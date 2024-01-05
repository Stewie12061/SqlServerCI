IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số bán hàng theo mặt hàng 
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
/*  EXEC BP3014 @DivisionID = 'DD', @IsYear = 1, @FromMonth = '', @ToMonth = '', @FromYear = '', @ToYear = '',
	@FromInventoryTypeID = 'CC', @ToInventoryTypeID = 'VL', @FromInventoryID = '1A597M', @ToInventoryID = 'W93B9-1o-01', @CurrencyID = 'USD'
	
	EXEC BP3014 @DivisionID, @IsYear, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromInventoryTypeID, @ToInventoryTypeID, @FromInventoryID, 
	@ToInventoryID, @CurrencyID
*/


CREATE PROCEDURE [dbo].[BP3014] 
(
	@DivisionID VARCHAR(50),
	@IsYear TINYINT, 
	@FromMonth INT, 
	@ToMonth INT, 
	@FromYear INT, 
	@ToYear INT, 
	@FromInventoryTypeID VARCHAR(50),
	@ToInventoryTypeID VARCHAR(50),
	@FromInventoryID VARCHAR(50),
	@ToInventoryID VARCHAR(50), 
	@CurrencyID VARCHAR(50)
)
AS

DECLARE @sSQL VARCHAR(MAX),
		@SWhere VARCHAR(MAX) = N''
SET @SWhere = @SWhere + N'AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TransactionTypeID = ''T04''
'

IF ISNULL(@FromInventoryTypeID, '') <> '' AND ISNULL(@ToInventoryTypeID, '') = '' SET @sWhere = @sWhere + '
AND AT1302.InventoryTypeID  >= '''+@FromInventoryTypeID+''' '
IF ISNULL(@FromInventoryTypeID, '') = '' AND ISNULL(@ToInventoryTypeID, '') <> '' SET @sWhere = @sWhere + '
AND AT1302.InventoryTypeID <= '''+@ToInventoryTypeID+''' '
IF ISNULL(@FromInventoryTypeID, '') <> '' AND ISNULL(@ToInventoryTypeID, '') <> '' SET @sWhere = @sWhere + '
AND AT1302.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+''' '
IF ISNULL(@FromInventoryID, '') <> '' AND ISNULL(@ToInventoryID, '') = '' SET @sWhere = @sWhere + '
AND AT9000.InventoryID  >= '''+@FromInventoryID+''' '
IF ISNULL(@FromInventoryID, '') = '' AND ISNULL(@ToInventoryID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.InventoryID <= '''+@ToInventoryID+''' '
IF ISNULL(@FromInventoryID, '') <> '' AND ISNULL(@ToInventoryID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' '
IF ISNULL(@CurrencyID,'') <> '' SET @sWhere = @sWhere + '
AND AT9000.CurrencyID  = '''+@CurrencyID+''' '
IF @IsYear = 1 
BEGIN 
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+''''
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) <= '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''' '
END 
ELSE IF @IsYear <> 1 
BEGIN 
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') = '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) >= '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' '
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') = '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) <= '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''' '
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''' '
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET  @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+''''
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET  @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) <= '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''

END 

SET @sSQL = N'
SELECT AV9999.TranMonth, AT9000.CurrencyID, AT1004.CurrencyName, AT9000.InventoryID, AT1302.InventoryName, AT1302.InventoryTypeID, AT1301.InventoryTypeName,
SUM (ISNULL(AT9000.Quantity, 0) * ISNULL(AT9000.UnitPrice, 0)) AS Sales 
FROM AT9000 WITH (NOLOCK) 
LEFT JOIN AV9999 WITH (NOLOCK) ON AT9000.DivisionID = AV9999.DivisionID AND AT9000.TranMonth = AV9999.TranMonth AND AT9000.TranYear = AV9999.TranYear 
LEFT JOIN AT1302 WITH (NOLOCK) ON AT9000.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1302.InventoryTypeID = AT1301.InventoryTypeID AND AT1301.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AT1004 WITH (NOLOCK) ON AT9000.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE '+@SWhere+'
GROUP BY AV9999.TranMonth, AT9000.CurrencyID, AT1004.CurrencyName, AT9000.InventoryID, AT1302.InventoryName, AT1302.InventoryTypeID, AT1301.InventoryTypeName
ORDER BY AT9000.InventoryID
'


--PRINT @sSQL
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
