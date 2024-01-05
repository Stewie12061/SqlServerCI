IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created BY Như Hàn
---- Created date 20/12/2018
---- Purpose: Đổ nguồn lưới kế thừa yêu cầu mua hàng
/********************************************
EXEC FNP2004 'AIC', 11, 2018, 11, 2018, '2018-02-01 00:00:00.000', '2018-02-01 00:00:00.000', 1, '%', '', 1, 25
EXEC FNP2004 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @VoucherNo, @PriorityID, @PageNumber, @PageSize

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[FNP2004]
    @DivisionID AS NVARCHAR(50), 
    @FromMonth			INT,
	@FromYear			INT,
	@ToMonth			INT,
	@ToYear				INT,
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
	@VoucherNo			NVARCHAR(500),
	@PriorityID			VARCHAR(50),
	@PageNumber INT,
	@PageSize INT

AS

DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'', 
		@BeginDate DATETIME,	
		@EndDate DATETIME,
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--SET @PeriodFrom = @FromMonth+@FromYear*100
--SET @PeriodTo = @ToMonth+@ToYear*100

SELECT @BeginDate = BeginDate FROM FNV9999 WHERE TranMonth = @FromMonth AND TranYear = @FromYear

SELECT @EndDate = EndDate FROM FNV9999 WHERE TranMonth = @ToMonth AND TranYear = @ToYear

SET @OrderBy = 'T1.ROrderID, T1.VoucherNo, T1.OrderDate' 
SET @sWhere = @sWhere + ' AND T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@PriorityID,'') <> ''
SET @sWhere = @sWhere + '
				AND T1.PriorityID IN ('''+ISNULL(@PriorityID,'')+''')'	
IF ISNULL(@VoucherNo,'') <> ''
SET @sWhere = @sWhere + '
				AND T1.VoucherNo LIKE ''%'+ISNULL(@VoucherNo,'')+'%'''	



IF @IsDate = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T1.OrderDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T1.OrderDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T1.OrderDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE	
	BEGIN
		SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T1.OrderDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@BeginDate,112)+''' AND '''+CONVERT(VARCHAR(10),@EndDate,112)+'''  '
	END


SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow, 
T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, ISNULL(T2.Description,T1.Description) As Description,
T1.Ana01ID,
A11.AnaName AS Ana01Name,
T2.Ana02ID,
A12.AnaName AS Ana02Name,
T2.Ana03ID,
A13.AnaName AS Ana03Name,
T2.Ana04ID,
A14.AnaName AS Ana04Name,
T2.Ana05ID,
A15.AnaName AS Ana05Name,
T2.Ana06ID,
A16.AnaName AS Ana06Name,
T2.Ana07ID,
A17.AnaName AS Ana07Name,
T2.Ana08ID,
A18.AnaName AS Ana08Name,
T2.Ana09ID,
A19.AnaName AS Ana09Name,
T2.Ana10ID,
A20.AnaName AS Ana10Name,
SUM(T2.OriginalAmount) As OriginalAmount, SUM(T2.ConvertedAmount) As ConvertedAmount, 
SUM(T2.VATOriginalAmount) As VATOriginalAmount, SUM(T2.VATConvertedAmount) As VATConvertedAmount
FROM OT3101 T1 WITH (NOLOCK)
INNER JOIN OT3102 T2 WITH (NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T2.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T2.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T2.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T2.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T2.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T2.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T2.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T2.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T2.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T2.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
WHERE T1.OrderStatus = 1 AND T2.ROrderID NOT IN (SELECT InheritVoucherID FROM FNT2001 WHERE InheritTableID = ''OT3101'')
'+@sWhere +'
GROUP BY 
T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T2.Description, T1.Description,
T1.Ana01ID,
A11.AnaName,
T2.Ana02ID,
A12.AnaName,
T2.Ana03ID,
A13.AnaName,
T2.Ana04ID,
A14.AnaName,
T2.Ana05ID,
A15.AnaName,
T2.Ana06ID,
A16.AnaName,
T2.Ana07ID,
A17.AnaName,
T2.Ana08ID,
A18.AnaName,
T2.Ana09ID,
A19.AnaName,
T2.Ana10ID,
A20.AnaName
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT (@sSQL)
EXEC (@sSQL)
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
