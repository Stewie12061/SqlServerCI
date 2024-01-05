IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load dữ liệu khi kế thừa
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Khả Vi on 10/05/2018
---- Modified by Kim Thư on 29/06/2018		- Lấy thêm cột IsSerialized để xét đổ dữ liệu ra grid 2 màn hình WF2021
---- Modified by Kim Thư on 7/8/2018		- Bỏ load dữ liệu kế thừa yêu cầu nhập kho, đã có store WMP20271 load dữ liệu kế thừa từ erp9
---- Modified by Anh Đô on 07/02/2023		- Select thêm cột OTransactionID
---- Modified by Tiến Thành on 04/04/2023	- Chỉnh sửa cột Thành tiền (Đơn giá * số lượng)
---- Modified by Bi Phan on 20/12/2023		- Thêm Cột Specification
---- Modified by Hương Nhung on 28/12/2023: Bổ sung luồng kế thừa TK có/ TK Nợ (Customize NKC)
-- <Example>
/*
	EXEC WMP2028 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @ScreenID = 'WMF2026', @XML = ''

	EXEC WMP2028 @DivisionID, @UserID, @ScreenID, @XML
*/

 CREATE PROCEDURE WMP2028
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @ScreenID VARCHAR(50),
     @XML XML
)
AS

CREATE TABLE #WMP2028 (APK VARCHAR(50), Quantity DECIMAL (28,8))

DECLARE @sSQL NVARCHAR(MAX)

INSERT INTO #WMP2028 (APK, Quantity)
SELECT	X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK,		
		X.Data.query('Quantity').value('.', 'DECIMAL (28,8)') AS Quantity
FROM	@XML.nodes('//Data') AS X (Data)

