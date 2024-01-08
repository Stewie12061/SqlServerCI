IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0029]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0029]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by Bảo Anh	Date: 30/09/2013
--- Purpose: Load detail đơn hàng bán
--- Modified on 27/04/2015 by Lê Thị Hạnh: Bổ sung load 3 trường Inherit [Customize ABA]
--- Modified by Thanh Sơn on 13/05/2015: Bổ sung load thêm 20 mã quy cách hàng
--- Modified by hoàng vũ on 15/06/2015: (Secoin) Bổ sung load thêm 2 trường ExtraID, ExtraName (Mã phụ)
--- Modified by Thanh Sơn on 06/07/2015: Bổ sung thêm trường YDQuantity (HYUNDAE)
--- Modify on 13/01/2016 by Bảo Anh: Bổ sung IsProInventoryID (Angel)
--- Modified by Tiểu Mai on 13/05/2016: Bổ sung trường DiscountSaleAmountDetail
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK) và tính thành tiền
--- Modified by Hải Long on 25/08/2016: Bổ sung thêm trường (nvarchar21 - nvarchar40), KmNumber cho ABA
--- Modified by Bảo Thy on 06/09/2016: Bổ sung Ghi nhận đơn hàng (SOrderIDRecognition)
--- Modified by Thị Phượng on 05/05/2017: Bổ sung Lấy DivisionID
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
--- Modified by Bảo Thy on 03/07/2017: Bổ sung IsPriceID (GODREJ)
---- Modified by Kim Thư on 28/02/2019: Tạo bảng tạm thay OV1302 tránh xung đột process khác
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Thông on 16/10/2020 : Bổ sung order id của đơn hàng kế thừa trên APP
---- Modified by Xuân Nguyên on 05/01/2023 : Bổ sung ProductID và ProductName cho Thiên Nam
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Thành Sang on 12/06/2023: Bổ sung trường WarehouseFee cho BOURBON
---- Modified by Đình Định on 15/06/2023: BBL - Bổ sung trường QuantityOfWarehouseRental Số lượng thuê kho.

--- EXEC OP0029 'AS','007c3440-c71f-48a0-92b0-44e9ebe1e8c8'


