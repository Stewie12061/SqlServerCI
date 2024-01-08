IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0158]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0158]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai
---- Date: 04/01/2016
---- Purpose: Load chi tiết đơn hàng mua duyệt cấp 1
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modify on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

---- Example
-- EXEC OP0158 'CTY',''

CREATE PROCEDURE [dbo].[OP0158]   
			@DivisionID nvarchar(50),
			@POrderID nvarchar (50)
 AS
Declare @sSQL1 as nvarchar(4000),
		@sSQL2 as nvarchar(4000),
		@sWhere as nvarchar(500)

SET @sWhere = N'WHERE OT3001.POrderID = '''+@POrderID+'''
				  AND OT3001.DivisionID = '''+@DivisionID+'''
				ORDER BY OT3002.Orders'

Set @sSQL1= N'Select Distinct OT3002.DivisionID,OT3002.POrderID, OT3002.TransactionID, 
		OT3001.VoucherTypeID, OT3001.VoucherNo,OT3001.OrderDate, OT3001.InventoryTypeID, InventoryTypeName, IsStocked,
		OT3002.InventoryID,  OT3002.UnitID, UnitName, 
		OT3002.MethodID, MethodName, OT3002.OrderQuantity, PurchasePrice, ConvertedAmount, OriginalAmount, 
		VATConvertedAmount, VATOriginalAmount, OT3002.VATPercent, DiscountConvertedAmount,  DiscountOriginalAmount,
		DiscountPercent, IsPicking, OT3002.WareHouseID, WareHouseName, 
		Quantity01, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
		Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, 
		Quantity21, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,
		Date01, Date02, Date03, Date04, Date05, Date06, Date07, Date08, Date09, Date10, 
		Date11, Date12, Date13, Date14, Date15, Date16, Date17, Date18, Date19, Date20, 
		Date21, Date22, Date23, Date24, Date25, Date26, Date27, Date28, Date29, Date30, OT3002.Orders, OT3002.Description, 
		OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID,
		AT1302.InventoryName as AInventoryName, 
		case when isnull(OT3002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else OT3002.InventoryCommonName end as 
		InventoryName	, ActualQuantity, EndQuantity as RemainQuantity,
		OT3002.Finish ,OT3002.Notes, OT3002.notes01, OT3002.Notes02, OT3002.RefTransactionID, OT3002.ROrderID, OT3101.ContractNo, 
		OT3002.ConvertedQuantity, OT3002.ImTaxPercent, OT3002.ImTaxOriginalAmount, OT3002.ImTaxConvertedAmount'
		
Set @sSQL2= N'
	From OT3002 WITH (NOLOCK) left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID= OT3002.InventoryID
		left join OT1003 WITH (NOLOCK) on OT1003.MethodID = OT3002.MethodID And OT1003.DivisionID = OT3002.DivisionID
		inner join OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID And OT3001.DivisionID = OT3002.DivisionID
		left join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT3002.WareHouseID
		left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3001.InventoryTypeID
		left join AT1304 WITH (NOLOCK) on AT1304.UnitID = OT3002.UnitID
		left join OT3003 WITH (NOLOCK) on OT3003.POrderID = OT3001.POrderID And OT3003.DivisionId = OT3001.DivisionId
		left join OV2902 on OV2902.POrderID = OT3002.POrderID and OV2902.TransactionID = OT3002.TransactionID And OV2902.DivisionId = OT3002.DivisionId
		lEFT joIN OT3101 WITH (NOLOCK) on OT3101.RorderID = OT3002.RorderID And OT3101.DivisionID = OT3002.DivisionID '

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	Set @sSQL1 = @sSQL1 +  N',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID,
			O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID,
			O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O99.UnitPriceStandard,
			AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
			AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
			AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
			AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name'
		
	Set @sSQL2= N'
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT3002.DivisionID AND O99.VoucherID = OT3002.POrderID AND O99.TransactionID = OT3002.TransactionID and O99.TableID = ''OT3002'' 
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
			'	

END
EXEC (@sSQL1+@sSQL2+@sWhere)
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sWhere
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

