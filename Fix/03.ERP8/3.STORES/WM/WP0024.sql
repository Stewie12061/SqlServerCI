IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo thống kê cước vận chuyển
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
------- Created By Hải Long
------ Date 22/11/2016
----- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
--EXEC WP0024	@DivisionID = 'HT', @FromPeriod = 201601, @ToPeriod = 201601, @FromDate = '2016-01-01', @ToDate = '2016-01-30', @FromVoucherTypeID = 'XB1',
--@ToVoucherTypeID = 'XZ', @ImWareHouseID = 'KDD', @ExWareHouseID = 'KTP', @ObjectID = 'KNN.KOR.0001', @Mode = 2, @IsDate = 1
---- 

CREATE PROCEDURE [dbo].[WP0024]
(
	@DivisionID nvarchar(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromVoucherTypeID nvarchar(50),
	@ToVoucherTypeID nvarchar(50),
	@ImWareHouseID nvarchar(50),
	@ExWareHouseID nvarchar(50),
	@ObjectID nvarchar(50),
	@Mode TINYINT, --0 Phiếu xuất --1: Phiếu VCNB --2: Cả 2
	@IsDate TINYINT 
)
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = ''	
		
IF @IsDate = 0
BEGIN	
	SET @sWhere = @sWhere + '
	AND AT2006.TranMonth + AT2006.TranYear * 100 BETWEEN ' + Convert(Nvarchar(10),@FromPeriod) + ' AND ' + CONVERT(NVARCHAR(10),@ToPeriod)
END 
ELSE		
BEGIN	
	SET @sWhere = @sWhere + '
	AND AT2006.VoucherDate BETWEEN ''' + Convert(nvarchar(10),@FromDate,21) + ''' AND ''' + convert(nvarchar(10), @ToDate,21) +''''
END 
				

SET @sSQL1 = '
	SELECT AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, SUM(AT2007.KITQuantity) AS KITQuantity, AT1326.Weight, 
	(SUM(AT2007.KITQuantity) * AT1326.Weight) AS TotalWeight, AT2007.Notes04 AS LicensePlate
	FROM AT2007 WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1326 WITH (NOLOCK) ON AT1326.KITID = AT2007.KITID
	WHERE AT2006.DivisionID = ''' + @DivisionID + '''
	AND AT2006.ObjectID = ''' + @ObjectID + '''
	AND AT2006.VoucherTypeID BETWEEN ''' + @FromVoucherTypeID + ''' AND ''' + @ToVoucherTypeID + '''
	AND AT2006.WareHouseID = ''' + @ExWareHouseID + '''' + @sWhere +'
	AND AT2006.KindVoucherID = 2
	GROUP BY AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, AT1326.Weight, AT2007.Notes04
	ORDER BY AT2006.VoucherDate, AT2007.InventoryID
'

SET @sSQL2 = '
	SELECT AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, SUM(AT2007.KITQuantity) AS KITQuantity, AT1326.Weight, 
	(SUM(AT2007.KITQuantity) * AT1326.Weight) AS TotalWeight, AT2007.Notes04 AS LicensePlate
	FROM AT2007 WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1326 WITH (NOLOCK) ON AT1326.KITID = AT2007.KITID
	WHERE AT2006.DivisionID = ''' + @DivisionID + '''
	AND AT2006.ObjectID = ''' + @ObjectID + '''
	AND AT2006.VoucherTypeID BETWEEN ''' + @FromVoucherTypeID + ''' AND ''' + @ToVoucherTypeID + '''
	AND AT2006.WareHouseID = ''' + @ImWareHouseID + '''
	AND AT2006.WareHouseID2 = ''' + @ExWareHouseID + '''' + @sWhere +'
	AND AT2006.KindVoucherID = 3
	GROUP BY AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, AT1326.Weight, AT2007.Notes04
	ORDER BY AT2006.VoucherDate, AT2007.InventoryID	
'

SET @sSQL3 = '
SELECT TB.VoucherDate, TB.InventoryID, TB.InventoryName, SUM(TB.KITQuantity) AS KITQuantity, TB.Weight, (SUM(TB.KITQuantity) * TB.Weight) AS TotalWeight, TB.LicensePlate
FROM 
(
	SELECT AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, AT2007.KITQuantity, AT1326.Weight, AT2007.Notes04 AS LicensePlate
	FROM AT2007 WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1326 WITH (NOLOCK) ON AT1326.KITID = AT2007.KITID
	WHERE AT2006.DivisionID = ''' + @DivisionID + '''
	AND AT2006.ObjectID = ''' + @ObjectID + '''
	AND AT2006.VoucherTypeID BETWEEN ''' + @FromVoucherTypeID + ''' AND ''' + @ToVoucherTypeID + '''
	AND AT2006.WareHouseID = ''' + @ExWareHouseID + '''' + @sWhere +'
	AND AT2006.KindVoucherID = 2
UNION ALL
	SELECT AT2006.VoucherDate, AT2007.InventoryID, AT1302.InventoryName, AT2007.KITQuantity, AT1326.Weight, AT2007.Notes04 AS LicensePlate
	FROM AT2007 WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	LEFT JOIN AT1326 WITH (NOLOCK) ON AT1326.KITID = AT2007.KITID
	WHERE AT2006.DivisionID = ''' + @DivisionID + '''
	AND AT2006.ObjectID = ''' + @ObjectID + '''
	AND AT2006.VoucherTypeID BETWEEN ''' + @FromVoucherTypeID + ''' AND ''' + @ToVoucherTypeID + '''
	AND AT2006.WareHouseID = ''' + @ImWareHouseID + '''
	AND AT2006.WareHouseID2 = ''' + @ExWareHouseID + '''' + @sWhere +'
	AND AT2006.KindVoucherID = 3
) TB
GROUP BY TB.VoucherDate, TB.InventoryID, TB.InventoryName, TB.Weight, TB.LicensePlate
ORDER BY TB.VoucherDate, TB.InventoryID
'

--1: Phiếu xuất
IF @Mode = 0
BEGIN
	EXEC (@sSQL1)
	PRINT @sSQL1
END
ELSE
--2: Phiếu VCNB
IF @Mode = 1
BEGIN
	EXEC (@sSQL2)
	PRINT @sSQL2
END
ELSE 
--3: Cả 2	
IF @Mode = 2
BEGIN
	EXEC (@sSQL3)
	PRINT @sSQL3
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO