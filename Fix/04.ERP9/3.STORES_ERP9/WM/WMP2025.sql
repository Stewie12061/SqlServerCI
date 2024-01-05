IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load lưới 2: kế thừa đơn hàng mua (WMF2024)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Khả Vi, Date: 08/03/2018
----Modified by: Kim Thư, Date: 06/07/2018 - thêm cột InheritedQuantity và AvailableQuantity
----Modified by Tiến Thành, Date: 04/04/2023 - Đổi bảng WMT2006 và WMT2007 sang AT2006 và AT2007, chỉnh cột số lượng sau khi kế thừa đơn hàng
----Modified by Anh Đô, Date: 25/04/2023 - Select thêm cột VoucherNo, ConvertedAmount
----Modified by Hoàng Long, Date: 18/12/2023 - Select thêm cột TransactionID
-- <Example>
---- 
/*-- <Example>
	WMP2025 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @LstOrderID = 'DD/12/2017/0001', 
	@APK = '16EB848E-9AB5-4328-BB08-E47BE97FCEA9'
	
	WMP2025 @DivisionID, @UserID, @PageNumber, @PageSize, @LstOrderID, @APK
----*/

CREATE PROCEDURE WMP2025
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LstOrderID VARCHAR(4000),  ---- Danh sách OrderID check chọn ở lưới master
	 @APK VARCHAR(MAX)

)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@CustomerIndex INT,
		@ModelAnalyst VARCHAR(50)

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

IF @CustomerIndex = 88 ---- VIETFIRST
BEGIN
	SELECT @ModelAnalyst = ModelAnalyst
	FROM CSMT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID	
END 

SET @sSQL = N'
SELECT OT3002.APK, OT3001.APK AS APKMaster, OT3001.POrderID AS OrderID , OT3002.TransactionID, OT3002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, 
OT3002.PurchasePrice AS UnitPrice, OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID, OT3002.Ana06ID, OT3002.Ana07ID, 
OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID, CASE WHEN ISNULL(T3.IsCheck, '''') <> '''' THEN T3.IsCheck ELSE 0 END AS IsCheck, ISNULL(OT3002.OrderQuantity, 0) AS Quantity,
ISNULL(T2.ActualQuantity, 0) AS InheritedQuantity,
(ISNULL(OT3002.OrderQuantity, 0) - ISNULL(T2.ActualQuantity, 0)) AS AvailableQuantity, 
((ISNULL(OT3002.OrderQuantity, 0) - ISNULL(T2.ActualQuantity, 0))) * OT3002.PurchasePrice AS Amount
, ((ISNULL(OT3002.OrderQuantity, 0) - ISNULL(T2.ActualQuantity, 0))) * OT3002.PurchasePrice * OT3001.ExchangeRate AS ConvertedAmount
, OT3001.VoucherNo,OT3002.PONumber
, OT99.S01ID, OT99.S02ID, OT99.S03ID, OT99.S04ID, OT99.S05ID, OT99.S06ID, OT99.S07ID, OT99.S08ID, OT99.S09ID, OT99.S10ID
, OT99.S11ID, OT99.S12ID, OT99.S13ID, OT99.S14ID, OT99.S15ID, OT99.S16ID, OT99.S17ID, OT99.S18ID, OT99.S19ID, OT99.S20ID
, OT3002.Parameter01, OT3002.Parameter02, OT3002.Parameter03, OT3002.Parameter04, OT3002.Parameter05
, OT3002.ConvertedUnitID, OT3002.ConvertedQuantity, OT3002.ConvertedSalePrice, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
'+CASE WHEN @CustomerIndex = 88 THEN ', AT1302.'+@ModelAnalyst+'ID AS ModelID, CSMT1080.ModelName' ELSE '' END+'
FROM OT3002 WITH (NOLOCK)  
INNER JOIN OT3001 WITH (NOLOCK) ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID 
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT3002.DivisionID, ''@@@'') AND OT3002.InventoryID = AT1302.InventoryID 
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (OT3002.DivisionID, ''@@@'') AND AT1302.UnitID = AT1304.UnitID 
LEFT JOIN
(
	SELECT A.InventoryID, SUM(A.ActualQuantity) AS ActualQuantity, A.InheritTransactionID 
	FROM AT2007 A
	INNER JOIN AT2006 WITH (NOLOCK) ON A.VoucherID = AT2006.APK 
	WHERE A.DivisionID = '''+@DivisionID+''' AND AT2006.KindVoucherID = 1 AND A.InheritTableID = ''OT3001''
	AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 T1 WITH (NOLOCK) WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = A.APK 
	AND T1.InheritTransactionID = '''+@APK+''')
	GROUP BY A.InventoryID, A.InheritTransactionID 
) AS T2 ON OT3002.TransactionID = T2.InheritTransactionID 
LEFT JOIN 
(
	SELECT InheritTransactionID AS APK, 1 AS IsCheck FROM AT2007 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND VoucherID = '''+@APK+'''
) T3 ON OT3002.APK = T3.APK 
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
'+CASE WHEN @CustomerIndex = 88 THEN 'LEFT JOIN CSMT1080 WITH (NOLOCK)  ON CSMT1080.DivisionID IN (OT3002.DivisionID, ''@@@'') 
		AND AT1302.'+@ModelAnalyst+'ID = CSMT1080.ModelID' ELSE '' END+'
WHERE OT3002.DivisionID =  '''+@DivisionID+''' AND OT3002.POrderID IN ('''+@LstOrderID+''')
AND ISNULL(OT3002.OrderQuantity, 0) - ISNULL(T2.ActualQuantity, 0) > 0 
GROUP BY OT3002.APK, OT3001.APK, OT3001.POrderID, OT3002.TransactionID, OT3002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, OT3002.PurchasePrice, OT3002.Ana01ID, 
OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID, OT3002.Ana06ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID, T3.IsCheck, 
OT3002.OrderQuantity, T2.ActualQuantity, OT3002.OriginalAmount, OT3001.VoucherNo,OT3002.PONumber, OT3001.ExchangeRate
, OT99.S01ID, OT99.S02ID, OT99.S03ID, OT99.S04ID, OT99.S05ID, OT99.S06ID, OT99.S07ID, OT99.S08ID, OT99.S09ID, OT99.S10ID
, OT99.S11ID, OT99.S12ID, OT99.S13ID, OT99.S14ID, OT99.S15ID, OT99.S16ID, OT99.S17ID, OT99.S18ID, OT99.S19ID, OT99.S20ID
, OT3002.Parameter01, OT3002.Parameter02, OT3002.Parameter03, OT3002.Parameter04, OT3002.Parameter05
, OT3002.ConvertedUnitID, OT3002.ConvertedQuantity, OT3002.ConvertedSalePrice, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
'+CASE WHEN @CustomerIndex = 88 THEN ', AT1302.'+@ModelAnalyst+'ID, CSMT1080.ModelName' ELSE '' END+''


--PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
