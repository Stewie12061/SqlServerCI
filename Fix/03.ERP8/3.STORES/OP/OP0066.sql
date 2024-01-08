IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0066]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0066]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Detail màn hình nghiep vu Xac nhan hoan thanh cua khach hang BOURBON
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 29/09/2014 by Le Thi Thu Hien
---- 
---- Modified by Tiểu Mai on 14/09/2017: Bổ sung ghi nhận dòng đã kế thừa qua chấm công sản phẩm
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đức Duy on 10/04/2023: [2023/04/IS/0048] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng AT1011.
---- Modified by Đình Định on 20/09/2023:BBL - Bổ sung cột WareHouseFee.
---- Modified by Xuân Nguyên on 02/01/2024:[2023/12/IS/0200]BBL - Bổ sung cột OrderID.
-- <Example>
---- 
CREATE PROCEDURE OP0066
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@TranMonth AS TINYINT,
	@TranYear AS INT,
	@VoucherID AS NVARCHAR(50)
) 
AS
DECLARE @CustomerName INT,
		@WareHouseFee VARCHAR(50),
		@sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

SELECT @CustomerName = CustomerName FROM CustomerIndex WITH(NOLOCK)

IF @CustomerName = 38
	BEGIN
		SET @WareHouseFee = ' OT3002.WareHouseFee AS WareHouseFee, OT3002.OrderID AS OrderID  '  
	END
