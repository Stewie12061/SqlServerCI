IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created BY Như Hàn
---- Created date 07/12/2018
---- Purpose: Đổ nguồn lưới kế thừa yêu cầu mua hàng từ dự án
/********************************************
EXEC POP2034 'AIC', 11, 2018, 11, 2018, '2018-02-01 00:00:00.000', '2018-02-01 00:00:00.000', 1, 'AIC', 1, 25
EXEC POP2034 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @ProjectID, @PageNumber, @PageSize

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[POP2034]
    @DivisionID AS NVARCHAR(50), 
    @FromMonth			INT,
	@FromYear			INT,
	@ToMonth			INT,
	@ToYear				INT,
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
	@ProjectID			VARCHAR(max),
	@PageNumber INT,
	@PageSize INT

AS

DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'', 
		@LanguageID VARCHAR(50),
		@BeginDate DATETIME,	
		@EndDate DATETIME,
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--SET @PeriodFrom = @FromMonth+@FromYear*100
--SET @PeriodTo = @ToMonth+@ToYear*100

SELECT @BeginDate = BeginDate FROM OV9999 WHERE TranMonth = @FromMonth AND TranYear = @FromYear

SELECT @EndDate = EndDate FROM OV9999 WHERE TranMonth = @ToMonth AND TranYear = @ToYear

SET @OrderBy = 'PT3.ASCIDProJ' 
SET @sWhere = @sWhere + ' AND PT3.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
SET @sWhere = @sWhere + '
				AND CT6.ASCProjectID IN ('''+ISNULL(@ProjectID,'')+''')'	

IF @IsDate = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),PT3.ASCOrderDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),PT3.ASCOrderDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),PT3.ASCOrderDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE	
	BEGIN
		SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),PT3.ASCOrderDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@BeginDate,112)+''' AND '''+CONVERT(VARCHAR(10),@EndDate,112)+'''  '
	END


SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow, PT3.APK,
PT3.DivisionID, CT6.ASCProjectID As ProjectID, T01.AnaName As ProjectName, PT3.ASCIDProJ, PT3.ASCOrderID, PT3.ASCOrderDetail, PT3.ASCOrderNo, PT3.ASCDescription, 
PT3.ASCQuantity, PT3.ASCIDInven, PT3.ASCOrderDate, 
CT6.ASCModel, CT6.ASCMadeby, CT6.ASCInvenType, CT6.ASCMadeIn, CT6.ASCEquipment, CT6.InventoryID, T32.InventoryName, T32.UnitID, T04.UnitName
FROM POT2033 PT3 WITH(NOLOCK)
INNER JOIN CIT1176 CT6 WITH(NOLOCK) ON PT3.ASCIDInven = CT6.ASCIDInven AND PT3.DivisionID = CT6.DivisionID
INNER JOIN AT1302 T32 WITH(NOLOCK) ON T32.InventoryID = CT6.InventoryID
LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T32.UnitID = T04.UnitID 
LEFT JOIN AT1011 T01 WITH(NOLOCK) ON T01.AnaID = CT6.ASCProjectID AND T01.AnaTypeID = ''A05''
WHERE PT3.ASCOrderID NOT IN (SELECT InheritVoucherID FROM OT3102 WHERE InheritTableID = ''POT2033'') AND ISNULL(PT3.IsInherit,0) = 0
'+@sWhere +'
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