-- Kế thừa đơn hàng mua
IF @ScreenID = 'WMF2024'
BEGIN
	SET @sSQL = N'
	SELECT ''OT3001'' AS InheritTableID, OT3001.POrderID AS InheritVoucherID, OT3002.TransactionID AS InheritTransactionID, NULL AS WareHouseID, NULL AS WareHouseName, OT3001.ObjectID, AT1202.ObjectName, 
	OT3002.InventoryID, AT1302.IsSerialized, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, T1.Quantity AS ActualQuantity, OT3002.PurchasePrice AS UnitPrice, 
	AT1302.AccountID as CreditAccountName, AT1302.PrimeCostAccountID as DebitAccountName,
	(T1.Quantity *  OT3002.PurchasePrice) AS OriginalAmount, OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, 
	OT3002.Ana05ID, OT3002.Ana06ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID, (T1.Quantity * OT3002.PurchasePrice) AS ActualAmount, (T1.Quantity * OT3002.PurchasePrice) AS ConvertedAmount,
	OT3001.POrderID AS OrderID, OT3002.TransactionID AS OTransactionID,OT3002.PONumber
	, OT99.S01ID, OT99.S02ID, OT99.S03ID, OT99.S04ID, OT99.S05ID, OT99.S06ID, OT99.S07ID, OT99.S08ID, OT99.S09ID, OT99.S10ID
	, OT99.S11ID, OT99.S12ID, OT99.S13ID, OT99.S14ID, OT99.S15ID, OT99.S16ID, OT99.S17ID, OT99.S18ID, OT99.S19ID, OT99.S20ID
	, OT3002.Parameter01, OT3002.Parameter02, OT3002.Parameter03, OT3002.Parameter04, OT3002.Parameter05
	, OT3002.ConvertedUnitID, OT3002.ConvertedQuantity, OT3002.ConvertedSalePrice, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes,
	OT3002.Specification
	FROM OT3002 WITH (NOLOCK)
	LEFT JOIN OT3001 WITH (NOLOCK) ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (OT3002.DivisionID, ''@@@'') AND OT3001.ObjectID = AT1202.ObjectID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT3002.DivisionID, ''@@@'') AND OT3002.InventoryID = AT1302.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (OT3002.DivisionID, ''@@@'') AND AT1304.UnitID = AT1302.UnitID
	INNER JOIN #WMP2028 T1 ON OT3002.APK = T1.APK
	LEFT JOIN OT8899 OT99 WITH (NOLOCK) ON OT99.DivisionID = OT3002.DivisionID AND OT99.VoucherID = OT3002.POrderID AND OT99.TransactionID = OT3002.TransactionID
	LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (OT3002.DivisionID, ''@@@'') 
													AND WQ09.InventoryID = OT3002.InventoryID
													AND WQ09.ConvertedUnitID = OT3002.ConvertedUnitID
													--AND (WQ09.S01ID = OT99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(OT99.S01ID, '''')))
													--AND (WQ09.S02ID = OT99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(OT99.S02ID, '''')))
													--AND (WQ09.S03ID = OT99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(OT99.S03ID, '''')))
													--AND (WQ09.S04ID = OT99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(OT99.S04ID, '''')))
													--AND (WQ09.S05ID = OT99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(OT99.S05ID, '''')))
													--AND (WQ09.S06ID = OT99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(OT99.S06ID, '''')))
													--AND (WQ09.S07ID = OT99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(OT99.S07ID, '''')))
													--AND (WQ09.S08ID = OT99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(OT99.S08ID, '''')))
													--AND (WQ09.S09ID = OT99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(OT99.S09ID, '''')))
													--AND (WQ09.S10ID = OT99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(OT99.S10ID, '''')))
													--AND (WQ09.S11ID = OT99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(OT99.S11ID, '''')))
													--AND (WQ09.S12ID = OT99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(OT99.S12ID, '''')))
													--AND (WQ09.S13ID = OT99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(OT99.S13ID, '''')))
													--AND (WQ09.S14ID = OT99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(OT99.S14ID, '''')))
													--AND (WQ09.S15ID = OT99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(OT99.S15ID, '''')))
													--AND (WQ09.S16ID = OT99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(OT99.S16ID, '''')))
													--AND (WQ09.S17ID = OT99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(OT99.S17ID, '''')))
													--AND (WQ09.S18ID = OT99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(OT99.S18ID, '''')))
													--AND (WQ09.S19ID = OT99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(OT99.S19ID, '''')))
													--AND (WQ09.S20ID = OT99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(OT99.S20ID, '''')))
	WHERE OT3002.DivisionID = '''+@DivisionID+''''
END 

-- Kế thừa yêu cầu nhập kho
--IF @ScreenID = 'WMF2025'
--BEGIN
--	SET @sSQL = N'
--	SELECT ''WT0095'' AS InheritTableID, WT0095.APK AS InheritAPKMaster, T1.APK AS InheritAPK, WT0095.WareHouseID, AT1303.WareHouseName, WT0095.ObjectID, AT1202.ObjectName, 
--	WT0096.InventoryID, AT1302.InventoryName,AT1302.IsSerialized, AT1302.UnitID, AT1304.UnitName, T1.Quantity AS ActualQuantity, WT0096.UnitPrice, 
--	(T1.Quantity *  WT0096.UnitPrice) AS OriginalAmount, WT0096.Ana01ID, WT0096.Ana02ID, WT0096.Ana03ID, WT0096.Ana04ID, WT0096.Ana05ID, WT0096.Ana06ID, WT0096.Ana07ID, 
--	WT0096.Ana08ID, WT0096.Ana09ID, WT0096.Ana10ID
--	FROM WT0096 WITH (NOLOCK)
--	LEFT JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
--	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (WT0096.DivisionID, ''@@@'') AND WT0095.ObjectID = AT1202.ObjectID
--	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (WT0096.DivisionID, ''@@@'') AND WT0096.InventoryID = AT1302.InventoryID
--	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (WT0096.DivisionID, ''@@@'') AND AT1304.UnitID = AT1302.UnitID
--	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (WT0096.DivisionID, ''@@@'') AND WT0095.WareHouseID = AT1303.WareHouseID
--	INNER JOIN #WMP2028 T1 ON WT0096.APK = T1.APK
--	WHERE WT0096.DivisionID = '''+@DivisionID+''''
--END 

--PRINT @sSQL
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
