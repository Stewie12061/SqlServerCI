IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0017_SC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0017_SC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--- Created by Hoàng Vũ	Date: 05/10/2016
--- Store OP0017_SC thay thế Store OP0011 (lấy view tự sinh ra OV0012) (Customize Secoin index = 43 )
--- Purpose: Load detail kế thừa đơn bán (Màn hình kế thừa đơn hàng) khi lập đơn hàng điều chỉnh
--- EXEC OP0017_SC 'SC', '2016-08-30 00:00:00.000','BD_SO/16/07/008', 'DHSX_BD_01_2014_0044', 'NV003'
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[OP0017_SC] 
(
	@DivisionID nvarchar(50),
	@OrderDate DATETIME,		-- Là ngày của đơn hàng đang mở/đang sửa
	@SOrderID nvarchar(50),		-- Là ID truyền trên master xuống Detail của màn hình kế thừa đơn hàng 
	@PVoucherID nvarchar(50),	-- Là ID của phiếu đang mở lên sửa, trường hợp thêm thì truyền ''
	@UserID nvarchar(50)
)
AS
Declare @sSQL01 AS varchar(max),
		@sSQL02 AS varchar(max),
		@sSQL03 AS varchar(max),
		@sWHERE AS VARCHAR(MAX)

		----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		
		-- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
		IF EXISTS (SELECT TOP 1 1 FROM OT0001 WHERE DivisionID = @DivisionID AND IsPermissionView = 1) 
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = OT2001.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = OT2001.CreateUserID '
				SET @sWHEREPer = ' AND (OT2001.CreateUserID = AT0010.UserID
										OR  OT2001.CreateUserID = '''+@UserID+''') '		
			END

		-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = 'SC' AND IsSpecificate = 1)
