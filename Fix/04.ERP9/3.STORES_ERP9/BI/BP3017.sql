	IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo tỷ lệ chuyên đổi từ phiếu chào giá sang đơn hàng bán 
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 19/12/2017 by Khả Vi 
---- 
---- Modified on by 
-- <Example>
----  
/* EXEC BP3017 @DivisionID = 'DD', @CurrencyID = 'VND', @FromObjectID = '004', @ToObjectID = '', @IsDate = 0, @FromDate = '', 
	@ToDate = '', @FromMonth = 1, @ToMonth = 11, @FromYear = 2017, @ToYear = 2017 
	
	EXEC BP3017 @DivisionID, @CurrencyID, @FromObjectID, @ToObjectID, @IsDate, @FromDate, @ToDate, @FromMonth, @ToMonth, @FromYear, @ToYear
*/


CREATE PROCEDURE [dbo].[BP3017] 
(
	@DivisionID VARCHAR(50), 
	@CurrencyID VARCHAR(50), 
	@FromObjectID VARCHAR(50), 
	@ToObjectID VARCHAR(50), 
	@IsDate TINYINT, 
	@FromDate DATETIME, 
	@ToDate DATETIME, 
	@FromMonth INT, 
	@ToMonth INT, 
	@FromYear INT, 
	@ToYear INT
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@sSQL3 NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N'', 
		@sWhere1 NVARCHAR(MAX) = N''

SET @sWhere = @sWhere + N' OT2101.DivisionID = '''+@DivisionID+''''
SET @sWhere1 = @sWhere1 + N' OT2001.DivisionID = '''+@DivisionID+''''

IF ISNULL(@CurrencyID, '') <> '' SET @sWhere = @sWhere + N'
AND OT2101.CurrencyID  = '''+@CurrencyID+''''
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere = @sWhere + N'
AND OT2101.ObjectID  >= '''+@FromObjectID+''''
IF ISNULL(@FromObjectID,'') = '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + N'
AND OT2101.ObjectID  <= '''+@ToObjectID+''''
IF ISNULL(@FromObjectID,'') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere = @sWhere + N'
AND OT2101.ObjectID  BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''''

IF ISNULL(@CurrencyID, '') <> '' SET @sWhere1 = @sWhere1 + N'
AND OT2001.CurrencyID  = '''+@CurrencyID+''' '
IF ISNULL(@FromObjectID, '') <> '' AND ISNULL(@ToObjectID, '') = '' SET @sWhere1 = @sWhere1 + N'
AND OT2001.ObjectID  >= '''+@FromObjectID+''' '
IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere1 = @sWhere1 + N'
AND OT2001.ObjectID  <= '''+@ToObjectID+''' '
IF ISNULL(@FromObjectID,'') <> '' AND ISNULL(@ToObjectID, '') <> '' SET @sWhere1 = @sWhere1 + N'
AND OT2001.ObjectID  BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''''
IF @IsDate = 0 
BEGIN
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') = '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranMonth, 120) >= '''+CONVERT(VARCHAR(10), @FromMonth, 120)+'''' 
	IF ISNULL(@FromMonth, '') = '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranMonth, 120) <=  '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''''
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranMonth, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+'''' 
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranYear, 120) <=  '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''

	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') = '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranMonth, 120) >= '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''''
	IF ISNULL(@FromMonth, '') = '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranMonth, 120) <= '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''''
	IF ISNULL(@FromMonth, '') <> '' AND ISNULL(@ToMonth, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranMonth, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromMonth, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToMonth, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') = '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranYear, 120) >= '''+CONVERT(VARCHAR(10), @FromYear, 120)+''''
	IF ISNULL(@FromYear, '') = '' AND ISNULL(@ToYear, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranYear, 120) <= '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
	IF ISNULL(@FromYear, '') <> '' AND ISNULL(@ToYear, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.TranYear, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromYear, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToYear, 120)+''''
END 
ELSE IF @IsDate = 1 
BEGIN
	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.QuotationDate, 120) >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+'''' 
	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.QuotationDate, 120) <=  '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), OT2101.QuotationDate, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.OrderDate, 120) >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+'''' 
	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.OrderDate, 120) <=  '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), OT2001.OrderDate, 120) BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
END 

SET @sSQL = @sSQL + N'
SELECT OV9999.MonthYear, N''Số PCG đã lập'' AS Parameter, COUNT (QuotationID) AS CountVoucher, OT2101.CurrencyID, AT1004.CurrencyName
FROM OT2101 WITH (NOLOCK)
LEFT JOIN OV9999 WITH (NOLOCK) ON OT2101.DivisionID = OV9999.DivisionID AND OT2101.TranMonth = OV9999.TranMonth AND OT2101.TranYear = OV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2101.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+N''', ''@@@'')
WHERE '+@sWhere+'
GROUP BY OV9999.MonthYear, OT2101.CurrencyID, AT1004.CurrencyName
'

SET @sSQL1 = @sSQL1 + N'
UNION ALL
SELECT OV9999.MonthYear, N''Số PCG đã được duyệt'' AS Parameter, COUNT (QuotationID) AS CountVoucher, OT2101.CurrencyID, AT1004.CurrencyName
FROM OT2101 WITH (NOLOCK)
LEFT JOIN OV9999 WITH (NOLOCK) ON OT2101.DivisionID = OV9999.DivisionID AND OT2101.TranMonth = OV9999.TranMonth AND OT2101.TranYear = OV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2101.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+N''', ''@@@'')
WHERE '+@sWhere+'
AND OT2101.IsConfirm = 1 
GROUP BY OV9999.MonthYear, OT2101.CurrencyID, AT1004.CurrencyName
'

SET @sSQL2 = @sSQL2 + N'
UNION ALL
SELECT OV9999.MonthYear, N''Số ĐHB đã lập'' AS Parameter, COUNT (SOrderID) AS CountVoucher, OT2001.CurrencyID, AT1004.CurrencyName
FROM OT2001 WITH (NOLOCK) 
LEFT JOIN OV9999 WITH (NOLOCK) ON OT2001.DivisionID = OV9999.DivisionID AND OT2001.TranMonth = OV9999.TranMonth AND OT2001.TranYear = OV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2001.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE '+@sWhere1+'
GROUP BY OV9999.MonthYear, OT2001.CurrencyID, AT1004.CurrencyName
'

SET @sSQL3 = @sSQL3 + N'
UNION ALL
SELECT OV9999.MonthYear, N''Số ĐHB đã được duyệt'' AS Parameter, COUNT (SOrderID) AS CountVoucher, OT2001.CurrencyID, AT1004.CurrencyName
FROM OT2001 WITH (NOLOCK) 
LEFT JOIN OV9999 WITH (NOLOCK) ON OT2001.DivisionID = OV9999.DivisionID AND OT2001.TranMonth = OV9999.TranMonth AND OT2001.TranYear = OV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2001.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE '+@sWhere1+'
AND OT2001.IsConfirm = 1 
GROUP BY OV9999.MonthYear, OT2001.CurrencyID, AT1004.CurrencyName
'
	
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC(@sSQL+@sSQL1+@sSQL2+@sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