ELSE
	BEGIN 
		SET @WareHouseFee = ' '''' AS WareHouseFee ' 
	END

SET @sSQL= N' 
SELECT	OT3002.DivisionID, OT3002.POrderID, OT3002.TransactionID, 
		OT3001.VoucherTypeID, OT3001.VoucherNo,OT3001.OrderDate, OT3001.InventoryTypeID, InventoryTypeName, AT1302.IsStocked,
        AT1302.Barcode, 
		OT3002.InventoryID,  OT3002.UnitID, UnitName, 
		OT3002.MethodID, MethodName, OT3002.OrderQuantity, OT3002.PurchasePrice, 
		ConvertedAmount, OriginalAmount, 
		VATConvertedAmount, VATOriginalAmount, OT3002.VATPercent, 
		DiscountConvertedAmount,  DiscountOriginalAmount,DiscountPercent, 
		OriginalAmount - DiscountOriginalAmount AS OriginalAmountBeforeVAT,
		OT3002.ImTaxPercent, OT3002.ImTaxOriginalAmount, OT3002.ImTaxConvertedAmount,
		OriginalAmount - DiscountOriginalAmount + OT3002.VATOriginalAmount +  OT3002.ImTaxOriginalAmount AS OriginalAmountAfterVAT,
		IsPicking, OT3002.WareHouseID, WareHouseName, 
		Quantity01, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
		Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, 
		Quantity21, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,
		Date01, Date02, Date03, Date04, Date05, Date06, Date07, Date08, Date09, Date10, 
		Date11, Date12, Date13, Date14, Date15, Date16, Date17, Date18, Date19, Date20, 
		Date21, Date22, Date23, Date24, Date25, Date26, Date27, Date28, Date29, Date30, OT3002.Orders, OT3002.Description, 
		OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID,
		OT3002.Ana06ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID,
		Ana01.AnaName AS Ana01Name,		Ana02.AnaName AS Ana02Name,
		Ana03.AnaName AS Ana03Name,		Ana04.AnaName AS Ana04Name,
		Ana05.AnaName AS Ana05Name,		Ana06.AnaName AS Ana06Name,
		Ana07.AnaName AS Ana07Name,		Ana08.AnaName AS Ana08Name,
		Ana09.AnaName AS Ana09Name,		Ana10.AnaName AS Ana10Name,
		AT1302.InventoryName, ActualQuantity, EndQuantity AS RemainQuantity,
		OT3002.Finish ,OT3002.Notes, OT3002.Notes01, OT3002.Notes02, 
		OT3002.Notes04, AT02.InventoryName AS ReInventoryName,	OT3002.Notes05,	OT3002.Notes06,
		OT3002.Notes07,	OT3002.Notes08,	OT3002.Notes09,		
		OT3002.RefTransactionID, OT3002.ROrderID, OT3101.ContractNo, 
		OT3002.ConvertedQuantity, OT3002.ConvertedSaleprice,
		OT3002.ShipDate, OT3002.ReceiveDate, 
		OT3002.Parameter01, OT3002.Parameter02, OT3002.Parameter03, OT3002.Parameter04, OT3002.Parameter05,
		OT3002.StrParameter01,	OT3002.StrParameter02,	OT3002.StrParameter03,	OT3002.StrParameter04,	OT3002.StrParameter05,
		OT3002.StrParameter06,	OT3002.StrParameter07,	OT3002.StrParameter08,	OT3002.StrParameter09,	OT3002.StrParameter10,
		OT3002.StrParameter11,	OT3002.StrParameter12,	OT3002.StrParameter13,	OT3002.StrParameter14,	OT3002.StrParameter15,
		OT3002.StrParameter16,	OT3002.StrParameter17,	OT3002.StrParameter18,	OT3002.StrParameter19,	OT3002.StrParameter20,
		CASE WHEN ISNULL(OT3002.Notes01,'''') <> '''' THEN OT31.ObjectName ELSE '''' END AInventoryName,
		CASE WHEN ISNULL(OT3002.Notes01,'''') <> '''' THEN OT31.ObjectID ELSE '''' END Notes03,
		CASE WHEN ISNULL(H10.InheritPTransactionID,'''') <> '''' THEN 1 ELSE 0 END AS IsInherit, 
		'+@WareHouseFee+'
FROM OT3002 WITH (NOLOCK) '

SET @sSQL1 = N'
LEFT JOIN AT1011 Ana01 WITH (NOLOCK) ON Ana01.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana01ID = Ana01.AnaID AND Ana01.AnaTypeID = ''A01''
LEFT JOIN AT1011 Ana02 WITH (NOLOCK) ON Ana02.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana02ID = Ana02.AnaID AND Ana02.AnaTypeID = ''A02''
LEFT JOIN AT1011 Ana03 WITH (NOLOCK) ON Ana03.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana03ID = Ana03.AnaID AND Ana03.AnaTypeID = ''A03''
LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON Ana04.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = ''A04''
LEFT JOIN AT1011 Ana05 WITH (NOLOCK) ON Ana05.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana05ID = Ana05.AnaID AND Ana05.AnaTypeID = ''A05''
LEFT JOIN AT1011 Ana06 WITH (NOLOCK) ON Ana06.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana06ID = Ana06.AnaID AND Ana06.AnaTypeID = ''A06''
LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON Ana07.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = ''A07''
LEFT JOIN AT1011 Ana08 WITH (NOLOCK) ON Ana08.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = ''A08''
LEFT JOIN AT1011 Ana09 WITH (NOLOCK) ON Ana09.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana09ID = Ana09.AnaID AND Ana09.AnaTypeID = ''A09''
LEFT JOIN AT1011 Ana10 WITH (NOLOCK) ON Ana10.DivisionID IN (''@@@'', OT3002.DivisionID) AND OT3002.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = ''A10''
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID= OT3002.InventoryID
LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON  AT02.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT02.InventoryID= OT3002.Notes04
LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT3002.MethodID  AND OT1003.DivisionID = OT3002.DivisionID 
INNER JOIN OT3001 WITH (NOLOCK) ON OT3001.POrderID = OT3002.POrderID AND OT3001.DivisionID = OT3002.DivisionID
LEFT JOIN OT3001 OT31 WITH (NOLOCK) ON OT31.POrderID = OT3002.Notes01 AND OT31.DivisionID = OT3002.DivisionID  
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT3002.WareHouseID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT3001.InventoryTypeID 	 AND AT1301.DivisionID = OT3001.DivisionID 
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID =OT3002.UnitID AND AT1304.DivisionID = OT3002.DivisionID 
LEFT JOIN OT3003 WITH (NOLOCK) ON OT3003.POrderID = OT3001.POrderID AND OT3003.DivisionID = OT3001.DivisionID 
LEFT JOIN OV2902 ON OV2902.POrderID = OT3002.POrderID AND OV2902.TransactionID = OT3002.TransactionID
LEFT JOIN OT3101 WITH (NOLOCK) ON OT3101.RorderID = OT3002.RorderID   AND OT3101.DivisionID = OT3002.DivisionID 
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1202.ObjectID = OT3002.Notes03
LEFT JOIN HT0410 H10 WITH (NOLOCK) ON OT3002.DivisionID = H10.DivisionID AND OT3002.TransactionID = H10.InheritPTransactionID
WHERE OT3002.DivisionID = '''+@DivisionID+'''
AND OT3002.POrderID = '''+@VoucherID+'''
Order by OT3002.ReceiveDate, OT3001.POrderID, OT3001.VoucherNo, OT3002.InventoryID'

EXEC(@sSQL + @sSQL1)

PRINT @sSQL
PRINT @sSQL1


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
