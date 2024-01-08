IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP20003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP20003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load Grid chi tiết đơn hàng bán - ViewMasterDetail2 - Copy từ Store OP0077-ERP8
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Hoài Bảo on: 21/09/2022
---- Modified by: Đình Định on: 20/10/2022 -  Hiển thị chi tiết đơn hàng mua khi vào xét duyệt đơn
---- Modified by: Viết Toàn on: 09/03/2023 - Hiển thị cột ngày nhận hàng và số lô lên lưới chi tiết đơn mua hàng
---- Modified by: Đức Tuyên on: 17/08/2023 - Hiển thị mã phân tích mặt hàng customize INNOTEK.
-----Modified by: Hoàng Long on 15/09/2023 : Bổ sung trường số PO
-----Modified by: Đức Tuyên on 28/11/2023 : Bổ sung quy cách + đơn vị quy đổi.
-----Modified by: Thanh Lượng on 25/12/2023 : [2023/12/TA/0200] - Bổ sung trường PONumber.
-- <Example>
/*
	POP20003 'HD', '', 'HDVNS-H1506022'
*/
CREATE PROCEDURE POP20003
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@POrderID VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@IsViewDetail INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25
)
AS
DECLARE
		 @sSQL VARCHAR(MAX)='',
		 @sSQL1 VARCHAR(MAX)='',
		 @sSQL2 VARCHAR(MAX)='',
		 @sSQL3 VARCHAR(MAX)='',
		 @Swhere  Nvarchar(max) = '',
		 @Swhere1  Nvarchar(max) = '',
		 @Level INT,
		 @sSQLSL NVARCHAR (MAX) = '',
		 @sSQLJon NVARCHAR (MAX) = '',
		 @i INT = 1, @s VARCHAR(2),
		 @TotalRow VARCHAR(50),
		 @OrderDate DATETIME,
		 @ObjectID VARCHAR(50),
		 @PriceListID VARCHAR(50),
		 @IsPriceID TINYINT = 1

IF NOT EXISTS
	(
		SELECT TOP 1 1 
		FROM OT3001 WITH (NOLOCK) 
		WHERE DivisionID = @DivisionID 
			AND POrderID = @POrderID
	)
BEGIN
	IF(ISNULL(@APKMaster, '') = '') SET @APKMaster = @POrderID;
	SET @POrderID = (SELECT TOP 1 POrderID FROM OT3001 WITH (NOLOCK) WHERE APKMaster_9000 = @POrderID
)
END

SELECT @OrderDate = OrderDate, @ObjectID = ObjectID, @PriceListID = ISNULL(PriceListID,'') FROM OT3001 WHERE POrderID = @POrderID



