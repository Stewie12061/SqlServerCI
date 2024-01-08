IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0039_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0039_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo sản lượng sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/01/2017 by Phan Hải Long
---- Modified by Tiểu Mai on 10/02/2017: Bổ sung lấy lên ca chưa có dữ liệu phát sinh
---- Modified by Kim Thư on 10/10/2017: Bổ sung biến tỷ lệ hàng hư - @ErrorRate cho Angel
---- Modified by Kim Thư on 20/06/2019: Bổ sung định dạng số lẻ của số lượng theo thiết lập đơn vị
-- <Example>
---- EXEC MP0039 @DivisionID = 'ANG', @FromPeriod = 201701, @ToPeriod = 201701, @FromDate = '2018-10-10', @ToDate='2018-10-10', @FromInventoryID = '%', @ToInventoryID='%',
-- @FromI03ID='%', @ToI03ID='%', @FromTeamID='%', @ToTeamID='%', @TimeMode=0, @ErrorRate=5
CREATE PROCEDURE [dbo].[MP0039_AG]
( 
	@DivisionID NVARCHAR(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,		
	@InventoryID NVARCHAR(50),
	@InventoryTypeID NVARCHAR(50),
	@TeamID NVARCHAR(50),
	@TimeMode TINYINT,
	@ErrorRate FLOAT
)
AS 

SET NOCOUNT ON 

DECLARE @sSql NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = '',
		@TeamName NVARCHAR(4000) = '',
		@sWhere1 NVARCHAR(4000) = '',
		@sWhere2 NVARCHAR(4000) = '',
		@sWhere3 NVARCHAR(4000) = '',
		@QuantityDecimals INT

SELECT @QuantityDecimals = QuantityDecimals FROM AT1101 WHERE DivisionID=@DivisionID

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND MT1801.TranMonth + MT1801.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)										
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND MT1801.VoucherDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''								
END	

SELECT @TeamName = TeamName FROM HT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TeamID = @TeamID

--PRINT @TeamName

-- Xử lý trường hợp truyền biến %
IF @InventoryID <> '%' 
	SET @sWhere1=@sWhere1+' AND MT1802.ProductID = ''' + @InventoryID + ''' '

IF @InventoryTypeID <>'%' 
	SET @sWhere2=@sWhere2+' AND AT1302.InventoryTypeID =''' + @InventoryTypeID + ''' '

IF @TeamID <>'%'
	SET @sWhere3=@sWhere3+' AND MT1801.TeamID = ''' + @TeamID + ''' '

SET @sSQL = '
	SELECT * FROM (
		SELECT MT1802.ProductID, AT1302.InventoryName AS ProductName, AT1302.I07ID, AT1015.AnaName AS Ana07Name, MT1802.ProductUnitID, AT1304.UnitName AS ProductUnitName,
		MT1801.TeamID, N''' + @TeamName + ''' AS TeamName, MT1802.Shift, HT1020.ShiftName, MT1801.VoucherDate, MT1801.ProductDate, MT1801.VoucherNo,
		ROUND(SUM(ISNULL(MT1802.ActualQuantity, 0)),'+LTRIM(@QuantityDecimals)+') as ActualQuantity, ROUND(SUM(ISNULL(MT1802.ErrorQuantity, 0)),'+LTRIM(@QuantityDecimals)+') as ErrorQuantity, B.CA1, B.CA2, B.CA3, 
		CASE WHEN ROUND(SUM(ISNULL(MT1802.ActualQuantity, 0)),'+LTRIM(@QuantityDecimals)+') = 0 THEN 0 ELSE ROUND( ROUND(SUM(ISNULL(MT1802.ErrorQuantity, 0)),'+LTRIM(@QuantityDecimals)+') * 100 / ROUND(SUM(ISNULL(MT1802.ActualQuantity, 0)),'+LTRIM(@QuantityDecimals)+'),2) END AS ErrorRate,
		AT1302.InventoryTypeID, AT1301.InventoryTypeName
		FROM MT1802 WITH (NOLOCK)
		INNER JOIN MT1801 WITH (NOLOCK) ON MT1801.DivisionID = MT1802.DivisionID AND MT1801.VoucherID = MT1802.VoucherID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID = MT1802.DivisionID AND AT1304.UnitID = MT1802.ProductUnitID
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = MT1802.DivisionID AND AT1302.InventoryID = MT1802.ProductID
		LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.DivisionID = MT1802.DivisionID AND AT1301.InventoryTypeID = AT1302.InventoryTypeID
		LEFT JOIN HT1020 WITH (NOLOCK) ON HT1020.DivisionID = MT1802.DivisionID AND HT1020.ShiftID = MT1802.Shift
		LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.DivisionID = AT1302.DivisionID AND AT1015.AnaID = AT1302.I07ID AND AT1015.AnaTypeID = ''I07''
		LEFT JOIN (SELECT DivisionID, max(CA1) AS CA1,max(CA2) CA2, max(CA3) CA3 FROM 
					(SELECT * FROM HT1020 WITH (NOLOCK)) b PIVOT (max(ShiftName) for ShiftID IN ([CA1],[CA2],[CA3])) A
					GROUP BY DivisionID) B ON MT1802.DivisionID = B.DivisionID
		WHERE MT1801.DivisionID = ''' + @DivisionID + '''
		' + @sWhere1 +
		@sWhere2 +
		@sWhere3+ '
		AND (MT1802.TypeTab = 2 OR MT1802.TypeTab = 3) ' + @sWhere + '
		GROUP BY MT1802.ProductID, AT1302.InventoryName, AT1302.I07ID, AT1015.AnaName, MT1802.ProductUnitID, AT1304.UnitName,
		MT1801.TeamID, MT1802.Shift, HT1020.ShiftName, MT1801.VoucherDate, MT1801.ProductDate, MT1801.VoucherNo, B.CA1, B.CA2, B.CA3,
		AT1302.InventoryTypeID, AT1301.InventoryTypeName 
	) X
	WHERE X.ErrorRate > ISNULL('+ltrim(@ErrorRate)+',0)
'

EXEC(@sSQL)
--select @sSQL


SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO