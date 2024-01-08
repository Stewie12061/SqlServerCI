IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số bán hàng theo nhóm khách hàng 
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
/*  EXEC BP3013 @DivisionID = 'DD', @IsYear = 0, @FromYear = 2017, @ToYear = 2018, @FromMonth = 11, @ToMonth = NULL, 
	@FromObjectID = '003', @ToObjectID = '', @GroupID1 = 'BIG', 
	@GroupID2 = 'ONL', @GroupID3 = 'SMALL', @GroupID4 = NULL, @GroupID5 = NULL, @CurrencyID = 'VND'

	EXEC BP3013 @DivisionID, @IsYear, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromObjectID, @ToObjectID, @GroupID1, 
	@GroupID2, @GroupID3, @GroupID4, @GroupID5, @CurrencyID
*/


CREATE PROCEDURE [dbo].[BP3013] 
(
	@DivisionID VARCHAR(50),
	@IsYear TINYINT,  
	@FromMonth INT, 
	@ToMonth INT,
	@FromYear INT, 
	@ToYear INT, 
	@FromObjectID VARCHAR(50),
	@ToObjectID VARCHAR(50), 
	@GroupID1 VARCHAR(50), 
	@GroupID2 VARCHAR(50), 
	@GroupID3 VARCHAR(50), 
	@GroupID4 VARCHAR(50), 
	@GroupID5 VARCHAR(50), 
	@CurrencyID VARCHAR(50)
)
AS

DECLARE @sSQL AS VARCHAR(MAX) = N'',
		@SWhere AS VARCHAR(MAX) = N''


SET @SWhere = @SWhere + N'AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TransactionTypeID = ''T04''
'

IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID  >= '''+@FromObjectID+''' '
IF ISNULL(@FromObjectID, '') = ''AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID <= '''+@ToObjectID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + '
AND AT9000.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' '
IF ISNULL(@CurrencyID,'') <> '' SET @sWhere = @sWhere + '
AND AT9000.CurrencyID  = '''+@CurrencyID+''''
SELECT * 
INTO #GroupID
FROM
(
	SELECT @GroupID1 AS GroupID
	WHERE ISNULL(@GroupID1, '') <> ''
	UNION 
	SELECT @GroupID2 AS GroupID
	WHERE ISNULL(@GroupID2, '') <> ''
	UNION
	SELECT @GroupID3 AS GroupID
	WHERE ISNULL(@GroupID3, '') <> ''
	UNION
	SELECT @GroupID4 AS GroupID
	WHERE ISNULL(@GroupID4, '') <> ''
	UNION
	SELECT @GroupID5 AS GroupID
	WHERE ISNULL(@GroupID5, '') <> ''
) T


IF @IsYear = 1 
BEGIN 
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+''''
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) <= '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''' '
END 
ELSE
BEGIN
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') = '' SET @sWhere  = @sWhere + N'
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) >= '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' '
	IF ISNULL(@FromMonth, '') = '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere  = @sWhere + N'
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) <= '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''' '
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere  = @sWhere + N'
	AND CONVERT(VARCHAR(10), AT9000.TranMonth, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToMonth, 126)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+''''
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) <= '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere  = @sWhere + '
	AND CONVERT(VARCHAR(10), AT9000.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''' '
END 

SET @sSQL = N'
SELECT AV9999.MonthYear, AT9000.TranYear, AT9000.CurrencyID, AT1004.CurrencyName, AT1202.O01ID AS CustomerGroupID, AT1015.AnaName AS CustomerGroup,
SUM (ISNULL(AT9000.Quantity, 0) * ISNULL(AT9000.UnitPrice, 0)) AS Sales 
FROM AT9000 WITH (NOLOCK) 
LEFT JOIN AT1202 WITH (NOLOCK) ON AT9000.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
INNER JOIN AT1015 WITH (NOLOCK) ON AT1202.O01ID = AT1015.AnaID AND AT1015.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AV9999 WITH (NOLOCK) ON AT9000.DivisionID = AV9999.DivisionID AND AT9000.TranMonth = AV9999.TranMonth AND AT9000.TranYear = AV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON AT9000.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE '+@SWhere+' 
AND EXISTS (SELECT TOP 1 1 FROM #GroupID WHERE #GroupID.GroupID = AT1202.O01ID)
GROUP BY AV9999.MonthYear, AT9000.CurrencyID, AT1004.CurrencyName, AT1202.O01ID, AT1015.AnaName, AT9000.TranYear
ORDER BY AV9999.MonthYear, AT1202.O01ID
'

--PRINT @sSQL
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
