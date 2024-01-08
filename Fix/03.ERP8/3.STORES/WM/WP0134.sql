IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0134]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0134]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Cảnh báo tồn kho dưới Min và dưới mức đặt hàng (EIMSKIP)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created on 17/02/2017 by Bảo Thy
---- Modified by Hải Long on 25/05/2017: Chỉnh sửa danh mục dùng chung
/* <Example>
	exec WP0134 @DivisionID=N'ESP', @TranMonth=2, @TranYear=2017, @VoucherDate='2017-02-28 00:00:00', @WareHouseID=N'KHO4', @ContractID = 'CT20170000000011', 
	@Quantity = 50, @InventoryID = 'GAO', @VoucherID = '', @Mode = 1

	exec WP0134 @DivisionID=N'ESP', @TranMonth=2, @TranYear=2017, @VoucherDate='2017-02-28 00:00:00', @WareHouseID=N'KHO4', @ContractID = 'CT20170000000011', 
	@Quantity = 150, @InventoryID = 'GAO', @VoucherID = '', @Mode = 0
*/

CREATE PROCEDURE WP0134
(
    @DivisionID AS VARCHAR(50), 
	@TranMonth INT,
	@TranYear INT,
    @VoucherDate AS DATETIME, 
    @WareHouseID AS VARCHAR(50),
	@ContractID AS VARCHAR(50),
	@InventoryID AS VARCHAR(50),
	@Quantity DECIMAL(28,8),
	@VoucherID AS VARCHAR(50),
	@Mode TINYINT -- 0: NK, 1: XK
)
AS
DECLARE @sSQL NVARCHAR(MAX)='',
		@sWhere NVARCHAR(MAX)=''

IF ISNULL(@VoucherID,'') <> '' SET @sWhere = 'AND AV7000.VoucherID <> '''+@VoucherID+''' '

CREATE TABLE #WP0134_Error (DivisionID VARCHAR(50), InventoryID VARCHAR(50), InventoryName NVARCHAR(250), WareHouseID VARCHAR(50), WareHouseName NVARCHAR(250), Status TINYINT, Message VARCHAR(50))

IF @Mode = 0
BEGIN
	SET @sSQL = N'
	---- vượt mức tối đa đối với phiếu nhập kho
	IF NOT EXISTS (SELECT TOP 1 1 FROM AV7000 WHERE AV7000.DivisionID = '''+@DivisionID+'''
	AND AV7000.WareHouseID = '''+@WareHouseID+'''
	AND AV7000.InventoryID = '''+@InventoryID+''')
	BEGIN 
		INSERT INTO #WP0134_Error
		SELECT '''+@DivisionID+''', '''+@InventoryID+''', 
		(SELECT InventoryName FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1302.InventoryID = '''+@InventoryID+''') AS InventoryName ,
		'''+@WareHouseID+''', (SELECT InventoryName FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1302.InventoryID = '''+@WareHouseID+''') AS WarehouseName ,
		1 AS [Status], ''WFML000219'' AS [Message]
		FROM AT1314 WITH (NOLOCK)
		WHERE AT1314.DivisionID IN ('''+@DivisionID+''', ''@@@'')
		AND  '''+@WareHouseID+''' LIKE AT1314.WareHouseID 
		AND AT1314.InventoryID = '''+@InventoryID+'''
		AND '+CONVERT(VARCHAR(50),@Quantity)+' > AT1314.MaxQuantity
	END
	ELSE
	BEGIN
		INSERT INTO #WP0134_Error
		SELECT AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, 1 AS [Status], ''WFML000219'' AS [Message]
		FROM AV7000 
		LEFT JOIN AT1314 WITH (NOLOCK) ON AV7000.InventoryID = AT1314.InventoryID AND AV7000.WareHouseID LIKE AT1314.WareHouseID 
		WHERE AV7000.DivisionID = '''+@DivisionID+'''
		AND AV7000.WareHouseID = '''+@WareHouseID+'''
		AND AV7000.InventoryID = '''+@InventoryID+'''
		AND (AV7000.VoucherDate <= '''+CONVERT(VARCHAR(10),@VoucherDate,120)+''' OR AV7000.D_C = ''BD'')
		'+@sWhere+'
		GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, AT1314.MaxQuantity
		HAVING SUM(AV7000.SignQuantity) + '+CONVERT(VARCHAR(50),@Quantity)+' > AT1314.MaxQuantity
	END

	SELECT * FROM #WP0134_Error ORDER BY InventoryID, WareHouseID

	DROP TABLE #WP0134_Error
	'
END
ELSE --@Mode = 1
BEGIN
	SET @sSQL = N'
	---- dưới mức tối thiểu đối với phiếu xuất kho
	INSERT INTO #WP0134_Error
	SELECT AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, 1 AS [Status], ''WFML000218'' AS [Message]
	FROM AV7000 
	LEFT JOIN AT1314 WITH (NOLOCK) ON AV7000.InventoryID = AT1314.InventoryID AND AV7000.WareHouseID LIKE AT1314.WareHouseID 
	WHERE AV7000.DivisionID = '''+@DivisionID+'''
	AND AV7000.WareHouseID = '''+@WareHouseID+'''
	AND AV7000.InventoryID = '''+@InventoryID+'''
	AND (AV7000.VoucherDate <= '''+CONVERT(VARCHAR(10),@VoucherDate,120)+''' OR AV7000.D_C = ''BD'')
	'+@sWhere+'
	GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, AV7000.WareHouseName, AT1314.MinQuantity
	HAVING SUM(AV7000.SignQuantity) - '+CONVERT(VARCHAR(50),@Quantity)+' < AT1314.MinQuantity

	SELECT * FROM #WP0134_Error ORDER BY InventoryID, WareHouseID

	DROP TABLE #WP0134_Error
	'
END

--PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