BEGIN
	SET @sSQL01= ' Select x.* from
				(
				SELECT DISTINCT	OT2002.DivisionID,OT2002.SOrderID,OT2002.RefSTransactionID,OT2002.TransactionID,OT2001.VoucherTypeID, 
				VoucherNo, OrderDate, ContractNo,ContractDate,OT2001.InventoryTypeID,InventoryTypeName,IsStocked,OT2002.InventoryID, 
				AT1302.InventoryName AS AInventoryName, case when ISNULL(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName 
				else OT2002.InventoryCommonName end AS InventoryName, OT2002.ExtraID,AT1311.ExtraName,AT1302.Barcode,ISNULL(OT2002.UnitID,AT1302.UnitID) 
				AS  UnitID,
				ISNULL(T04.UnitName,AT1304.UnitName) AS  UnitName,OT2002.OrderQuantity,CAST(0 AS BIT) IsSelected,
				OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,SalePrice,OT2002.ConvertedAmount, 
				OT2002.OriginalAmount, OT2002.VATConvertedAmount,OT2002.VATOriginalAmount,OT2002.VATPercent,		OT2002.DiscountConvertedAmount, 
				OT2002.DiscountOriginalAmount,OT2002.DiscountPercent,OT2002.CommissionPercent,OT2002.CommissionCAmount,OT2002.CommissionOAmount, 
				(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
				AS OriginalAmountBeforeVAT,
				(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) 
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
				AS ConvertAmountBeforeVAT,
				(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
				- OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
				(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - (OT2002.SaleOffAmount01 
				+ OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity 
				- OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
				IsPicking,OT2002.WareHouseID,WareHouseName,OT2002.AdjustQuantity, 
				Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,Quantity11, 
				Quantity12, Quantity13, Quantity14, Quantity15,Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,Quantity21, Quantity22, 
				Quantity23, Quantity24, Quantity25,Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,	OT2003.Date01, OT2003.Date02, 
				OT2003.Date03, OT2003.Date04, OT2003.Date05,OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10, Date11, 
				Date12, Date13, Date14, Date15, Date16,	Date17, Date18, Date19, Date20,Date21, Date22, Date23, Date24, Date25,Date26, Date27, 
				Date28, Date29, Date30,OT2002.LinkNo,OT2002.EndDate,OT2002.Orders,OT2002.Description,OT2002.RefInfor,OT2002.Ana01ID,OT2002.Ana02ID, 
				OT2002.Ana03ID,OT2002.Ana04ID,OT2002.Ana05ID,OT2002.Ana06ID,OT2002.Ana07ID,OT2002.Ana08ID,OT2002.Ana09ID,OT2002.Ana10ID,ActualQuantity,
				EndQuantity AS RemainQuantity, OT2002.Finish, OT2002.SOrderIDRecognition,OT2002.Notes, OT2002.Notes01,OT2002.Notes02,OT2001.contact,
				OT2002.QuotationID,OT2002.VATGroupID,OT2002.SaleOffPercent01,OT2002.SaleOffAmount01,OT2002.SaleOffPercent02, 
				OT2002.SaleOffAmount02,OT2002.SaleOffPercent03,OT2002.SaleOffAmount03, '
	SET @sSQL02= ' OT2002.SaleOffPercent04,OT2002.SaleOffAmount04,OT2002.SaleOffPercent05,OT2002.SaleOffAmount05,OT2002.QuoTransactionID, 
				OT2002.Pricelist,OT2002.Varchar01, OT2002.Varchar02,OT2002.Varchar03,OT2002.Varchar04,OT2002.Varchar05,OT2002.Varchar06, 
				OT2002.Varchar07,OT2002.Varchar08,OT2002.Varchar09,OT2002.Varchar10, OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, 
				OT2002.nvarchar04, OT2002.nvarchar05,OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, 
				OT2002.nvarchar10,OT2002.ConvertedQuantity, OT2002.SOKitTransactionID,OT2002.ConvertedSaleprice,OT2001.ObjectID, 
				(SELECT OrderQuantity FROM OT2002 T02 Where T02.TransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID)
				- (ISNULL((SELECT Sum(OrderQuantity) FROM OT2002 T02 Where T02.RefSTransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID),0))
				AS RemainOrderQuantity,OT2002.Markup,
				ISNULL(OT2002.OriginalAmountOutput, OT2002.OriginalAmount*(1+ISNULL(Markup,0)/100)) AS OriginalAmountOutput,
				OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) AS ConvertedAmountOutput,
				OT2002.DeliveryDate,OT2002.ConvertedSalepriceInput,OT2002.ShipDate, OT2001.ShipDate as ShipDateMaster,OT2002.Allowance, 
				OT2002.InheritTableID, OT2002.InheritVoucherID,
				OT2002.InheritTransactionID,O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID,O99.S08ID, O99.S09ID, 
				O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID,O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O99.UnitPriceStandard,
				AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
				AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
				AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
				AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name, 
				OT2002.Ana02ID as Ana02IDAP
				FROM OT2002  WITH (NOLOCK)
				LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.TransactionID = OT2002.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
				LEFT JOIN AT1311 WITH (NOLOCK) on OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
				INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2002.DivisionID = OT2001.DivisionID	
				LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID'
	SET @sSQL03= ' LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
				LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID	
				LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
				LEFT JOIN AT1304  T04 WITH (NOLOCK) ON T04.UnitID = OT2002.UnitID
				LEFT JOIN OT2003 WITH (NOLOCK) ON OT2003.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2003.DivisionID	
				LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID	
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
				' + @sSQLPer+ '
				WHERE (1=1) '+ @sWHEREPer+
				') x 
				Where x.SOrderID IN ('''+@SOrderID+''')
				AND 
				(Case when ''' +CONVERT(VARCHAR(10),@OrderDate,112)+ '''< CONVERT(VARCHAR(10),x.ShipDateMaster,112)  then x.RemainOrderQuantity ELSE 0 end) > 0
				Order by x.Orders'
			
END
ELSE
BEGIN
	SET @sSQL01= ' Select x.* from
				( SELECT DISTINCT	OT2002.DivisionID,OT2002.SOrderID,OT2002.RefSTransactionID,OT2002.TransactionID,OT2001.VoucherTypeID,
				VoucherNo, OrderDate, ContractNo,ContractDate,OT2001.InventoryTypeID,InventoryTypeName,IsStocked,OT2002.InventoryID,
				AT1302.InventoryName AS AInventoryName, case when ISNULL(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else 
				OT2002.InventoryCommonName end AS InventoryName, 	OT2002.ExtraID,AT1311.ExtraName,AT1302.Barcode,
				ISNULL(OT2002.UnitID,AT1302.UnitID) AS  UnitID, ISNULL(T04.UnitName,AT1304.UnitName) AS  UnitName,OT2002.OrderQuantity, 
				CAST(0 AS BIT) IsSelected,OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
				SalePrice, OT2002.ConvertedAmount,OT2002.OriginalAmount,OT2002.VATConvertedAmount,OT2002.VATOriginalAmount,
				OT2002.VATPercent, 		OT2002.DiscountConvertedAmount, OT2002.DiscountOriginalAmount,OT2002.DiscountPercent,OT2002.CommissionPercent,
				OT2002.CommissionCAmount, OT2002.CommissionOAmount,(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
				AS OriginalAmountBeforeVAT, (Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) 
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))AS ConvertAmountBeforeVAT,
				(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0)
				- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) 
				+ ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))
				- OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT, (OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) 
				- OT2002.DiscountConvertedAmount - (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 
				+ OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT, '
	SET @sSQL02 = ' IsPicking, OT2002.WareHouseID,WareHouseName, OT2002.AdjustQuantity,Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
				Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
				Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
				Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,OT2003.Date01, OT2003.Date02, OT2003.Date03, OT2003.Date04, OT2003.Date05,
				OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10,Date11, Date12, Date13, Date14, Date15,
				Date16, Date17, Date18, Date19, Date20, Date21, Date22, Date23, Date24, Date25,Date26, Date27, Date28, Date29, Date30,OT2002.LinkNo,
				OT2002.EndDate, OT2002.Orders,OT2002.Description,OT2002.RefInfor,OT2002.Ana01ID,OT2002.Ana02ID,OT2002.Ana03ID,OT2002.Ana04ID,
				OT2002.Ana05ID,OT2002.Ana06ID,OT2002.Ana07ID,OT2002.Ana08ID,OT2002.Ana09ID,OT2002.Ana10ID,ActualQuantity,	EndQuantity AS RemainQuantity,
				OT2002.Finish ,OT2002.SOrderIDRecognition,OT2002.Notes,OT2002.Notes01,OT2002.Notes02,OT2001.contact,OT2002.QuotationID,OT2002.VATGroupID,
				OT2002.SaleOffPercent01,OT2002.SaleOffAmount01,OT2002.SaleOffPercent02,OT2002.SaleOffAmount02,OT2002.SaleOffPercent03,OT2002.SaleOffAmount03,
				OT2002.SaleOffPercent04,OT2002.SaleOffAmount04,OT2002.SaleOffPercent05, 
				OT2002.SaleOffAmount05,OT2002.QuoTransactionID,OT2002.Pricelist,OT2002.Varchar01,
				OT2002.Varchar02,OT2002.Varchar03,OT2002.Varchar04,OT2002.Varchar05,OT2002.Varchar06,OT2002.Varchar07,
				OT2002.Varchar08,OT2002.Varchar09,OT2002.Varchar10,
				OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05,OT2002.nvarchar06, OT2002.nvarchar07, 
				OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,OT2002.ConvertedQuantity, 
				OT2002.SOKitTransactionID,OT2002.ConvertedSaleprice,OT2001.ObjectID, '
	SET @sSQL03= ' (SELECT OrderQuantity FROM OT2002 T02 Where T02.TransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID)
				- (ISNULL((SELECT Sum(OrderQuantity) FROM OT2002 T02 Where T02.RefSTransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID),0))
				AS RemainOrderQuantity,OT2002.Markup,ISNULL(OT2002.OriginalAmountOutput, OT2002.OriginalAmount*(1+ISNULL(Markup,0)/100)) AS OriginalAmountOutput,
				OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) AS ConvertedAmountOutput,OT2002.DeliveryDate,
				OT2002.ConvertedSalepriceInput,OT2002.ShipDate, OT2001.ShipDate as ShipDateMaster,OT2002.Allowance,OT2002.InheritTableID,OT2002.InheritVoucherID,
				OT2002.InheritTransactionID, OT2002.Ana02ID as Ana02IDAP
				FROM OT2002  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
				LEFT JOIN AT1311 WITH (NOLOCK) on OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
				INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2002.DivisionID = OT2001.DivisionID	
				LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
				LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID 
				LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID	
				LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
				LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = OT2002.UnitID
				LEFT JOIN OT2003 WITH (NOLOCK) ON OT2003.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2003.DivisionID	
				LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID
				' + @sSQLPer+ '
				WHERE (1=1) '+ @sWHEREPer+
				') x 
				Where x.SOrderID IN ('''+@SOrderID+''')
				AND 
				(Case when ''' +CONVERT(VARCHAR(10),@OrderDate,112)+ '''< CONVERT(VARCHAR(10),x.ShipDateMaster,112) then x.RemainOrderQuantity ELSE -1 end) >= 0
				Order by x.Orders'
End				
			 EXEC (@sSQL01 + @sSQL02 + @sSQL03)	
			 --PRINT @sSQL01 
			 --PRINT @sSQL02
			 --Print @sSQL03


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
