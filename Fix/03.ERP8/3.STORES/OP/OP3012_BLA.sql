IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012_BLA]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012_BLA]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In thông tin kế hoạch sản xuất cho khách hàng Bê tông Long An (CustomizeIndex = 80)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 28/08/2017
---- Modified by ... on ...
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/*
exec OP3012_BLA @Divisionid=N'PC',@Sorderid=N'TH/2016/08/0022'

*/
CREATE PROCEDURE [dbo].[OP3012_BLA] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
@sSQL2 AS NVARCHAR(MAX), 
@sSQL3 NVARCHAR(MAX), 
@sSelect NVARCHAR(MAX) = '', 
@sSQLFrom NVARCHAR(MAX),
@Dot INT,
@DotNay NVARCHAR(50),
@DotTruoc NVARCHAR(50)

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
SET @sSQL3 = ''
Set @sSQLFrom = ''
		 
Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	

SELECT @DotNay = MAX(Ana06ID) FROM OT2002 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @SOrderID

SELECT @Dot = RIGHT(@DotNay,2)

IF @Dot > 1 AND @Dot <= 2
	SET @DotTruoc = N'ĐẠI TRÀ Đợt 1'
ELSE IF @Dot > 2
	SET @DotTruoc = N'ĐẠI TRÀ Đợt 1-' + CONVERT(NVARCHAR(5),@Dot-1) 
ELSE
	SET @DotTruoc = 'NULL'

SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress, AT1202.Contactor,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, 
			SUM(CASE WHEN OT2002.Ana06ID <> ''COCTHU'' then (case when (OT2002.Ana06ID < '''+@DotNay+''') then OT2002.OrderQuantity ELSE 0 END) ELSE OT2002.OrderQuantity END ) AS OrderQuantity_DT14, 
			SUM(CASE WHEN OT2002.Ana06ID <> ''COCTHU'' then (case when (OT2002.Ana06ID = '''+@DotNay+''') then OT2002.OrderQuantity ELSE 0 END) ELSE OT2002.OrderQuantity END ) AS OrderQuantity_DT5, 
			OT2001.DepartmentID, 
			isnull(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, OT2002.EndDate, OT2002.RefInfor, OT2001.Notes	,
			Inherit_OT2001.Notes AS InheritNotes, Inherit_OT2001.DeliveryAddress, InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			OT2002.Ana06ID, OT2002.Ana07ID, OT2002.Ana08ID, OT2002.Ana10ID, 
			OT1002_1.AnaName AS AnaName1,
			OT1002_2.AnaName AS AnaName2,
			OT1002_3.AnaName AS AnaName3,
			OT1002_4.AnaName AS AnaName4,
			OT1002_5.AnaName AS AnaName5,
			OT1002_6.AnaName AS AnaName6,
			OT1002_7.AnaName AS AnaName7,
			OT1002_8.AnaName AS AnaName8,
			OT1002_10.AnaName AS AnaName10,
			OT2002.nvarchar01,	OT2002.nvarchar02,	OT2002.nvarchar03,	OT2002.nvarchar04,	OT2002.nvarchar05,	
			OT2002.nvarchar06,	OT2002.nvarchar07,	OT2002.nvarchar08,	OT2002.nvarchar09,	OT2002.nvarchar10,
			OT2001.InheritSOrderID,
			AT1202.Contactor AS ObjectContactor,
			AT1103_2.FullName as SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			OT2001.Varchar01,OT2001.Varchar02,OT2001.Varchar03,OT2001.Varchar04,OT2001.Varchar05,
			OT2001.Varchar06,OT2001.Varchar07,OT2001.Varchar08,OT2001.Varchar09,OT2001.Varchar10,
			OT2001.Varchar11,OT2001.Varchar12,OT2001.Varchar13,OT2001.Varchar14,OT2001.Varchar15,
			OT2001.Varchar16,OT2001.Varchar17,OT2001.Varchar18,OT2001.Varchar19,OT2001.Varchar20,
			OT2002.Description, Inherit_OT2002.Ana01ID AS PO, Inherit_OT2002.SalePrice,
			Inherit_OT2002.InheritTableID, Inherit_OT2002.InheritVoucherID, Inherit_OT2002.InheritTransactionID,
			AT1020.ContractNo, OT2001.ShipDate, AT1302.I02ID, AT02.AnaName as I02Name,
			'''+@DotNay+''' AS DT_MaxID, N''' +N'ĐẠI TRÀ ' + ''' + AT11.AnaName as DT_DotNay,
			N'''+@DotTruoc+''' AS DT_DotTruoc'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.InheritSOrderID = OT2002.SOrderID AND Inherit_OT2001.DivisionID = OT2002.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 
	LEFT JOIN AT1020 WITH (NOLOCK) ON AT1020.DivisionID = Inherit_OT2002.DivisionID AND AT1020.ContractID = Inherit_OT2002.InheritVoucherID		
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 OT1002_6 WITH (NOLOCK) ON OT1002_6.AnaID = OT2002.Ana06ID AND  OT1002_6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 OT1002_7 WITH (NOLOCK) ON OT1002_7.AnaID = OT2002.Ana07ID AND  OT1002_7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 OT1002_8 WITH (NOLOCK) ON OT1002_8.AnaID = OT2002.Ana08ID AND  OT1002_8.AnaTypeID = ''A08''
	LEFT JOIN AT1011 OT1002_9 WITH (NOLOCK) ON OT1002_9.AnaID = OT2002.Ana09ID AND  OT1002_9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 OT1002_10 WITH (NOLOCK) ON OT1002_10.AnaID = OT2002.Ana10ID AND  OT1002_10.AnaTypeID = ''A10''
	LEFT JOIN AT1015 AT02 WITH (NOLOCK) ON AT02.AnaID = AT1302.I02ID AND  AT02.AnaTypeID = ''I02''
	LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = '''+@DotNay+''' AND  AT11.AnaTypeID = ''A06''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS S18Name, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
	
	SET @sSQL2 = ' LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.VoucherID = OT2002.SOrderID AND O99.TransactionID  = OT2002.TransactionID and O99.TableID  = ''OT2002''
			LEFT JOIN AT0128 A01 WITH (NOLOCK) ON A01.StandardID = O99.S01ID AND A01.StandardTypeID = ''S01''
			LEFT JOIN AT0128 A02 WITH (NOLOCK) ON A02.StandardID = O99.S02ID AND A02.StandardTypeID = ''S02''
			LEFT JOIN AT0128 A03 WITH (NOLOCK) ON A03.StandardID = O99.S03ID AND A03.StandardTypeID = ''S03''
			LEFT JOIN AT0128 A04 WITH (NOLOCK) ON A04.StandardID = O99.S04ID AND A04.StandardTypeID = ''S04''
			LEFT JOIN AT0128 A05 WITH (NOLOCK) ON A05.StandardID = O99.S05ID AND A05.StandardTypeID = ''S05''
			LEFT JOIN AT0128 A06 WITH (NOLOCK) ON A06.StandardID = O99.S06ID AND A06.StandardTypeID = ''S06''
			LEFT JOIN AT0128 A07 WITH (NOLOCK) ON A07.StandardID = O99.S07ID AND A07.StandardTypeID = ''S07''
			LEFT JOIN AT0128 A08 WITH (NOLOCK) ON A08.StandardID = O99.S08ID AND A08.StandardTypeID = ''S08''
			LEFT JOIN AT0128 A09 WITH (NOLOCK) ON A09.StandardID = O99.S09ID AND A09.StandardTypeID = ''S09''
			LEFT JOIN AT0128 A10 WITH (NOLOCK) ON A10.StandardID = O99.S10ID AND A10.StandardTypeID = ''S10''
			LEFT JOIN AT0128 A11 WITH (NOLOCK) ON A11.StandardID = O99.S11ID AND A11.StandardTypeID = ''S11''
			LEFT JOIN AT0128 A12 WITH (NOLOCK) ON A12.StandardID = O99.S12ID AND A12.StandardTypeID = ''S12''
			LEFT JOIN AT0128 A13 WITH (NOLOCK) ON A13.StandardID = O99.S13ID AND A13.StandardTypeID = ''S13''
			LEFT JOIN AT0128 A14 WITH (NOLOCK) ON A14.StandardID = O99.S14ID AND A14.StandardTypeID = ''S14''
			LEFT JOIN AT0128 A15 WITH (NOLOCK) ON A15.StandardID = O99.S15ID AND A15.StandardTypeID = ''S15''
			LEFT JOIN AT0128 A16 WITH (NOLOCK) ON A16.StandardID = O99.S16ID AND A16.StandardTypeID = ''S16''
			LEFT JOIN AT0128 A17 WITH (NOLOCK) ON A17.StandardID = O99.S17ID AND A17.StandardTypeID = ''S17''
			LEFT JOIN AT0128 A18 WITH (NOLOCK) ON A18.StandardID = O99.S18ID AND A18.StandardTypeID = ''S18''
			LEFT JOIN AT0128 A19 WITH (NOLOCK) ON A19.StandardID = O99.S19ID AND A19.StandardTypeID = ''S19''
			LEFT JOIN AT0128 A20 WITH (NOLOCK) ON A20.StandardID = O99.S20ID AND A20.StandardTypeID = ''S20'''
	
	
	SET @sSQL3 = @sSQL3 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + '''
	GROUP BY OT2002.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, OT2001.ObjectName, AT1202.ObjectName, OT2001.ObjectName, AT1202.Contactor,
			OT2001.Address, AT1202.Address, OT2001.Address, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2001.DepartmentID, 
			AT1102.DepartmentName, OT2002.LinkNo, OT2002.EndDate, OT2002.RefInfor, OT2001.Notes	,
			Inherit_OT2001.Notes, Inherit_OT2001.DeliveryAddress, InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			OT2002.Ana06ID, OT2002.Ana07ID, OT2002.Ana08ID, OT2002.Ana10ID, 
			OT1002_1.AnaName,
			OT1002_2.AnaName,
			OT1002_3.AnaName,
			OT1002_4.AnaName,
			OT1002_5.AnaName,
			OT1002_6.AnaName,
			OT1002_7.AnaName,
			OT1002_8.AnaName,
			OT1002_10.AnaName,
			OT2002.nvarchar01,	OT2002.nvarchar02,	OT2002.nvarchar03,	OT2002.nvarchar04,	OT2002.nvarchar05,	
			OT2002.nvarchar06,	OT2002.nvarchar07,	OT2002.nvarchar08,	OT2002.nvarchar09,	OT2002.nvarchar10,
			OT2001.InheritSOrderID,
			AT1202.Contactor,
			AT1103_2.FullName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			OT2001.Varchar01,OT2001.Varchar02,OT2001.Varchar03,OT2001.Varchar04,OT2001.Varchar05,
			OT2001.Varchar06,OT2001.Varchar07,OT2001.Varchar08,OT2001.Varchar09,OT2001.Varchar10,
			OT2001.Varchar11,OT2001.Varchar12,OT2001.Varchar13,OT2001.Varchar14,OT2001.Varchar15,
			OT2001.Varchar16,OT2001.Varchar17,OT2001.Varchar18,OT2001.Varchar19,OT2001.Varchar20,
			OT2002.Description, Inherit_OT2002.Ana01ID, Inherit_OT2002.SalePrice,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, A05.StandardName,
			A06.StandardName, A07.StandardName, A08.StandardName, A09.StandardName, A10.StandardName,
			A11.StandardName, A12.StandardName, A13.StandardName, A14.StandardName, A15.StandardName,
			A16.StandardName, A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName,
			Inherit_OT2002.InheritTableID, Inherit_OT2002.InheritVoucherID, Inherit_OT2002.InheritTransactionID,
			AT1020.ContractNo, OT2001.ShipDate, AT1302.I02ID, AT02.AnaName, AT11.AnaName
	'
END
ELSE
BEGIN
	SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + '''
	GROUP BY OT2002.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, OT2001.ObjectName, AT1202.ObjectName, OT2001.ObjectName, AT1202.Contactor,
			OT2001.Address, AT1202.Address, OT2001.Address, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2001.DepartmentID, 
			AT1102.DepartmentName, OT2002.LinkNo, OT2002.EndDate, OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			OT2002.Ana06ID, OT2002.Ana07ID, OT2002.Ana08ID, OT2002.Ana09ID, OT2002.Ana10ID, 
			OT1002_1.AnaName,
			OT1002_2.AnaName,
			OT1002_3.AnaName,
			OT1002_4.AnaName,
			OT1002_5.AnaName,
			OT1002_6.AnaName,
			OT1002_7.AnaName,
			OT1002_8.AnaName,
			OT1002_9.AnaName,
			OT1002_10.AnaName,
			OT2002.nvarchar01,	OT2002.nvarchar02,	OT2002.nvarchar03,	OT2002.nvarchar04,	OT2002.nvarchar05,	
			OT2002.nvarchar06,	OT2002.nvarchar07,	OT2002.nvarchar08,	OT2002.nvarchar09,	OT2002.nvarchar10,
			OT2001.InheritSOrderID,
			AT1202.Contactor,
			AT1103_2.FullName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			OT2001.Varchar01,OT2001.Varchar02,OT2001.Varchar03,OT2001.Varchar04,OT2001.Varchar05,
			OT2001.Varchar06,OT2001.Varchar07,OT2001.Varchar08,OT2001.Varchar09,OT2001.Varchar10,
			OT2001.Varchar11,OT2001.Varchar12,OT2001.Varchar13,OT2001.Varchar14,OT2001.Varchar15,
			OT2001.Varchar16,OT2001.Varchar17,OT2001.Varchar18,OT2001.Varchar19,OT2001.Varchar20,
			OT2002.Description, Inherit_OT2002.Ana01ID, Inherit_OT2002.SalePrice, 
			Inherit_OT2002.InheritTableID, Inherit_OT2002.InheritVoucherID, Inherit_OT2002.InheritTransactionID,
			AT1020.ContractNo, OT2001.ShipDate, AT1302.I02ID, AT02.AnaName, AT11.AnaName'
END			

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

EXEC (@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