CREATE PROCEDURE [dbo].[OP0029] 
(
	@DivisionID nvarchar(50),
	@SOrderID nvarchar(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sSQL5 NVARCHAR(MAX),
		@OrderDate DATETIME,
		@ObjectID VARCHAR(50),
		@PriceListID VARCHAR(50)		
SET @sSQL4 = ''
SET @sSQL5 = ''

		 
SELECT @OrderDate = OrderDate, @ObjectID = ObjectID, @PriceListID = ISNULL(PriceListID,'') FROM OT2001 WHERE SOrderID = @SOrderID 

DECLARE @OV1302 TABLE (DivisionID VARCHAR(50), InventoryID VARCHAR(50), InventoryName NVARCHAR(MAX), Specification NVARCHAR(250), UnitID VARCHAR(50), UnitName NVARCHAR(250),
InventoryTypeID VARCHAR(50), IsStocked TINYINT, VATGroupID VARCHAR(50), VATPercent DECIMAL(28,8), SalePrice DECIMAL(28,8), UnitPrice DECIMAL(28,8), MinPrice DECIMAL(28,8),
MaxPrice DECIMAL(28,8), MinQuantity DECIMAL(28,8), MaxQuantity DECIMAL(28,8), TypePriceControl DECIMAL(28,8), TypeQuantityControl DECIMAL(28,8), 
SalePrice01 DECIMAL(28,8), SalePrice02 DECIMAL(28,8), SalePrice03 DECIMAL(28,8), SalePrice04 DECIMAL(28,8), SalePrice05 DECIMAL(28,8), 
Notes NVARCHAR(250), Notes01 NVARCHAR(250), Notes02 NVARCHAR(250),
Barcode NVARCHAR(50), DiscountPercent DECIMAL(28,8), DiscountAmount DECIMAL(28,8), 
SaleOffPercent01 DECIMAL(28,8), SaleOffAmount01 DECIMAL(28,8), SaleOffPercent02 DECIMAL(28,8), SaleOffAmount02 DECIMAL(28,8), 
SaleOffPercent03 DECIMAL(28,8), SaleOffAmount03 DECIMAL(28,8), SaleOffPercent04 DECIMAL(28,8), SaleOffAmount04 DECIMAL(28,8), 
SaleOffPercent05 DECIMAL(28,8), SaleOffAmount05 DECIMAL(28,8), 
FromQuantity1 DECIMAL(28,8), ToQuantity1 DECIMAL(28,8), Price1 DECIMAL(28,8), DiscountAmount1 DECIMAL(28,8), 
FromQuantity2 DECIMAL(28,8), ToQuantity2 DECIMAL(28,8), Price2 DECIMAL(28,8), DiscountAmount2 DECIMAL(28,8), 
FromQuantity3 DECIMAL(28,8), ToQuantity3 DECIMAL(28,8), Price3 DECIMAL(28,8), DiscountAmount3 DECIMAL(28,8), 
FromQuantity4 DECIMAL(28,8), ToQuantity4 DECIMAL(28,8), Price4 DECIMAL(28,8), DiscountAmount4 DECIMAL(28,8), 
FromQuantity5 DECIMAL(28,8), ToQuantity5 DECIMAL(28,8), Price5 DECIMAL(28,8), DiscountAmount5 DECIMAL(28,8), 
FromQuantity6 DECIMAL(28,8), ToQuantity6 DECIMAL(28,8), Price6 DECIMAL(28,8), DiscountAmount6 DECIMAL(28,8), 
FromQuantity7 DECIMAL(28,8), ToQuantity7 DECIMAL(28,8), Price7 DECIMAL(28,8), DiscountAmount7 DECIMAL(28,8), 
FromQuantity8 DECIMAL(28,8), ToQuantity8 DECIMAL(28,8), Price8 DECIMAL(28,8), DiscountAmount8 DECIMAL(28,8), 
FromQuantity9 DECIMAL(28,8), ToQuantity9 DECIMAL(28,8), Price9 DECIMAL(28,8), DiscountAmount9 DECIMAL(28,8), 
FromQuantity10 DECIMAL(28,8), ToQuantity10 DECIMAL(28,8), Price10 DECIMAL(28,8), DiscountAmount10 DECIMAL(28,8), 
OT0117Price DECIMAL(28,8), OT0117Discount DECIMAL(28,8), O01ID VARCHAR(50), TrayPrice DECIMAL(28,8), DecreaseTrayPrice DECIMAL(28,8), Qtyfrom DECIMAL(28,8), QtyTo DECIMAL(28,8),
IsPlanPrice TINYINT, ReceivedPrice DECIMAL(28,8), S1 VARCHAR(50), S2 VARCHAR(50), S3 VARCHAR(50), AccountID VARCHAR(50), IsSource TINYINT, IsLocation TINYINT, IsLimitDate TINYINT,
IsDiscount TINYINT, SalesAccountID VARCHAR(50), PurchaseAccountID VARCHAR(50), PrimeCostAccountID VARCHAR(50), MethodID TINYINT, DeliveryPrice DECIMAL(28,8), ETaxID VARCHAR(50),
ETaxConvertedUnit DECIMAL(28,8), NRTClassifyID VARCHAR(50), SETID VARCHAR(50), AddCost01 DECIMAL(28,8), AddCost02 DECIMAL(28,8), AddCost03 DECIMAL(28,8), AddCost04 DECIMAL(28,8),
AddCost05 DECIMAL(28,8), AddCost06 DECIMAL(28,8), AddCost07 DECIMAL(28,8), AddCost08 DECIMAL(28,8),
AddCost09 DECIMAL(28,8), AddCost10 DECIMAL(28,8), AddCost11 DECIMAL(28,8), AddCost12 DECIMAL(28,8),
AddCost13 DECIMAL(28,8), AddCost14 DECIMAL(28,8), AddCost15 DECIMAL(28,8), IsPriceID TINYINT,
NRTUnitID VARCHAR(50), NRTClassifyName NVARCHAR(MAX), NRTTaxRate DECIMAL(28,8), SETName NVARCHAR(250), SETUnitID NVARCHAR(50), 
SETTaxRate DECIMAL(28,8), ETaxName NVARCHAR(MAX), ETaxUnitID VARCHAR(50))

INSERT INTO @OV1302
EXEC OP1302 @DivisionID,@ObjectID,@OrderDate,@PriceListID

SELECT * INTO #OV1302 FROM @OV1302



--- Tạo bảng tạm thay cho view OV3011		
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM
	
SELECT AT1309.DivisionID,
AT1309.InventoryID,
AT1309.UnitID,
AT1304.UnitName,
AT1309.ConversionFactor,
AT1309.Operator,
CASE WHEN AT1309.DataType = 0 AND AT1309.Operator = 0 THEN N'WQ1309.MultiplyStr' 
     WHEN AT1309.DataType = 0 AND AT1309.Operator = 1 THEN N'WQ1309.Divide' 
     ELSE '' END AS OperatorName,
AT1309.FormulaID, AT1319.FormulaDes, AT1309.DataType,
CASE WHEN AT1309.DataType = 0 THEN 'WQ1309.Operators' 
     WHEN AT1309.DataType = 1 THEN 'WQ1309.Formula'
     ELSE '' END AS DataTypeName 
INTO #TAM
FROM AT1309 WITH (NOLOCK) 
INNER JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1309.UnitID
LEFT JOIN AT1319 WITH (NOLOCK) on AT1309.FormulaID = AT1319.FormulaID
WHERE AT1309.DivisionID IN (@DivisionID, '@@@') And AT1309.Disabled = 0 

UNION ALL

SELECT 
AT1302.DivisionID,
AT1302.InventoryID,
AT1302.UnitID,
AT1304.UnitName,
CAST(1 AS DECIMAL(28, 8)) AS ConversionFactor,
CAST(0 AS TINYINT) AS Operator, 
N'WQ1309.MultiplyStr' AS OperatorName,
CAST(null AS NVARCHAR(250)) AS FormulaID, 
CAST(null AS NVARCHAR(250)) AS FormulaDes, 
CAST(0 AS TINYINT) AS DataType, 
'WQ1309.Operators' AS DataTypeName
FROM AT1302 WITH (NOLOCK) 
INNER JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
WHERE AT1302.DivisionID IN (@DivisionID, '@@@')
			
--- Trả ra dữ liệu
SET @sSQL = N'
SELECT *  FROM (
SELECT	distinct OT2002.DivisionID, 
		OT2002.SOrderID,
		OT2002.TransactionID,
		AT1302.IsStocked,
		OT2002.InventoryID, 
		AT1302.InventoryName AS AInventoryName, 
		case when ISNULL(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else OT2002.InventoryCommonName end AS 
		InventoryName, 	
		AT1302.Barcode,	
		ISNULL(OT2002.UnitID,AT1302.UnitID) AS  UnitID,
		ISNULL(T04.UnitName,AT1304.UnitName) AS  UnitName,
		OT2002.ExtraID,
		AT1311.ExtraName,
		OT2002.OrderQuantity, 
		CAST(0 AS BIT) IsSelected,
		OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
		OT2002.SalePrice, 
		OT2002.ConvertedAmount,
		OT2002.OriginalAmount, 
		OT2002.VATConvertedAmount, 
		OT2002.VATOriginalAmount, 
		OT2002.VATPercent, 		
		OT2002.DiscountConvertedAmount,  
		OT2002.DiscountOriginalAmount,
		OT2002.DiscountPercent, 
		OT2002.CommissionPercent, 
		OT2002.CommissionCAmount, 
		OT2002.CommissionOAmount, 
		
		(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
            - ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
            AS OriginalAmountBeforeVAT,
		        
		(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
		- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
		AS ConvertAmountBeforeVAT,
		
		(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0)
            - ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
            - OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
            
		(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - ISNULL(OT2002.DiscountSaleAmountDetail,0) -  (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
		'
SET @sSQL1 = '	
		IsPicking, 
		OT2002.WareHouseID, 
		WareHouseName,  
		OT2002.AdjustQuantity, 
		Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
		Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
		Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
		Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
		Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
		Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,		
		OT2003.Date01, OT2003.Date02, OT2003.Date03, OT2003.Date04, OT2003.Date05, 
		OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10, 
		Date11, Date12, Date13, Date14, Date15, 
		Date16, Date17, Date18, Date19, Date20, 
		Date21, Date22, Date23, Date24, Date25, 
		Date26, Date27, Date28, Date29, Date30,
		OT2002.LinkNo, 
		OT2002.EndDate, 
		OT2002.Orders, 
		OT2002.Description, 
		OT2002.RefInfor,
		OT2002.Ana01ID, 
		OT2002.Ana02ID, 
		OT2002.Ana03ID,
		OT2002.Ana04ID, 
-- (ABA) Thinh Lấy ra tên tài xế
		AT111.AnaName [AnaName04],

		OT2002.Ana05ID,
		OT2002.Ana06ID, 
		OT2002.Ana07ID, 
		OT2002.Ana08ID,
		OT2002.Ana09ID, 
		OT2002.Ana10ID,
	---	ActualQuantity, 
	---	EndQuantity AS RemainQuantity,
		OT2002.Finish ,
		OT2002.Notes,
		OT2002.Notes01,
		OT2002.Notes02,
		OT2002.QuotationID,
		OT2002.VATGroupID,
		OT2002.SaleOffPercent01,
		OT2002.SaleOffAmount01,
		OT2002.SaleOffPercent02,
		OT2002.SaleOffAmount02,
		OT2002.SaleOffPercent03,
		OT2002.SaleOffAmount03,
		OT2002.SaleOffPercent04,
		OT2002.SaleOffAmount04,
		OT2002.SaleOffPercent05,
		OT2002.SaleOffAmount05,
		OT2002.QuoTransactionID,
		'
	SET @sSQL2 = '
		(CASE WHEN (SELECT TOP 1 CustomerName FROM CustomerIndex) = 46 THEN O99.UnitPriceStandard ELSE OT2002.Pricelist END) Pricelist,
		OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05,
		OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,
		OT2002.Varchar01 nvarchar11, OT2002.Varchar02 nvarchar12, OT2002.Varchar03 nvarchar13, OT2002.Varchar04 nvarchar14, OT2002.Varchar05 nvarchar15,
		OT2002.Varchar06 nvarchar16, OT2002.Varchar07 nvarchar17, OT2002.Varchar08 nvarchar18, OT2002.Varchar09 nvarchar19, OT2002.Varchar10 nvarchar20,
		OT2002.Varchar11 nvarchar21, OT2002.Varchar12 nvarchar22, OT2002.Varchar13 nvarchar23, OT2002.Varchar14 nvarchar24, OT2002.Varchar15 nvarchar25,
		OT2002.Varchar16 nvarchar26, OT2002.Varchar17 nvarchar27, OT2002.Varchar18 nvarchar28, OT2002.Varchar19 nvarchar29, OT2002.Varchar20 nvarchar30,
		OT2002.Varchar21 nvarchar31, OT2002.Varchar22 nvarchar32, OT2002.Varchar23 nvarchar33, OT2002.Varchar24 nvarchar34, OT2002.Varchar25 nvarchar35,
		OT2002.Varchar26 nvarchar36, OT2002.Varchar27 nvarchar37, OT2002.Varchar28 nvarchar38, OT2002.Varchar29 nvarchar39, OT2002.Varchar30 nvarchar40,
		OT2002.ConvertedQuantity, OT2002.SOKitTransactionID,OT2002.ConvertedSaleprice,
		(SELECT OrderQuantity FROM OT2002 T02 Where T02.TransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID)
		- (ISNULL((SELECT Sum(OrderQuantity) FROM OT2002 T02 Where T02.RefSTransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID),0))
		AS RemainOrderQuantity,
		OT2002.Markup,
		ISNULL(OT2002.OriginalAmountOutput, OT2002.OriginalAmount*(1+ISNULL(Markup,0)/100)) AS OriginalAmountOutput,
		OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) AS ConvertedAmountOutput,
		OT2002.DeliveryDate,
		OT2002.ConvertedSalepriceInput,
		OT2002.ShipDate,
		OT2002.Allowance,
		OV1302.MinPrice, OV1302.MaxPrice, OV1302.MinQuantity, OV1302.MaxQuantity,
		OV3011.ConversionFactor, OV3011.Operator, OV3011.DataType, OV3011.FormulaDes,
		AT1302.IsDiscount, OT2002.InheritTableID, OT2002.InheritVoucherID,
		OT2002.InheritTransactionID, OT2002.YDQuantity,
		OT2002.ReadyQuantity, OT2002.PlanPercent, OT2002.PlanQuantity, OT2002.IsProInventoryID, OT2002.DiscountSaleAmountDetail, OT2002.KmNumber, OT2002.SOrderIDRecognition,
		OT2002.AppInheritOrderID,
		OV1302.IsPriceID,
		OT2002.ProductID,
		OT2002.ProductName,
		OT2002.WarehouseFee,
		OT2002.QuantityOfWarehouseRental
		'
SET @sSQL3 = N'
	FROM OT2002 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
		LEFT JOIN AT1311 WITH (NOLOCK) ON OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
		LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
		LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = OT2002.UnitID
		LEFT JOIN OT2003 WITH (NOLOCK) ON OT2002.DivisionID = OT2003.DivisionID AND OT2003.SOrderID = OT2002.SOrderID
		
		-- Lấy tên Tài Xế dựa theo Mã phân tích(ABA)
		LEFT JOIN AT1011 AT111 WITH (NOLOCK) ON AT111.AnaID = OT2002.Ana04ID AND AT111.AnaTypeID = ''A04''

		---LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID	
		LEFT JOIN #TAM OV3011 ON OV3011.DivisionID = OT2002.DivisionID AND OV3011.InventoryID = OT2002.InventoryID AND OV3011.UnitID = OT2002.UnitID
		LEFT JOIN #OV1302 OV1302 ON OV1302.DivisionID = OT2002.DivisionID AND OV1302.InventoryID = OT2002.InventoryID AND OV1302.UnitID = OT2002.UnitID
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID'
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL4 = @sSQL4 + ',
		O99.S01ID, AT01.StandardName S01Name, O99.SUnitPrice01,
		O99.S02ID, AT02.StandardName S02Name, O99.SUnitPrice02,
		O99.S03ID, AT03.StandardName S03Name, O99.SUnitPrice03,
		O99.S04ID, AT04.StandardName S04Name, O99.SUnitPrice04,
		O99.S05ID, AT05.StandardName S05Name, O99.SUnitPrice05,
		O99.S06ID, AT06.StandardName S06Name, O99.SUnitPrice06,
		O99.S07ID, AT07.StandardName S07Name, O99.SUnitPrice07,
		O99.S08ID, AT08.StandardName S08Name, O99.SUnitPrice08,
		O99.S09ID, AT09.StandardName S09Name, O99.SUnitPrice09,		
		O99.S10ID, AT10.StandardName S10Name, O99.SUnitPrice10,
		O99.S11ID, AT11.StandardName S11Name, O99.SUnitPrice11,
		O99.S12ID, AT12.StandardName S12Name, O99.SUnitPrice12,
		O99.S13ID, AT13.StandardName S13Name, O99.SUnitPrice13,
		O99.S14ID, AT14.StandardName S14Name, O99.SUnitPrice14,
		O99.S15ID, AT15.StandardName S15Name, O99.SUnitPrice15,
		O99.S16ID, AT16.StandardName S16Name, O99.SUnitPrice16,
		O99.S17ID, AT17.StandardName S17Name, O99.SUnitPrice17,
		O99.S18ID, AT18.StandardName S18Name, O99.SUnitPrice18,
		O99.S19ID, AT19.StandardName S19Name, O99.SUnitPrice19,
		O99.S20ID, AT20.StandardName S20Name, O99.SUnitPrice20 '
	
	SET @sSQL5 = @sSQL5 + '
		--LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID = OT2002.TransactionID
		LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = O99.S01ID AND AT01.StandardTypeID = ''S01''
		LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = O99.S02ID AND AT02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = O99.S03ID AND AT03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = O99.S04ID AND AT04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = O99.S05ID AND AT05.StandardTypeID = ''S05'' 
		LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = O99.S06ID AND AT06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = O99.S07ID AND AT07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = O99.S08ID AND AT08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = O99.S09ID AND AT09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = O99.S10ID AND AT10.StandardTypeID = ''S10''
		LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = O99.S11ID AND AT11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = O99.S12ID AND AT12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = O99.S13ID AND AT13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = O99.S15ID AND AT14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = O99.S15ID AND AT15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = O99.S16ID AND AT16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = O99.S17ID AND AT17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = O99.S18ID AND AT18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = O99.S19ID AND AT19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20'''
END

SET @sSQL5 = @sSQL5 + '
WHERE	OT2002.DivisionID = '''+@DivisionID+''' And OT2002.SOrderID = '''+@SOrderID+''') A ORDER BY Orders	'

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL4
--PRINT @sSQL3
--PRINT @sSQL5

EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL4 + @sSQL3 + @sSQL5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
