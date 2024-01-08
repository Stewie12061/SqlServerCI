IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tieu Mai
---- Date 01/26/2016
---- Purpose: Hiển thị chi tiết các đơn hàng bán sắp đến ngày giao hàng.
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 10/09/2016: Bổ sung các trường OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP
---- Modified by Tiểu Mai on 16/11/2016: Bổ sung lấy số lượng đã xuất kho cho ANGEL
---- Modify on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

CREATE PROCEDURE [dbo].[OP0022] @DivisionID nvarchar(50),
				@SOrderID NVARCHAR(500)
								
AS
Declare @sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@CustomizeName INT 
	
SELECT @CustomizeName = ci.CustomerName  FROM CustomerIndex ci

	Set @sSQL1= N'
Select OT2002.DivisionID, OT2002.SOrderID, OT2002.TransactionID, 
	OT2001.VoucherTypeID, VoucherNo, OrderDate,  ContractNo, ContractDate, 
	OT2001.InventoryTypeID, InventoryTypeName, IsStocked,
	OT2002.InventoryID,
 Isnull (OT2002.InventoryCommonName,InventoryName) as InventoryName, 
 AT1302.UnitID, UnitName, 
	OT2002.MethodID, MethodName, OT2002.OrderQuantity, SalePrice, ConvertedAmount, OriginalAmount, 
	VATConvertedAmount, VATOriginalAmount, OT2002.VATPercent, DiscountConvertedAmount,  DiscountOriginalAmount,
	DiscountPercent, IsPicking, OT2002.WareHouseID, WareHouseName, 
	Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
	Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
	Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
	Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
	Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
	Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,		
	Date01, Date02, Date03, Date04, Date05, Date06, Date07, Date08, Date09, Date10, 
	Date11, Date12, Date13, Date14, Date15, Date16, Date17, Date18, Date19, Date20, 
	Date21, Date22, Date23, Date24, Date25, Date26, Date27, Date28, Date29, Date30 , ' +
	CASE WHEN @CustomizeName = 57 THEN 'Isnull(G.ActualQuantity,0) as ActualQuantity, OT2002.OrderQuantity - Isnull(G.ActualQuantity,0) as RemainQuantity' ELSE '
	Isnull(ActualQuantity,0) as ActualQuantity, Isnull(EndQuantity,0) as RemainQuantity	' END +', OT2002.ConvertedQuantity,
	OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP' 
	
	Set @sSQL2 =N' 
From OT2002 WITH (NOLOCK) left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
	left join OT1003 WITH (NOLOCK) on OT1003.MethodID = OT2002.MethodID  and OT1003.DivisionID= OT2002.DivisionID
	inner join OT2001 WITH (NOLOCK) on OT2001.SOrderID = OT2002.SOrderID and OT2001.DivisionID= OT2002.DivisionID
	left join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT2001.InventoryTypeID
	left join AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID
	inner join OT2003 WITH (NOLOCK) on OT2003.SOrderID = OT2001.SOrderID and OT2003.DivisionID= OT2002.DivisionID	'
	
	IF @CustomizeName = 57 -------------- ANGEL
BEGIN
	SET @sSQL2 = @sSQL2 + '
	LEFT JOIN (Select DivisionID, OrderID, OTransactionID, isnull(sum(ActualQuantity),0) As ActualQuantity
							From AT3206_AG WITH (NOLOCK)  
							Group by DivisionID, OrderID, OTransactionID) as G  
	on OT2001.DivisionID = G.DivisionID and
							OT2002.SOrderID = G.OrderID and
							OT2002.TransactionID = G.OTransactionID	'
END ------------ ANGEL
ELSE 
	SET @sSQL2 = @sSQL2 + '
	left join OV2901 on OV2901.SOrderID = OT2002.SOrderID and OV2901.TransactionID = OT2002.TransactionID and OV2901.DivisionID= OT2002.DivisionID	'

IF exists (SELECT TOP 1 1 from AT0000 WITH (NOLOCK) where DefDivisionID = @DivisionID  and IsSpecificate = 1)
begin
	Set @sSQL1= @sSQL1 + N',
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID,
	O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID,
	O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O99.UnitPriceStandard,
	AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
	AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
	AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
	AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name
	'
	
	Set @sSQL2 = @sSQL2 + N' 
	LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.TransactionID = OT2002.TransactionID
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
end

SET @sSQL2 = @sSQL2 + '
Where  OT2001.DivisionID = ''' + @DivisionID + ''' 
	AND OT2001.SOrderID = '''+@SOrderID+''' '

PRINT @sSQL1
PRINT @sSQL2

EXEC (@sSQL1+@sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