DECLARE @OV1302 TABLE (DivisionID VARCHAR(50), InventoryID VARCHAR(50), InventoryName NVARCHAR(MAX), Specification NVARCHAR(MAX), UnitID VARCHAR(50), UnitName NVARCHAR(250),
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

IF EXISTS (SELECT TOP 1 * FROM OT1301)
BEGIN
		--print ('AAA')
	INSERT INTO @OV1302
	
	EXEC OP1302 @DivisionID,@ObjectID,@OrderDate,@PriceListID
	--print ('BBBB')
END
SELECT * INTO #OV1302 FROM @OV1302

IF NOT EXISTS (SELECT TOP 1 * FROM #OV1302)
	SET @IsPriceID = 0


print (@APKMaster)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@Type, '') = 'DHM' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),O32.APKMaster_9000)= '''+@APKMaster+''''
SELECT  @Level = MAX(ApproveLevel) FROM OT3002 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND O32.POrderID = '''+@POrderID+''''
SELECT  @Level = MAX(ApproveLevel) FROM OT3002 WITH (NOLOCK) WHERE POrderID = @POrderID AND DivisionID = @DivisionID
END



	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APK9001'+@s+', Status'+@s+', Approvel'+@s+'Note, ApprovalDate'+@s+''
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT OOT1.APK APK9001'+@s+', OOT1.APKMaster,OOT1.DivisionID, T94.APKDetail APK2001,
						T94.Status Status'+@s+',
						O99.Description StatusName'+@s+',
						T94.Note Approvel'+@s+'Note,
						T94.ApprovalDate ApprovalDate'+@s+'
						FROM OOT9001 OOT1 WITH (NOLOCK)
						LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND T94.DeleteFlag = 0
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(T94.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE O32.APK END = O32.APK '
		SET @i = @i + 1
	END	




IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
SET @sSQL = 'SELECT 
		'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY O32.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		O32.DivisionID, O32.POrderID, O32.APK, O32.TransactionID, O31.VoucherTypeID, O31.VoucherNo, O31.OrderDate,
		O31.InventoryTypeID, A01.InventoryTypeName, A02.IsStocked, A02.Barcode, O32.InventoryID,  O32.UnitID,
		A04.UnitName, O32.MethodID, O03.MethodName, ISNULL(O32.OrderQuantity,0) AS OrderQuantity, ISNULL(O32.PurchasePrice,0) AS PurchasePrice,
		ISNULL(O32.ConvertedAmount,0) AS ConvertedAmount, ISNULL(O32.OriginalAmount,0) AS OriginalAmount, ISNULL(O32.VATConvertedAmount,0) AS VATConvertedAmount, O32.PONumber,
		ISNULL(O32.VATOriginalAmount,0) AS VATOriginalAmount, O32.VATPercent, O32.DiscountConvertedAmount,
		O32.DiscountOriginalAmount, O32.DiscountPercent, O32.OriginalAmount - O32.DiscountOriginalAmount OriginalAmountBeforeVAT,
		O32.ImTaxPercent, O32.ImTaxOriginalAmount, O32.ImTaxConvertedAmount,
		(O32.OriginalAmount - O32.DiscountOriginalAmount + O32.VATOriginalAmount +  O32.ImTaxOriginalAmount) OriginalAmountAfterVAT,
		O32.IsPicking, O32.WareHouseID, A03.WareHouseName, O32.Quantity01, O32.Quantity02, O32.Quantity03,
		O32.Quantity04, O32.Quantity05, O32.Quantity06, O32.Quantity07, O32.Quantity08, O32.Quantity09, O32.Quantity10,
		O32.Quantity11, O32.Quantity12, O32.Quantity13, O32.Quantity14, O32.Quantity15, O32.Quantity16, O32.Quantity17,
		O32.Quantity18, O32.Quantity19, O32.Quantity20, 
		O32.Quantity21, O32.Quantity22, O32.Quantity23, O32.Quantity24, O32.Quantity25, O32.Quantity26, O32.Quantity27,
		O32.Quantity28, O32.Quantity29, O32.Quantity30,
		O33.Date01, O33.Date02, O33.Date03, O33.Date04, O33.Date05, O33.Date06, O33.Date07, O33.Date08, O33.Date09, O33.Date10, 
		O33.Date11, O33.Date12, O33.Date13, O33.Date14, O33.Date15, O33.Date16, O33.Date17, O33.Date18, O33.Date19, O33.Date20, 
		O33.Date21, O33.Date22, O33.Date23, O33.Date24, O33.Date25, O33.Date26, O33.Date27, O33.Date28, O33.Date29, O33.Date30,
		O32.Orders, O32.[Description],O32.Ana01ID, T01.AnaName As Ana01Name, O32.Ana02ID, T02.AnaName As Ana02Name, O32.Ana03ID, T03.AnaName As Ana03Name,
		O32.Ana04ID, T04.AnaName As Ana04Name, O32.Ana05ID, T05.AnaName As Ana05Name,
		O32.Ana06ID, T06.AnaName As Ana06Name, O32.Ana07ID, T07.AnaName As Ana07Name, O32.Ana08ID, T08.AnaName As Ana08Name,
		O32.Ana09ID, T09.AnaName As Ana09Name , O32.Ana10ID, T10.AnaName As Ana10Name, O32.Ana10ID, A32.InventoryName AInventoryName, 
		(CASE WHEN ISNULL(O32.InventoryCommonName, '''') = '''' THEN A02.InventoryName ELSE O32.InventoryCommonName END) InventoryName,
		V92.ActualQuantity, V92.EndQuantity RemainQuantity, O32.Finish ,O32.Notes, O32.Notes01, O32.Notes02, 
		O32.Notes03, O32.Notes04, O32.Notes05, O32.Notes06, O32.Notes07, O32.Notes08, O32.Notes09, O32.RefTransactionID,
		O32.ROrderID, O31.ContractNo, O32.ConvertedQuantity, O32.ConvertedSalePrice, O32.ReceiveDate, 
		O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05,
		O32.StrParameter01,	O32.StrParameter02,	O32.StrParameter03,	O32.StrParameter04,	O32.StrParameter05,
		O32.StrParameter06,	O32.StrParameter07,	O32.StrParameter08,	O32.StrParameter09,	O32.StrParameter10,
		O32.StrParameter11,	O32.StrParameter12,	O32.StrParameter13,	O32.StrParameter14,	O32.StrParameter15,
		O32.StrParameter16,	O32.StrParameter17,	O32.StrParameter18,	O32.StrParameter19,	O32.StrParameter20,
		O32.nvarchar01, O32.nvarchar02, O32.nvarchar03, O32.nvarchar04, O32.nvarchar05, O32.nvarchar06, O32.nvarchar07, O32.nvarchar08, O32.nvarchar09, O32.nvarchar10,
		O32.nvarchar11, O32.nvarchar12,O32.nvarchar13, O32.nvarchar14, O32.nvarchar15, O32.nvarchar16, O32.nvarchar17, O32.nvarchar18, O32.nvarchar19, O32.nvarchar20,
		--O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID,
		--O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID,
		--O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O99.UnitPriceStandard,
		'


SET @sSQL1 = '
		AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
		AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
		AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
		AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
		O32.InheritTableID, O32.InheritVoucherID, O32.InheritTransactionID,
		'+ CASE WHEN @IsPriceID = 0 THEN LTRIM(@IsPriceID)+' AS IsPriceID' ELSE 'OV1302.IsPriceID' END 
		+', O32.RequestQuantity, O32.RequestConvertedQuantity
		, O32.Status, O32.ApproveLevel, O32.ApprovingLevel, O32.APKMaster_9000 APKMaster , A32.Specification
		, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
		, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		, O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05
		, O32.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
		'+@sSQLSL+'
		FROM OT3002 O32 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON O32.APKMaster_9000 = OOT90.APK
		LEFT JOIN OV2902 V92 ON V92.POrderID = O32.POrderID AND V92.TransactionID = O32.TransactionID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', O32.DivisionID) AND A32.InventoryID = O32.InventoryID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = O32.WareHouseID
		LEFT JOIN OT1003 O03 WITH (NOLOCK) ON O03.DivisionID = O32.DivisionID AND O03.MethodID = O32.MethodID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = O32.UnitID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O32.DivisionID) AND A02.InventoryID = O32.InventoryID
		LEFT JOIN OT3001 O31 WITH (NOLOCK) ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN OT3003 O33 WITH (NOLOCK) ON O33.POrderID = O31.POrderID AND O33.DivisionID = O31.DivisionID 
		LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = O31.InventoryTypeID
		'+ CASE WHEN @IsPriceID = 0 THEN '' ELSE 'LEFT JOIN #OV1302 OV1302 ON OV1302.DivisionID = O32.DivisionID AND OV1302.InventoryID = O32.InventoryID AND OV1302.UnitID = O32.UnitID' END +'
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = O32.DivisionID AND O99.VoucherID = O32.POrderID AND O99.TransactionID = O32.TransactionID'
SET @sSQL2 = '
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
		LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20''
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = O32.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = O32.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = O32.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = O32.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = O32.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = O32.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = O32.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = O32.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = O32.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = O32.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (O32.DivisionID, ''@@@'') 
													AND WQ09.InventoryID = O32.InventoryID
													AND WQ09.ConvertedUnitID = O32.ConvertedUnitID
													--AND (WQ09.S01ID = O99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(O99.S01ID, '''')))
													--AND (WQ09.S02ID = O99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(O99.S02ID, '''')))
													--AND (WQ09.S03ID = O99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(O99.S03ID, '''')))
													--AND (WQ09.S04ID = O99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(O99.S04ID, '''')))
													--AND (WQ09.S05ID = O99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(O99.S05ID, '''')))
													--AND (WQ09.S06ID = O99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(O99.S06ID, '''')))
													--AND (WQ09.S07ID = O99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(O99.S07ID, '''')))
													--AND (WQ09.S08ID = O99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(O99.S08ID, '''')))
													--AND (WQ09.S09ID = O99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(O99.S09ID, '''')))
													--AND (WQ09.S10ID = O99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(O99.S10ID, '''')))
													--AND (WQ09.S11ID = O99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(O99.S11ID, '''')))
													--AND (WQ09.S12ID = O99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(O99.S12ID, '''')))
													--AND (WQ09.S13ID = O99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(O99.S13ID, '''')))
													--AND (WQ09.S14ID = O99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(O99.S14ID, '''')))
													--AND (WQ09.S15ID = O99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(O99.S15ID, '''')))
													--AND (WQ09.S16ID = O99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(O99.S16ID, '''')))
													--AND (WQ09.S17ID = O99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(O99.S17ID, '''')))
													--AND (WQ09.S18ID = O99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(O99.S18ID, '''')))
													--AND (WQ09.S19ID = O99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(O99.S19ID, '''')))
													--AND (WQ09.S20ID = O99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(O99.S20ID, '''')))
		'+@sSQLJon+'
	WHERE O32.DivisionID = '''+@DivisionID+''''+@Swhere+'
	Order by O32.Orders
'
END
ELSE IF((select CustomerName From CustomerIndex) = 147)
BEGIN
	SET @sSQL='
	SELECT
		'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY O32.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		O32.DivisionID, O32.POrderID, O32.APK, O32.TransactionID, O31.VoucherTypeID, O31.VoucherNo, O31.OrderDate,
		O31.InventoryTypeID, A01.InventoryTypeName, A02.IsStocked, A02.Barcode, O32.InventoryID,  O32.UnitID,
		A04.UnitName, O32.MethodID, O03.MethodName, ISNULL(O32.OrderQuantity,0) AS OrderQuantity, ISNULL(O32.PurchasePrice,0) AS PurchasePrice,
		ISNULL(O32.ConvertedAmount,0) AS ConvertedAmount, ISNULL(O32.OriginalAmount,0) AS OriginalAmount, ISNULL(O32.VATConvertedAmount,0) AS VATConvertedAmount, O32.PONumber,
		ISNULL(O32.VATOriginalAmount,0) AS VATOriginalAmount, O32.VATPercent, O32.DiscountConvertedAmount,
		O32.DiscountOriginalAmount, O32.DiscountPercent, O32.OriginalAmount - O32.DiscountOriginalAmount OriginalAmountBeforeVAT,
		O32.ImTaxPercent, O32.ImTaxOriginalAmount, O32.ImTaxConvertedAmount,
		(O32.OriginalAmount - O32.DiscountOriginalAmount + O32.VATOriginalAmount +  O32.ImTaxOriginalAmount) OriginalAmountAfterVAT,
		O32.IsPicking, O32.WareHouseID, A03.WareHouseName, O32.Quantity01, O32.Quantity02, O32.Quantity03,
		O32.Quantity04, O32.Quantity05, O32.Quantity06, O32.Quantity07, O32.Quantity08, O32.Quantity09, O32.Quantity10,
		O32.Quantity11, O32.Quantity12, O32.Quantity13, O32.Quantity14, O32.Quantity15, O32.Quantity16, O32.Quantity17,
		O32.Quantity18, O32.Quantity19, O32.Quantity20, 
		O32.Quantity21, O32.Quantity22, O32.Quantity23, O32.Quantity24, O32.Quantity25, O32.Quantity26, O32.Quantity27,
		O32.Quantity28, O32.Quantity29, O32.Quantity30,O32.CostOriginalAmount,O32.CostConvertedAmount,O32.DescriptionCost,O32.ImportAndExportDuties,O32.IExportDutiesConvertedAmount,O32.SafeguardingDuties,O32.SafeguardingDutiesConvertedAmount,O32.DifferentDuties,O32.DifferentDutiesConvertedAmount,O32.SumDuties,O32.Contquantity,O32.CostTowing,
		O33.Date01, O33.Date02, O33.Date03, O33.Date04, O33.Date05, O33.Date06, O33.Date07, O33.Date08, O33.Date09, O33.Date10, 
		O33.Date11, O33.Date12, O33.Date13, O33.Date14, O33.Date15, O33.Date16, O33.Date17, O33.Date18, O33.Date19, O33.Date20, 
		O33.Date21, O33.Date22, O33.Date23, O33.Date24, O33.Date25, O33.Date26, O33.Date27, O33.Date28, O33.Date29, O33.Date30,
		O32.Orders, O32.[Description],O32.Ana01ID, T01.AnaName As Ana01Name, O32.Ana02ID, T02.AnaName As Ana02Name, O32.Ana03ID, T03.AnaName As Ana03Name,
		O32.Ana04ID, T04.AnaName As Ana04Name, O32.Ana05ID, T05.AnaName As Ana05Name,
		O32.Ana06ID, T06.AnaName As Ana06Name, O32.Ana07ID, T07.AnaName As Ana07Name, O32.Ana08ID, T08.AnaName As Ana08Name,
		O32.Ana09ID, T09.AnaName As Ana09Name , O32.Ana10ID, T10.AnaName As Ana10Name, A32.InventoryName AInventoryName, 
		(CASE WHEN ISNULL(O32.InventoryCommonName, '''') = '''' THEN A02.InventoryName ELSE O32.InventoryCommonName END) InventoryName,
		V92.ActualQuantity, V92.EndQuantity RemainQuantity, O32.Finish ,O32.Notes, O32.Notes01, O32.Notes02, 
		O32.Notes03, O32.Notes04, O32.Notes05, O32.Notes06, O32.Notes07, O32.Notes08, O32.Notes09, O32.RefTransactionID,
		O32.ROrderID, O31.ContractNo, O32.ConvertedQuantity, O32.ConvertedSaleprice, O32.ReceiveDate, 
		O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05,
		O32.StrParameter01,	O32.StrParameter02,	O32.StrParameter03,	O32.StrParameter04,	O32.StrParameter05,
		O32.StrParameter06,	O32.StrParameter07,	O32.StrParameter08,	O32.StrParameter09,	O32.StrParameter10,
		O32.StrParameter11,	O32.StrParameter12,	O32.StrParameter13,	O32.StrParameter14,	O32.StrParameter15,
		O32.StrParameter16,	O32.StrParameter17,	O32.StrParameter18,	O32.StrParameter19,	O32.StrParameter20,
		O32.nvarchar01, O32.nvarchar02, O32.nvarchar03, O32.nvarchar04, O32.nvarchar05, O32.nvarchar06, O32.nvarchar07, O32.nvarchar08, O32.nvarchar09, O32.nvarchar10,
		'
		SET @sSQL1 = '
		O32.nvarchar11, O32.nvarchar12,O32.nvarchar13, O32.nvarchar14, O32.nvarchar15, O32.nvarchar16, O32.nvarchar17, O32.nvarchar18, O32.nvarchar19, O32.nvarchar20,
		O32.InheritTableID, O32.InheritVoucherID, O32.InheritTransactionID, '+ CASE WHEN @IsPriceID = 0 THEN LTRIM(@IsPriceID)+' AS IsPriceID' ELSE 'OV1302.IsPriceID' END + '
		, O32.RequestQuantity, O32.RequestConvertedQuantity,O32.ProductPrice,
		O32.Status, O32.ApproveLevel, O32.ApprovingLevel, O32.APKMaster_9000 APKMaster, A32.Specification, A32.RefInventoryID
		'+@sSQLSL+'
		FROM OT3002 O32 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON O32.APKMaster_9000 = OOT90.APK
		LEFT JOIN OV2902 V92 ON V92.POrderID = O32.POrderID AND V92.TransactionID = O32.TransactionID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', O32.DivisionID) AND A32.InventoryID = O32.InventoryID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = O32.WareHouseID
		LEFT JOIN OT1003 O03 WITH (NOLOCK) ON O03.DivisionID = O32.DivisionID AND O03.MethodID = O32.MethodID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = O32.UnitID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O32.DivisionID) AND A02.InventoryID = O32.InventoryID
		LEFT JOIN OT3001 O31 WITH (NOLOCK) ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN OT3003 O33 WITH (NOLOCK) ON O33.POrderID = O31.POrderID AND O33.DivisionID = O31.DivisionID 
		LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = O31.InventoryTypeID
		'+ CASE WHEN @IsPriceID = 0 THEN '' ELSE 'LEFT JOIN #OV1302 OV1302 ON OV1302.DivisionID = O32.DivisionID AND OV1302.InventoryID = O32.InventoryID AND OV1302.UnitID = O32.UnitID' END + '
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = O32.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = O32.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = O32.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = O32.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = O32.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = O32.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = O32.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = O32.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = O32.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = O32.Ana10ID AND T10.AnaTypeID = ''A10''
		'+@sSQLJon+'
	WHERE O32.DivisionID = '''+@DivisionID+''''+@Swhere+'
	Order by O32.Orders'
END
ELSE
IF ((select CustomerName From CustomerIndex) = 57)
BEGIN
	SET @sSQL='
		SELECT O32.DivisionID, O32.POrderID, O32.TransactionID, O31.VoucherTypeID, O31.VoucherNo, O31.OrderDate,
		O31.InventoryTypeID, A01.InventoryTypeName, A02.IsStocked, A02.Barcode, O32.InventoryID,  O32.UnitID,
		A04.UnitName, O32.MethodID, O03.MethodName, ISNULL(O32.OrderQuantity,0) AS OrderQuantity, ISNULL(O32.PurchasePrice,0) AS PurchasePrice,
		ISNULL(O32.ConvertedAmount,0) AS ConvertedAmount, ISNULL(O32.OriginalAmount,0) AS OriginalAmount, ISNULL(O32.VATConvertedAmount,0) AS VATConvertedAmount,
		ISNULL(O32.VATOriginalAmount,0) AS VATOriginalAmount, O32.VATPercent, O32.DiscountConvertedAmount,
		O32.DiscountOriginalAmount, O32.DiscountPercent, O32.OriginalAmount - O32.DiscountOriginalAmount OriginalAmountBeforeVAT,
		O32.ImTaxPercent, O32.ImTaxOriginalAmount, O32.ImTaxConvertedAmount,
		(O32.OriginalAmount - O32.DiscountOriginalAmount + O32.VATOriginalAmount +  O32.ImTaxOriginalAmount) OriginalAmountAfterVAT,
		O32.IsPicking, O32.WareHouseID, A03.WareHouseName, O32.Quantity01, O32.Quantity02, O32.Quantity03,
		O32.Quantity04, O32.Quantity05, O32.Quantity06, O32.Quantity07, O32.Quantity08, O32.Quantity09, O32.Quantity10,
		O32.Quantity11, O32.Quantity12, O32.Quantity13, O32.Quantity14, O32.Quantity15, O32.Quantity16, O32.Quantity17,
		O32.Quantity18, O32.Quantity19, O32.Quantity20, 
		O32.Quantity21, O32.Quantity22, O32.Quantity23, O32.Quantity24, O32.Quantity25, O32.Quantity26, O32.Quantity27,
		O32.Quantity28, O32.Quantity29, O32.Quantity30,
		O33.Date01, O33.Date02, O33.Date03, O33.Date04, O33.Date05, O33.Date06, O33.Date07, O33.Date08, O33.Date09, O33.Date10, 
		O33.Date11, O33.Date12, O33.Date13, O33.Date14, O33.Date15, O33.Date16, O33.Date17, O33.Date18, O33.Date19, O33.Date20, 
		O33.Date21, O33.Date22, O33.Date23, O33.Date24, O33.Date25, O33.Date26, O33.Date27, O33.Date28, O33.Date29, O33.Date30,
		O32.Orders, O32.[Description], O32.Ana01ID, O32.Ana02ID, O32.Ana03ID, O32.Ana04ID, O32.Ana05ID,
		O32.Ana06ID, O32.Ana07ID, O32.Ana08ID, O32.Ana09ID, O32.Ana10ID, A32.InventoryName AInventoryName, 
		(CASE WHEN ISNULL(O32.InventoryCommonName, '''') = '''' THEN A02.InventoryName ELSE O32.InventoryCommonName END) InventoryName,
		V92.ActualQuantity, V92.EndQuantity RemainQuantity, O32.Finish ,O32.Notes, O32.Notes01, O32.Notes02, 
		O32.Notes03, O32.Notes04, O32.Notes05, O32.Notes06, O32.Notes07, O32.Notes08, O32.Notes09, O32.RefTransactionID,
		O32.ROrderID, O31.ContractNo, O32.ConvertedQuantity, O32.ConvertedSaleprice, O32.ShipDate, O32.ReceiveDate, 
		O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05,
		O32.StrParameter01,	O32.StrParameter02,	O32.StrParameter03,	O32.StrParameter04,	O32.StrParameter05,
		O32.StrParameter06,	O32.StrParameter07,	O32.StrParameter08,	O32.StrParameter09,	O32.StrParameter10,
		O32.StrParameter11,	O32.StrParameter12,	O32.StrParameter13,	O32.StrParameter14,	O32.StrParameter15,
		O32.StrParameter16,	O32.StrParameter17,	O32.StrParameter18,	O32.StrParameter19,	O32.StrParameter20'
	SET @sSQL1 = '
	FROM OT3002 O32 WITH (NOLOCK)
		LEFT JOIN OV2902 V92 ON V92.POrderID = O32.POrderID AND V92.TransactionID = O32.TransactionID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID in (''@@@'',O32.DivisionID) AND A32.InventoryID = O32.InventoryID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = O32.WareHouseID
		LEFT JOIN OT1003 O03 WITH (NOLOCK) ON O03.DivisionID = O32.DivisionID AND O03.MethodID = O32.MethodID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = O32.UnitID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID in (''@@@'',O32.DivisionID) AND A02.InventoryID = O32.InventoryID
		LEFT JOIN OT3001 O31 WITH (NOLOCK) ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN OT3003 O33 WITH (NOLOCK) ON O33.POrderID = O31.POrderID AND O33.DivisionID = O31.DivisionID 
		LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = O31.InventoryTypeID
	WHERE O32.DivisionID = '''+@DivisionID+''''+@Swhere+'
	Order by O32.Orders'

END
ELSE IF ((select CustomerName From CustomerIndex) = 161)
BEGIN
		SET @sSQL='
	SELECT
		'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY O32.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		O32.DivisionID, O32.POrderID, O32.APK, O32.TransactionID, O31.VoucherTypeID, O31.VoucherNo, O31.OrderDate,
		O31.InventoryTypeID, A01.InventoryTypeName, A02.IsStocked, A02.Barcode, O32.InventoryID,  O32.UnitID,
		A04.UnitName, O32.MethodID, O03.MethodName, ISNULL(O32.OrderQuantity,0) AS OrderQuantity, ISNULL(O32.PurchasePrice,0) AS PurchasePrice,
		ISNULL(O32.ConvertedAmount,0) AS ConvertedAmount, ISNULL(O32.OriginalAmount,0) AS OriginalAmount, ISNULL(O32.VATConvertedAmount,0) AS VATConvertedAmount,
		ISNULL(O32.VATOriginalAmount,0) AS VATOriginalAmount, O32.VATPercent, O32.DiscountConvertedAmount,
		O32.DiscountOriginalAmount, O32.DiscountPercent, O32.OriginalAmount - O32.DiscountOriginalAmount OriginalAmountBeforeVAT,
		O32.ImTaxPercent, O32.ImTaxOriginalAmount, O32.ImTaxConvertedAmount,
		(O32.OriginalAmount - O32.DiscountOriginalAmount + O32.VATOriginalAmount +  O32.ImTaxOriginalAmount) OriginalAmountAfterVAT,
		O32.IsPicking, O32.WareHouseID, A03.WareHouseName, O32.Quantity01, O32.Quantity02, O32.Quantity03,
		O32.Quantity04, O32.Quantity05, O32.Quantity06, O32.Quantity07, O32.Quantity08, O32.Quantity09, O32.Quantity10,
		O32.Quantity11, O32.Quantity12, O32.Quantity13, O32.Quantity14, O32.Quantity15, O32.Quantity16, O32.Quantity17,
		O32.Quantity18, O32.Quantity19, O32.Quantity20, 
		O32.Quantity21, O32.Quantity22, O32.Quantity23, O32.Quantity24, O32.Quantity25, O32.Quantity26, O32.Quantity27,
		O32.Quantity28, O32.Quantity29, O32.Quantity30,
		O33.Date01, O33.Date02, O33.Date03, O33.Date04, O33.Date05, O33.Date06, O33.Date07, O33.Date08, O33.Date09, O33.Date10, O33.Date11, O33.Date12, O33.Date13, O33.Date14, O33.Date15, O33.Date16, O33.Date17, O33.Date18, O33.Date19, O33.Date20, O33.Date21, O33.Date22, O33.Date23, O33.Date24, O33.Date25, O33.Date26, O33.Date27, O33.Date28, O33.Date29, O33.Date30,
		O32.Orders, O32.[Description],O32.Ana01ID, T01.AnaName As Ana01Name, O32.Ana02ID, T02.AnaName As Ana02Name, O32.Ana03ID, T03.AnaName As Ana03Name,O32.Ana04ID, T04.AnaName As Ana04Name, O32.Ana05ID, T05.AnaName As Ana05Name,
		O32.Ana06ID, T06.AnaName As Ana06Name, O32.Ana07ID, T07.AnaName As Ana07Name, O32.Ana08ID, T08.AnaName As Ana08Name,O32.Ana09ID, T09.AnaName As Ana09Name , O32.Ana10ID, T10.AnaName As Ana10Name, A32.InventoryName AInventoryName, 
		O32.I01ID, AT01.AnaName As I01Name, O32.I02ID, AT02.AnaName As I02Name, O32.I03ID, AT03.AnaName As I03Name,O32.I04ID, AT04.AnaName As I04Name, O32.I05ID, AT05.AnaName As I05Name,
		O32.I06ID, AT06.AnaName As I06Name, O32.I07ID, AT07.AnaName As I07Name, O32.I08ID, AT08.AnaName As I08Name,O32.I09ID, AT09.AnaName As I09Name , O32.I10ID, AT10.AnaName As I10Name,
		(CASE WHEN ISNULL(O32.InventoryCommonName, '''') = '''' THEN A02.InventoryName ELSE O32.InventoryCommonName END) InventoryName,
		V92.ActualQuantity, V92.EndQuantity RemainQuantity, O32.Finish ,O32.Notes, O32.Notes01, O32.Notes02, 
		O32.Notes03, O32.Notes04, O32.Notes05, O32.Notes06, O32.Notes07, O32.Notes08, O32.Notes09, O32.RefTransactionID,
		O32.ROrderID, O31.ContractNo, O32.ConvertedQuantity, O32.ConvertedSaleprice, O32.ReceiveDate, 
		O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05,
		O32.StrParameter01,	O32.StrParameter02,	O32.StrParameter03,	O32.StrParameter04,	O32.StrParameter05,
		O32.StrParameter06,	O32.StrParameter07,	O32.StrParameter08,	O32.StrParameter09,	O32.StrParameter10,
		O32.StrParameter11,	O32.StrParameter12,	O32.StrParameter13,	O32.StrParameter14,	O32.StrParameter15,
		O32.StrParameter16,	O32.StrParameter17,	O32.StrParameter18,	O32.StrParameter19,	O32.StrParameter20
		'+@sSQLSL+' 
		,O32.nvarchar01, O32.nvarchar02, O32.nvarchar03, O32.nvarchar04, O32.nvarchar05, O32.nvarchar06, O32.nvarchar07, O32.nvarchar08, O32.nvarchar09, O32.nvarchar10,
		O32.nvarchar11, O32.nvarchar12,O32.nvarchar13, O32.nvarchar14, O32.nvarchar15, O32.nvarchar16, O32.nvarchar17, O32.nvarchar18, O32.nvarchar19, O32.nvarchar20,'
SET @sSQL1 = '
		O32.InheritTableID, O32.InheritVoucherID, O32.InheritTransactionID, '+ CASE WHEN @IsPriceID = 0 THEN LTRIM(@IsPriceID)+' AS IsPriceID' ELSE 'OV1302.IsPriceID' END + '
		, O32.RequestQuantity, O32.RequestConvertedQuantity,
		O32.Status, O32.ApproveLevel, O32.ApprovingLevel, O32.APKMaster_9000 APKMaster, A32.Specification, A32.RefInventoryID
		, O32.IsProInventoryID
		,O32.ReceivedDate, O32.SourceNo
		FROM OT3002 O32 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON O32.APKMaster_9000 = OOT90.APK
		LEFT JOIN OV2902 V92 ON V92.POrderID = O32.POrderID AND V92.TransactionID = O32.TransactionID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', O32.DivisionID) AND A32.InventoryID = O32.InventoryID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = O32.WareHouseID
		LEFT JOIN OT1003 O03 WITH (NOLOCK) ON O03.DivisionID = O32.DivisionID AND O03.MethodID = O32.MethodID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = O32.UnitID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O32.DivisionID) AND A02.InventoryID = O32.InventoryID
		LEFT JOIN OT3001 O31 WITH (NOLOCK) ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN OT3003 O33 WITH (NOLOCK) ON O33.POrderID = O31.POrderID AND O33.DivisionID = O31.DivisionID 
		LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = O31.InventoryTypeID
		'+ CASE WHEN @IsPriceID = 0 THEN '' ELSE 'LEFT JOIN #OV1302 OV1302 ON OV1302.DivisionID = O32.DivisionID AND OV1302.InventoryID = O32.InventoryID AND OV1302.UnitID = O32.UnitID' END + '
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = O32.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = O32.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = O32.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = O32.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = O32.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = O32.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = O32.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = O32.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = O32.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = O32.Ana10ID AND T10.AnaTypeID = ''A10''
		LEFT JOIN AT1015 AT01 WITH (NOLOCK) ON AT01.AnaID = O32.I01ID AND AT01.AnaTypeID = ''I01''
		LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = O32.I02ID AND AT02.AnaTypeID = ''I02''
		LEFT JOIN AT1015 AT03 WITH (NOLOCK) ON AT03.AnaID = O32.I03ID AND AT03.AnaTypeID = ''I03''
		LEFT JOIN AT1015 AT04 WITH (NOLOCK) ON AT04.AnaID = O32.I04ID AND AT04.AnaTypeID = ''I04''
		LEFT JOIN AT1015 AT05 WITH (NOLOCK) ON AT05.AnaID = O32.I05ID AND AT05.AnaTypeID = ''I05''
		LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = O32.I06ID AND AT06.AnaTypeID = ''I06''
		LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = O32.I07ID AND AT07.AnaTypeID = ''I07''
		LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = O32.I08ID AND AT08.AnaTypeID = ''I08''
		LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = O32.I09ID AND AT09.AnaTypeID = ''I09''
		LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = O32.I10ID AND AT10.AnaTypeID = ''I10''
		'+@sSQLJon+'
	WHERE O32.DivisionID = '''+@DivisionID+''''+@Swhere+'
	Order by O32.Orders'
END
ELSE
BEGIN
	SET @sSQL='
	SELECT
		'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY O32.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		O32.DivisionID, O32.POrderID, O32.APK, O32.TransactionID, O31.VoucherTypeID, O31.VoucherNo, O31.OrderDate,
		O31.InventoryTypeID, A01.InventoryTypeName, A02.IsStocked, A02.Barcode, O32.InventoryID,  O32.UnitID,
		A04.UnitName, O32.MethodID, O03.MethodName, ISNULL(O32.OrderQuantity,0) AS OrderQuantity, ISNULL(O32.PurchasePrice,0) AS PurchasePrice,
		ISNULL(O32.ConvertedAmount,0) AS ConvertedAmount, ISNULL(O32.OriginalAmount,0) AS OriginalAmount, ISNULL(O32.VATConvertedAmount,0) AS VATConvertedAmount, O32.PONumber,
		ISNULL(O32.VATOriginalAmount,0) AS VATOriginalAmount, O32.VATPercent, O32.DiscountConvertedAmount,
		O32.DiscountOriginalAmount, O32.DiscountPercent, O32.OriginalAmount - O32.DiscountOriginalAmount OriginalAmountBeforeVAT,
		O32.ImTaxPercent, O32.ImTaxOriginalAmount, O32.ImTaxConvertedAmount,
		(O32.OriginalAmount - O32.DiscountOriginalAmount + O32.VATOriginalAmount +  O32.ImTaxOriginalAmount) OriginalAmountAfterVAT,
		O32.IsPicking, O32.WareHouseID, A03.WareHouseName, O32.Quantity01, O32.Quantity02, O32.Quantity03,
		O32.Quantity04, O32.Quantity05, O32.Quantity06, O32.Quantity07, O32.Quantity08, O32.Quantity09, O32.Quantity10,
		O32.Quantity11, O32.Quantity12, O32.Quantity13, O32.Quantity14, O32.Quantity15, O32.Quantity16, O32.Quantity17,
		O32.Quantity18, O32.Quantity19, O32.Quantity20, 
		O32.Quantity21, O32.Quantity22, O32.Quantity23, O32.Quantity24, O32.Quantity25, O32.Quantity26, O32.Quantity27,
		O32.Quantity28, O32.Quantity29, O32.Quantity30,
		O33.Date01, O33.Date02, O33.Date03, O33.Date04, O33.Date05, O33.Date06, O33.Date07, O33.Date08, O33.Date09, O33.Date10, 
		O33.Date11, O33.Date12, O33.Date13, O33.Date14, O33.Date15, O33.Date16, O33.Date17, O33.Date18, O33.Date19, O33.Date20, 
		O33.Date21, O33.Date22, O33.Date23, O33.Date24, O33.Date25, O33.Date26, O33.Date27, O33.Date28, O33.Date29, O33.Date30,
		O32.Orders, O32.[Description],O32.Ana01ID, T01.AnaName As Ana01Name, O32.Ana02ID, T02.AnaName As Ana02Name, O32.Ana03ID, T03.AnaName As Ana03Name,
		O32.Ana04ID, T04.AnaName As Ana04Name, O32.Ana05ID, T05.AnaName As Ana05Name,
		O32.Ana06ID, T06.AnaName As Ana06Name, O32.Ana07ID, T07.AnaName As Ana07Name, O32.Ana08ID, T08.AnaName As Ana08Name,
		O32.Ana09ID, T09.AnaName As Ana09Name , O32.Ana10ID, T10.AnaName As Ana10Name, A32.InventoryName AInventoryName, 
		(CASE WHEN ISNULL(O32.InventoryCommonName, '''') = '''' THEN A02.InventoryName ELSE O32.InventoryCommonName END) InventoryName,
		V92.ActualQuantity, V92.EndQuantity RemainQuantity, O32.Finish ,O32.Notes, O32.Notes01, O32.Notes02, 
		O32.Notes03, O32.Notes04, O32.Notes05, O32.Notes06, O32.Notes07, O32.Notes08, O32.Notes09, O32.RefTransactionID,
		O32.ROrderID, O31.ContractNo, O32.ConvertedQuantity, O32.ConvertedSaleprice, O32.ReceiveDate, 
		O32.Parameter01, O32.Parameter02, O32.Parameter03, O32.Parameter04, O32.Parameter05,
		O32.StrParameter01,	O32.StrParameter02,	O32.StrParameter03,	O32.StrParameter04,	O32.StrParameter05,
		O32.StrParameter06,	O32.StrParameter07,	O32.StrParameter08,	O32.StrParameter09,	O32.StrParameter10,
		O32.StrParameter11,	O32.StrParameter12,	O32.StrParameter13,	O32.StrParameter14,	O32.StrParameter15,
		O32.StrParameter16,	O32.StrParameter17,	O32.StrParameter18,	O32.StrParameter19,	O32.StrParameter20,
		O32.nvarchar01, O32.nvarchar02, O32.nvarchar03, O32.nvarchar04, O32.nvarchar05, O32.nvarchar06, O32.nvarchar07, O32.nvarchar08, O32.nvarchar09, O32.nvarchar10,
		O32.nvarchar11, O32.nvarchar12,O32.nvarchar13, O32.nvarchar14, O32.nvarchar15, O32.nvarchar16, O32.nvarchar17, O32.nvarchar18, O32.nvarchar19, O32.nvarchar20,
		O32.InheritTableID, O32.InheritVoucherID, O32.InheritTransactionID, '+ CASE WHEN @IsPriceID = 0 THEN LTRIM(@IsPriceID)+' AS IsPriceID' ELSE 'OV1302.IsPriceID' END + '
		, O32.RequestQuantity, O32.RequestConvertedQuantity,
		O32.Status, O32.ApproveLevel, O32.ApprovingLevel, O32.APKMaster_9000 APKMaster, A32.Specification, A32.RefInventoryID
		, O32.IsProInventoryID
		'+@sSQLSL+' , O32.ReceivedDate, O32.SourceNo,O32.PONumber
		FROM OT3002 O32 WITH (NOLOCK)'
		SET @sSQL1 = '
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON O32.APKMaster_9000 = OOT90.APK
		LEFT JOIN OV2902 V92 ON V92.POrderID = O32.POrderID AND V92.TransactionID = O32.TransactionID
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', O32.DivisionID) AND A32.InventoryID = O32.InventoryID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = O32.WareHouseID
		LEFT JOIN OT1003 O03 WITH (NOLOCK) ON O03.DivisionID = O32.DivisionID AND O03.MethodID = O32.MethodID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = O32.UnitID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O32.DivisionID) AND A02.InventoryID = O32.InventoryID
		LEFT JOIN OT3001 O31 WITH (NOLOCK) ON O31.DivisionID = O32.DivisionID AND O31.POrderID = O32.POrderID
		LEFT JOIN OT3003 O33 WITH (NOLOCK) ON O33.POrderID = O31.POrderID AND O33.DivisionID = O31.DivisionID 
		LEFT JOIN AT1301 A01 WITH (NOLOCK) ON A01.InventoryTypeID = O31.InventoryTypeID
		'+ CASE WHEN @IsPriceID = 0 THEN '' ELSE 'LEFT JOIN #OV1302 OV1302 ON OV1302.DivisionID = O32.DivisionID AND OV1302.InventoryID = O32.InventoryID AND OV1302.UnitID = O32.UnitID' END + '
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = O32.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = O32.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = O32.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = O32.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = O32.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = O32.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = O32.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = O32.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = O32.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = O32.Ana10ID AND T10.AnaTypeID = ''A10''
		'+@sSQLJon+'
	WHERE O32.DivisionID = '''+@DivisionID+''''+@Swhere+'
	Order by O32.Orders'
END

PRINT(@sSQL)
PRINT(@sSQL1)
PRINT(@sSQL2)

EXEC (@sSQL+@sSQL1+@sSQL2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
