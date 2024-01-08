IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In don hang san xuat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/09/2004 by Vo Thanh Huong
---- 
---- Last Edit Thuy Tuyen, date 03/10/2009
---- Edit Thuy Tuyen, date 20/11/2009  them cac truong ma phan tich nghiep vu.
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung them 1 so truong
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung Phonenumber, ObjectName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung 20 tham so varchar01->varchar20
---- Modified on 19/11/2011 by Le Thi Thu Hien : Chuoi dai hon 4000 ky tu
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bổ sung Decription
---- Modified on 25/12/2015 Tieu by Mai: Bo sung thong tin quy cach khi co thiet lap quan ly hang theo quy cach
---- Modified by Tiểu Mai on 05/01/2016: Lấy thông tin bộ định mức đính kèm đơn hàng sản xuất
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát (CustomizeIndex = 54)
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng Vũ on 14/07/2016: Customize secoin, Load thêm hình và code màu mã phân tích mặt hàng
---- Modified by Hoàng Vũ on 10/08/2016: Customize secoin, Xử lý đơn vị tính quy đổi (Vien, Hop, met và pallet)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường PO, SalePrice được lấy từ chi tiết đơn hàng bán (HHP)
---- Modify on 27/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Anh on 03/07/2018: Bổ sung trường NotesDeSO, InventoryCommonName, NotesSO, ContractNo
---- Modified by Kim Thư on 02/04/2019: Bổ sung ISNULL cho các trường mã phân tích, bổ sung cột InNotes01
---- Modified by Kim Thư on 12/05/2019: Sửa ContractNo lấy của đơn hàng bán (trường hợp đơn hàng sản xuất kế thừa từ đơn hàng bán)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đình Định on 09/03/2023: [THIENNAM] - Lấy lên thẻ OV3014.Endquantity giống với mẫu cũ ở bản ERP7.

/*
EXEC OP3012 @DivisionID = 'SC' ,@SOrderID = 'BD_IO/16/01/004'

*/
CREATE PROCEDURE [dbo].[OP3012] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
		@sSQL2 AS NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@sSelect NVARCHAR(MAX) = '', 
		@sSQLFrom NVARCHAR(MAX),
		@WarehouseID AS VARCHAR(100)

SET @WarehouseID='(''SG01'',''SF09'')'

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
Set @sSQLFrom = ''
IF @CustomizeName = 43 --Customize secoin
	Set @sSQLFrom = @sSQLFrom + '(  Select OT2002.*, Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
													 Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
													 Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
									from OT2002  WITH (NOLOCK) 
								  ) OT2002 '
Else		 
	Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	


SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2002.TransactionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.Notes01 as InNotes01, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2002.OrderQuantity, OT2001.DepartmentID, 
			ISNULL(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, ISNULL(OT2002.EndDate,'''') AS EndDate, OT2002.Orders , OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			ISNULL(OT1002_1.AnaName,'''') AS AnaName1,
			ISNULL(OT1002_2.AnaName,'''') AS AnaName2,
			ISNULL(OT1002_3.AnaName,'''') AS AnaName3,
			ISNULL(OT1002_4.AnaName,'''') AS AnaName4,
			ISNULL(OT1002_5.AnaName,'''') AS AnaName5,
			ISNULL(OT2002.nvarchar01,'''') AS nvarchar01,	ISNULL(OT2002.nvarchar02,'''') AS nvarchar02,	ISNULL(OT2002.nvarchar03,'''') AS nvarchar03,	ISNULL(OT2002.nvarchar04,'''') AS nvarchar04,	ISNULL(OT2002.nvarchar05,'''') AS nvarchar05,	
			ISNULL(OT2002.nvarchar06,'''') AS nvarchar06,	ISNULL(OT2002.nvarchar07,'''') AS nvarchar07,	ISNULL(OT2002.nvarchar08,'''') AS nvarchar08,	ISNULL(OT2002.nvarchar09,'''') AS nvarchar09,	ISNULL(OT2002.nvarchar10,'''') AS nvarchar10,
			OT2001.InheritSOrderID,
			ISNULL(AT1202.Contactor,'''') AS ObjectContactor,
			ISNULL(AT1103_2.FullName,'''') AS SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			ISNULL(OT2001.Varchar01,'''') AS Varchar01, ISNULL(OT2001.Varchar02,'''') AS Varchar02, ISNULL(OT2001.Varchar03,'''') AS Varchar03, ISNULL(OT2001.Varchar04,'''') AS Varchar04, ISNULL(OT2001.Varchar05,'''') AS Varchar05,
			ISNULL(OT2001.Varchar06,'''') AS Varchar06, ISNULL(OT2001.Varchar07,'''') AS Varchar07, ISNULL(OT2001.Varchar08,'''') AS Varchar08, ISNULL(OT2001.Varchar09,'''') AS Varchar09, ISNULL(OT2001.Varchar10,'''') AS Varchar10,
			ISNULL(OT2001.Varchar11,'''') AS Varchar11, ISNULL(OT2001.Varchar12,'''') AS Varchar12, ISNULL(OT2001.Varchar13,'''') AS Varchar13, ISNULL(OT2001.Varchar14,'''') AS Varchar14, ISNULL(OT2001.Varchar15,'''') AS Varchar15,
			ISNULL(OT2001.Varchar16,'''') AS Varchar16, ISNULL(OT2001.Varchar17,'''') AS Varchar17, ISNULL(OT2001.Varchar18,'''') AS Varchar18, ISNULL(OT2001.Varchar19,'''') AS Varchar19, ISNULL(OT2001.Varchar20,'''') AS Varchar20,
			ISNULL(OT2002.Description,'''') AS Description, ISNULL(Inherit_OT2002.Ana01ID,'''') AS PO, Inherit_OT2002.SalePrice, ISNULL(Inherit_OT2002.Notes,'''') as NotesDeSO,ISNULL(Inherit_OT2002.InventoryCommonName,'''') as InventoryCommonName,
			ISNULL(Inherit_OT2001.Notes,'''') AS NotesSO, ISNULL(Inherit_OT2001.ContractNo,'''') AS ContractNo,
			( SELECT SUM(ISNULL(SignQuantity,0)) FROM WQ7000 WHERE DivisionID = OT2001.DivisionID 
															   AND InventoryID = OT2002.InventoryID
															   AND WareHouseID IN '+@WarehouseID+'
															   AND VoucherDate <= OT2001.OrderDate ) AS EndQuantity'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.SOrderID = OT2001.InheritSOrderID AND Inherit_OT2001.DivisionID = OT2001.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 	
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
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
	
	IF @CustomizeName = 54 --- An Phát
	BEGIN
		SET @sSQL = @sSQL + ',
		M37.MaterialID, AT02.InventoryName as MaterialName, M37.MaterialUnitID, M37.MaterialTypeID, M37.MaterialQuantity, M37.Rate, M37.RateDecimalApp, M37.RateWastage, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID, 
		M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
		a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
		a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
		a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
		a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
		'
		
		SET @sSQL3 = '
			LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID  AND M36.ProductID = OT2002.InventoryID AND
							ISNULL(O99.S01ID,'''') = ISNULL(M36.S01ID,'''') AND 
							ISNULL(O99.S02ID,'''') = ISNULL(M36.S02ID,'''') AND 
							ISNULL(O99.S03ID,'''') = ISNULL(M36.S03ID,'''') AND 
							ISNULL(O99.S04ID,'''') = ISNULL(M36.S04ID,'''') AND 
							ISNULL(O99.S05ID,'''') = ISNULL(M36.S05ID,'''') AND 
							ISNULL(O99.S06ID,'''') = ISNULL(M36.S06ID,'''') AND 
							ISNULL(O99.S07ID,'''') = ISNULL(M36.S07ID,'''') AND 
							ISNULL(O99.S08ID,'''') = ISNULL(M36.S08ID,'''') AND 
							ISNULL(O99.S09ID,'''') = ISNULL(M36.S09ID,'''') AND 
							ISNULL(O99.S10ID,'''') = ISNULL(M36.S10ID,'''') AND 
							ISNULL(O99.S11ID,'''') = ISNULL(M36.S11ID,'''') AND 
							ISNULL(O99.S12ID,'''') = ISNULL(M36.S12ID,'''') AND 
							ISNULL(O99.S13ID,'''') = ISNULL(M36.S13ID,'''') AND 
							ISNULL(O99.S14ID,'''') = ISNULL(M36.S14ID,'''') AND 
							ISNULL(O99.S15ID,'''') = ISNULL(M36.S15ID,'''') AND 
							ISNULL(O99.S16ID,'''') = ISNULL(M36.S16ID,'''') AND 
							ISNULL(O99.S17ID,'''') = ISNULL(M36.S17ID,'''') AND 
							ISNULL(O99.S18ID,'''') = ISNULL(M36.S18ID,'''') AND 
							ISNULL(O99.S19ID,'''') = ISNULL(M36.S19ID,'''') AND 
							ISNULL(O99.S20ID,'''') = ISNULL(M36.S20ID,'''') 
			LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
			LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', M37.DivisionID) AND AT02.InventoryID = M37.MaterialID
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID

			' + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE IF @CustomizeName = 43 --Customize secoin
		 BEGIN
			SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name 
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
			SET @sSQL3 = ' LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID

						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
		 END
	ELSE
		SET @sSQL2 = @sSQL2 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END
ELSE
BEGIN
	IF @CustomizeName = 43 --Customize secoin
	BEGIN
		SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
									
		SET @sSQL1 = @sSQL1 + '	LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID
						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE
		SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END			

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='OV3014')
	EXEC ('CREATE VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)
ELSE
	EXEC( 'ALTER VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In don hang san xuat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/09/2004 by Vo Thanh Huong
---- 
---- Last Edit Thuy Tuyen, date 03/10/2009
---- Edit Thuy Tuyen, date 20/11/2009  them cac truong ma phan tich nghiep vu.
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung them 1 so truong
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung Phonenumber, ObjectName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung 20 tham so varchar01->varchar20
---- Modified on 19/11/2011 by Le Thi Thu Hien : Chuoi dai hon 4000 ky tu
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bổ sung Decription
---- Modified on 25/12/2015 Tieu by Mai: Bo sung thong tin quy cach khi co thiet lap quan ly hang theo quy cach
---- Modified by Tiểu Mai on 05/01/2016: Lấy thông tin bộ định mức đính kèm đơn hàng sản xuất
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát (CustomizeIndex = 54)
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng Vũ on 14/07/2016: Customize secoin, Load thêm hình và code màu mã phân tích mặt hàng
---- Modified by Hoàng Vũ on 10/08/2016: Customize secoin, Xử lý đơn vị tính quy đổi (Vien, Hop, met và pallet)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường PO, SalePrice được lấy từ chi tiết đơn hàng bán (HHP)
---- Modify on 27/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Anh on 03/07/2018: Bổ sung trường NotesDeSO, InventoryCommonName, NotesSO, ContractNo
---- Modified by Kim Thư on 02/04/2019: Bổ sung ISNULL cho các trường mã phân tích, bổ sung cột InNotes01
---- Modified by Kim Thư on 12/05/2019: Sửa ContractNo lấy của đơn hàng bán (trường hợp đơn hàng sản xuất kế thừa từ đơn hàng bán)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đình Định on 09/03/2023: [THIENNAM] - Lấy lên thẻ OV3014.Endquantity giống với mẫu cũ ở bản ERP7.

/*
EXEC OP3012 @DivisionID = 'SC' ,@SOrderID = 'BD_IO/16/01/004'

*/
CREATE PROCEDURE [dbo].[OP3012] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
		@sSQL2 AS NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@sSelect NVARCHAR(MAX) = '', 
		@sSQLFrom NVARCHAR(MAX),
		@WarehouseID AS VARCHAR(100)

SET @WarehouseID='(''SG01'',''SF09'')'

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
Set @sSQLFrom = ''
IF @CustomizeName = 43 --Customize secoin
	Set @sSQLFrom = @sSQLFrom + '(  Select OT2002.*, Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
													 Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
													 Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
									from OT2002  WITH (NOLOCK) 
								  ) OT2002 '
Else		 
	Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	


SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2002.TransactionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.Notes01 as InNotes01, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2002.OrderQuantity, OT2001.DepartmentID, 
			ISNULL(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, ISNULL(OT2002.EndDate,'''') AS EndDate, OT2002.Orders , OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			ISNULL(OT1002_1.AnaName,'''') AS AnaName1,
			ISNULL(OT1002_2.AnaName,'''') AS AnaName2,
			ISNULL(OT1002_3.AnaName,'''') AS AnaName3,
			ISNULL(OT1002_4.AnaName,'''') AS AnaName4,
			ISNULL(OT1002_5.AnaName,'''') AS AnaName5,
			ISNULL(OT2002.nvarchar01,'''') AS nvarchar01,	ISNULL(OT2002.nvarchar02,'''') AS nvarchar02,	ISNULL(OT2002.nvarchar03,'''') AS nvarchar03,	ISNULL(OT2002.nvarchar04,'''') AS nvarchar04,	ISNULL(OT2002.nvarchar05,'''') AS nvarchar05,	
			ISNULL(OT2002.nvarchar06,'''') AS nvarchar06,	ISNULL(OT2002.nvarchar07,'''') AS nvarchar07,	ISNULL(OT2002.nvarchar08,'''') AS nvarchar08,	ISNULL(OT2002.nvarchar09,'''') AS nvarchar09,	ISNULL(OT2002.nvarchar10,'''') AS nvarchar10,
			OT2001.InheritSOrderID,
			ISNULL(AT1202.Contactor,'''') AS ObjectContactor,
			ISNULL(AT1103_2.FullName,'''') AS SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			ISNULL(OT2001.Varchar01,'''') AS Varchar01, ISNULL(OT2001.Varchar02,'''') AS Varchar02, ISNULL(OT2001.Varchar03,'''') AS Varchar03, ISNULL(OT2001.Varchar04,'''') AS Varchar04, ISNULL(OT2001.Varchar05,'''') AS Varchar05,
			ISNULL(OT2001.Varchar06,'''') AS Varchar06, ISNULL(OT2001.Varchar07,'''') AS Varchar07, ISNULL(OT2001.Varchar08,'''') AS Varchar08, ISNULL(OT2001.Varchar09,'''') AS Varchar09, ISNULL(OT2001.Varchar10,'''') AS Varchar10,
			ISNULL(OT2001.Varchar11,'''') AS Varchar11, ISNULL(OT2001.Varchar12,'''') AS Varchar12, ISNULL(OT2001.Varchar13,'''') AS Varchar13, ISNULL(OT2001.Varchar14,'''') AS Varchar14, ISNULL(OT2001.Varchar15,'''') AS Varchar15,
			ISNULL(OT2001.Varchar16,'''') AS Varchar16, ISNULL(OT2001.Varchar17,'''') AS Varchar17, ISNULL(OT2001.Varchar18,'''') AS Varchar18, ISNULL(OT2001.Varchar19,'''') AS Varchar19, ISNULL(OT2001.Varchar20,'''') AS Varchar20,
			ISNULL(OT2002.Description,'''') AS Description, ISNULL(Inherit_OT2002.Ana01ID,'''') AS PO, Inherit_OT2002.SalePrice, ISNULL(Inherit_OT2002.Notes,'''') as NotesDeSO,ISNULL(Inherit_OT2002.InventoryCommonName,'''') as InventoryCommonName,
			ISNULL(Inherit_OT2001.Notes,'''') AS NotesSO, ISNULL(Inherit_OT2001.ContractNo,'''') AS ContractNo,
			( SELECT SUM(ISNULL(SignQuantity,0)) FROM WQ7000 WHERE DivisionID = OT2001.DivisionID 
															   AND InventoryID = OT2002.InventoryID
															   AND WareHouseID IN '+@WarehouseID+'
															   AND VoucherDate <= OT2001.OrderDate ) AS EndQuantity'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.SOrderID = OT2001.InheritSOrderID AND Inherit_OT2001.DivisionID = OT2001.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 	
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
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
	
	IF @CustomizeName = 54 --- An Phát
	BEGIN
		SET @sSQL = @sSQL + ',
		M37.MaterialID, AT02.InventoryName as MaterialName, M37.MaterialUnitID, M37.MaterialTypeID, M37.MaterialQuantity, M37.Rate, M37.RateDecimalApp, M37.RateWastage, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID, 
		M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
		a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
		a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
		a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
		a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
		'
		
		SET @sSQL3 = '
			LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID  AND M36.ProductID = OT2002.InventoryID AND
							ISNULL(O99.S01ID,'''') = ISNULL(M36.S01ID,'''') AND 
							ISNULL(O99.S02ID,'''') = ISNULL(M36.S02ID,'''') AND 
							ISNULL(O99.S03ID,'''') = ISNULL(M36.S03ID,'''') AND 
							ISNULL(O99.S04ID,'''') = ISNULL(M36.S04ID,'''') AND 
							ISNULL(O99.S05ID,'''') = ISNULL(M36.S05ID,'''') AND 
							ISNULL(O99.S06ID,'''') = ISNULL(M36.S06ID,'''') AND 
							ISNULL(O99.S07ID,'''') = ISNULL(M36.S07ID,'''') AND 
							ISNULL(O99.S08ID,'''') = ISNULL(M36.S08ID,'''') AND 
							ISNULL(O99.S09ID,'''') = ISNULL(M36.S09ID,'''') AND 
							ISNULL(O99.S10ID,'''') = ISNULL(M36.S10ID,'''') AND 
							ISNULL(O99.S11ID,'''') = ISNULL(M36.S11ID,'''') AND 
							ISNULL(O99.S12ID,'''') = ISNULL(M36.S12ID,'''') AND 
							ISNULL(O99.S13ID,'''') = ISNULL(M36.S13ID,'''') AND 
							ISNULL(O99.S14ID,'''') = ISNULL(M36.S14ID,'''') AND 
							ISNULL(O99.S15ID,'''') = ISNULL(M36.S15ID,'''') AND 
							ISNULL(O99.S16ID,'''') = ISNULL(M36.S16ID,'''') AND 
							ISNULL(O99.S17ID,'''') = ISNULL(M36.S17ID,'''') AND 
							ISNULL(O99.S18ID,'''') = ISNULL(M36.S18ID,'''') AND 
							ISNULL(O99.S19ID,'''') = ISNULL(M36.S19ID,'''') AND 
							ISNULL(O99.S20ID,'''') = ISNULL(M36.S20ID,'''') 
			LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
			LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', M37.DivisionID) AND AT02.InventoryID = M37.MaterialID
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID

			' + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE IF @CustomizeName = 43 --Customize secoin
		 BEGIN
			SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name 
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
			SET @sSQL3 = ' LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID

						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
		 END
	ELSE
		SET @sSQL2 = @sSQL2 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END
ELSE
BEGIN
	IF @CustomizeName = 43 --Customize secoin
	BEGIN
		SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
									
		SET @sSQL1 = @sSQL1 + '	LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID
						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE
		SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END			

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='OV3014')
	EXEC ('CREATE VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)
ELSE
	EXEC( 'ALTER VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In don hang san xuat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/09/2004 by Vo Thanh Huong
---- 
---- Last Edit Thuy Tuyen, date 03/10/2009
---- Edit Thuy Tuyen, date 20/11/2009  them cac truong ma phan tich nghiep vu.
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung them 1 so truong
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung Phonenumber, ObjectName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung 20 tham so varchar01->varchar20
---- Modified on 19/11/2011 by Le Thi Thu Hien : Chuoi dai hon 4000 ky tu
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bổ sung Decription
---- Modified on 25/12/2015 Tieu by Mai: Bo sung thong tin quy cach khi co thiet lap quan ly hang theo quy cach
---- Modified by Tiểu Mai on 05/01/2016: Lấy thông tin bộ định mức đính kèm đơn hàng sản xuất
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát (CustomizeIndex = 54)
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng Vũ on 14/07/2016: Customize secoin, Load thêm hình và code màu mã phân tích mặt hàng
---- Modified by Hoàng Vũ on 10/08/2016: Customize secoin, Xử lý đơn vị tính quy đổi (Vien, Hop, met và pallet)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường PO, SalePrice được lấy từ chi tiết đơn hàng bán (HHP)
---- Modify on 27/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Anh on 03/07/2018: Bổ sung trường NotesDeSO, InventoryCommonName, NotesSO, ContractNo
---- Modified by Kim Thư on 02/04/2019: Bổ sung ISNULL cho các trường mã phân tích, bổ sung cột InNotes01
---- Modified by Kim Thư on 12/05/2019: Sửa ContractNo lấy của đơn hàng bán (trường hợp đơn hàng sản xuất kế thừa từ đơn hàng bán)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đình Định on 09/03/2023: [THIENNAM] - Lấy lên thẻ OV3014.Endquantity giống với mẫu cũ ở bản ERP7.

/*
EXEC OP3012 @DivisionID = 'SC' ,@SOrderID = 'BD_IO/16/01/004'

*/
CREATE PROCEDURE [dbo].[OP3012] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
		@sSQL2 AS NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@sSelect NVARCHAR(MAX) = '', 
		@sSQLFrom NVARCHAR(MAX),
		@WarehouseID AS VARCHAR(100)

SET @WarehouseID='(''SG01'',''SF09'')'

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
Set @sSQLFrom = ''
IF @CustomizeName = 43 --Customize secoin
	Set @sSQLFrom = @sSQLFrom + '(  Select OT2002.*, Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
													 Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
													 Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
									from OT2002  WITH (NOLOCK) 
								  ) OT2002 '
Else		 
	Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	


SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2002.TransactionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.Notes01 as InNotes01, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2002.OrderQuantity, OT2001.DepartmentID, 
			ISNULL(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, ISNULL(OT2002.EndDate,'''') AS EndDate, OT2002.Orders , OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			ISNULL(OT1002_1.AnaName,'''') AS AnaName1,
			ISNULL(OT1002_2.AnaName,'''') AS AnaName2,
			ISNULL(OT1002_3.AnaName,'''') AS AnaName3,
			ISNULL(OT1002_4.AnaName,'''') AS AnaName4,
			ISNULL(OT1002_5.AnaName,'''') AS AnaName5,
			ISNULL(OT2002.nvarchar01,'''') AS nvarchar01,	ISNULL(OT2002.nvarchar02,'''') AS nvarchar02,	ISNULL(OT2002.nvarchar03,'''') AS nvarchar03,	ISNULL(OT2002.nvarchar04,'''') AS nvarchar04,	ISNULL(OT2002.nvarchar05,'''') AS nvarchar05,	
			ISNULL(OT2002.nvarchar06,'''') AS nvarchar06,	ISNULL(OT2002.nvarchar07,'''') AS nvarchar07,	ISNULL(OT2002.nvarchar08,'''') AS nvarchar08,	ISNULL(OT2002.nvarchar09,'''') AS nvarchar09,	ISNULL(OT2002.nvarchar10,'''') AS nvarchar10,
			OT2001.InheritSOrderID,
			ISNULL(AT1202.Contactor,'''') AS ObjectContactor,
			ISNULL(AT1103_2.FullName,'''') AS SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			ISNULL(OT2001.Varchar01,'''') AS Varchar01, ISNULL(OT2001.Varchar02,'''') AS Varchar02, ISNULL(OT2001.Varchar03,'''') AS Varchar03, ISNULL(OT2001.Varchar04,'''') AS Varchar04, ISNULL(OT2001.Varchar05,'''') AS Varchar05,
			ISNULL(OT2001.Varchar06,'''') AS Varchar06, ISNULL(OT2001.Varchar07,'''') AS Varchar07, ISNULL(OT2001.Varchar08,'''') AS Varchar08, ISNULL(OT2001.Varchar09,'''') AS Varchar09, ISNULL(OT2001.Varchar10,'''') AS Varchar10,
			ISNULL(OT2001.Varchar11,'''') AS Varchar11, ISNULL(OT2001.Varchar12,'''') AS Varchar12, ISNULL(OT2001.Varchar13,'''') AS Varchar13, ISNULL(OT2001.Varchar14,'''') AS Varchar14, ISNULL(OT2001.Varchar15,'''') AS Varchar15,
			ISNULL(OT2001.Varchar16,'''') AS Varchar16, ISNULL(OT2001.Varchar17,'''') AS Varchar17, ISNULL(OT2001.Varchar18,'''') AS Varchar18, ISNULL(OT2001.Varchar19,'''') AS Varchar19, ISNULL(OT2001.Varchar20,'''') AS Varchar20,
			ISNULL(OT2002.Description,'''') AS Description, ISNULL(Inherit_OT2002.Ana01ID,'''') AS PO, Inherit_OT2002.SalePrice, ISNULL(Inherit_OT2002.Notes,'''') as NotesDeSO,ISNULL(Inherit_OT2002.InventoryCommonName,'''') as InventoryCommonName,
			ISNULL(Inherit_OT2001.Notes,'''') AS NotesSO, ISNULL(Inherit_OT2001.ContractNo,'''') AS ContractNo,
			( SELECT SUM(ISNULL(SignQuantity,0)) FROM WQ7000 WHERE DivisionID = OT2001.DivisionID 
															   AND InventoryID = OT2002.InventoryID
															   AND WareHouseID IN '+@WarehouseID+'
															   AND VoucherDate <= OT2001.OrderDate ) AS EndQuantity'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.SOrderID = OT2001.InheritSOrderID AND Inherit_OT2001.DivisionID = OT2001.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 	
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
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
	
	IF @CustomizeName = 54 --- An Phát
	BEGIN
		SET @sSQL = @sSQL + ',
		M37.MaterialID, AT02.InventoryName as MaterialName, M37.MaterialUnitID, M37.MaterialTypeID, M37.MaterialQuantity, M37.Rate, M37.RateDecimalApp, M37.RateWastage, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID, 
		M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
		a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
		a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
		a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
		a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
		'
		
		SET @sSQL3 = '
			LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID  AND M36.ProductID = OT2002.InventoryID AND
							ISNULL(O99.S01ID,'''') = ISNULL(M36.S01ID,'''') AND 
							ISNULL(O99.S02ID,'''') = ISNULL(M36.S02ID,'''') AND 
							ISNULL(O99.S03ID,'''') = ISNULL(M36.S03ID,'''') AND 
							ISNULL(O99.S04ID,'''') = ISNULL(M36.S04ID,'''') AND 
							ISNULL(O99.S05ID,'''') = ISNULL(M36.S05ID,'''') AND 
							ISNULL(O99.S06ID,'''') = ISNULL(M36.S06ID,'''') AND 
							ISNULL(O99.S07ID,'''') = ISNULL(M36.S07ID,'''') AND 
							ISNULL(O99.S08ID,'''') = ISNULL(M36.S08ID,'''') AND 
							ISNULL(O99.S09ID,'''') = ISNULL(M36.S09ID,'''') AND 
							ISNULL(O99.S10ID,'''') = ISNULL(M36.S10ID,'''') AND 
							ISNULL(O99.S11ID,'''') = ISNULL(M36.S11ID,'''') AND 
							ISNULL(O99.S12ID,'''') = ISNULL(M36.S12ID,'''') AND 
							ISNULL(O99.S13ID,'''') = ISNULL(M36.S13ID,'''') AND 
							ISNULL(O99.S14ID,'''') = ISNULL(M36.S14ID,'''') AND 
							ISNULL(O99.S15ID,'''') = ISNULL(M36.S15ID,'''') AND 
							ISNULL(O99.S16ID,'''') = ISNULL(M36.S16ID,'''') AND 
							ISNULL(O99.S17ID,'''') = ISNULL(M36.S17ID,'''') AND 
							ISNULL(O99.S18ID,'''') = ISNULL(M36.S18ID,'''') AND 
							ISNULL(O99.S19ID,'''') = ISNULL(M36.S19ID,'''') AND 
							ISNULL(O99.S20ID,'''') = ISNULL(M36.S20ID,'''') 
			LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
			LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', M37.DivisionID) AND AT02.InventoryID = M37.MaterialID
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID

			' + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE IF @CustomizeName = 43 --Customize secoin
		 BEGIN
			SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name 
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
			SET @sSQL3 = ' LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID

						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
		 END
	ELSE
		SET @sSQL2 = @sSQL2 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END
ELSE
BEGIN
	IF @CustomizeName = 43 --Customize secoin
	BEGIN
		SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
									
		SET @sSQL1 = @sSQL1 + '	LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID
						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE
		SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END			

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='OV3014')
	EXEC ('CREATE VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)
ELSE
	EXEC( 'ALTER VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In don hang san xuat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/09/2004 by Vo Thanh Huong
---- 
---- Last Edit Thuy Tuyen, date 03/10/2009
---- Edit Thuy Tuyen, date 20/11/2009  them cac truong ma phan tich nghiep vu.
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung them 1 so truong
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung Phonenumber, ObjectName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung 20 tham so varchar01->varchar20
---- Modified on 19/11/2011 by Le Thi Thu Hien : Chuoi dai hon 4000 ky tu
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bổ sung Decription
---- Modified on 25/12/2015 Tieu by Mai: Bo sung thong tin quy cach khi co thiet lap quan ly hang theo quy cach
---- Modified by Tiểu Mai on 05/01/2016: Lấy thông tin bộ định mức đính kèm đơn hàng sản xuất
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát (CustomizeIndex = 54)
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng Vũ on 14/07/2016: Customize secoin, Load thêm hình và code màu mã phân tích mặt hàng
---- Modified by Hoàng Vũ on 10/08/2016: Customize secoin, Xử lý đơn vị tính quy đổi (Vien, Hop, met và pallet)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường PO, SalePrice được lấy từ chi tiết đơn hàng bán (HHP)
---- Modify on 27/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Anh on 03/07/2018: Bổ sung trường NotesDeSO, InventoryCommonName, NotesSO, ContractNo
---- Modified by Kim Thư on 02/04/2019: Bổ sung ISNULL cho các trường mã phân tích, bổ sung cột InNotes01
---- Modified by Kim Thư on 12/05/2019: Sửa ContractNo lấy của đơn hàng bán (trường hợp đơn hàng sản xuất kế thừa từ đơn hàng bán)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đình Định on 09/03/2023: [THIENNAM] - Lấy lên thẻ OV3014.Endquantity giống với mẫu cũ ở bản ERP7.

/*
EXEC OP3012 @DivisionID = 'SC' ,@SOrderID = 'BD_IO/16/01/004'

*/
CREATE PROCEDURE [dbo].[OP3012] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
		@sSQL2 AS NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@sSelect NVARCHAR(MAX) = '', 
		@sSQLFrom NVARCHAR(MAX),
		@WarehouseID AS VARCHAR(100)

SET @WarehouseID='(''SG01'',''SF09'')'

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
Set @sSQLFrom = ''
IF @CustomizeName = 43 --Customize secoin
	Set @sSQLFrom = @sSQLFrom + '(  Select OT2002.*, Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
													 Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
													 Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
									from OT2002  WITH (NOLOCK) 
								  ) OT2002 '
Else		 
	Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	


SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2002.TransactionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.Notes01 as InNotes01, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2002.OrderQuantity, OT2001.DepartmentID, 
			ISNULL(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, ISNULL(OT2002.EndDate,'''') AS EndDate, OT2002.Orders , OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			ISNULL(OT1002_1.AnaName,'''') AS AnaName1,
			ISNULL(OT1002_2.AnaName,'''') AS AnaName2,
			ISNULL(OT1002_3.AnaName,'''') AS AnaName3,
			ISNULL(OT1002_4.AnaName,'''') AS AnaName4,
			ISNULL(OT1002_5.AnaName,'''') AS AnaName5,
			ISNULL(OT2002.nvarchar01,'''') AS nvarchar01,	ISNULL(OT2002.nvarchar02,'''') AS nvarchar02,	ISNULL(OT2002.nvarchar03,'''') AS nvarchar03,	ISNULL(OT2002.nvarchar04,'''') AS nvarchar04,	ISNULL(OT2002.nvarchar05,'''') AS nvarchar05,	
			ISNULL(OT2002.nvarchar06,'''') AS nvarchar06,	ISNULL(OT2002.nvarchar07,'''') AS nvarchar07,	ISNULL(OT2002.nvarchar08,'''') AS nvarchar08,	ISNULL(OT2002.nvarchar09,'''') AS nvarchar09,	ISNULL(OT2002.nvarchar10,'''') AS nvarchar10,
			OT2001.InheritSOrderID,
			ISNULL(AT1202.Contactor,'''') AS ObjectContactor,
			ISNULL(AT1103_2.FullName,'''') AS SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			ISNULL(OT2001.Varchar01,'''') AS Varchar01, ISNULL(OT2001.Varchar02,'''') AS Varchar02, ISNULL(OT2001.Varchar03,'''') AS Varchar03, ISNULL(OT2001.Varchar04,'''') AS Varchar04, ISNULL(OT2001.Varchar05,'''') AS Varchar05,
			ISNULL(OT2001.Varchar06,'''') AS Varchar06, ISNULL(OT2001.Varchar07,'''') AS Varchar07, ISNULL(OT2001.Varchar08,'''') AS Varchar08, ISNULL(OT2001.Varchar09,'''') AS Varchar09, ISNULL(OT2001.Varchar10,'''') AS Varchar10,
			ISNULL(OT2001.Varchar11,'''') AS Varchar11, ISNULL(OT2001.Varchar12,'''') AS Varchar12, ISNULL(OT2001.Varchar13,'''') AS Varchar13, ISNULL(OT2001.Varchar14,'''') AS Varchar14, ISNULL(OT2001.Varchar15,'''') AS Varchar15,
			ISNULL(OT2001.Varchar16,'''') AS Varchar16, ISNULL(OT2001.Varchar17,'''') AS Varchar17, ISNULL(OT2001.Varchar18,'''') AS Varchar18, ISNULL(OT2001.Varchar19,'''') AS Varchar19, ISNULL(OT2001.Varchar20,'''') AS Varchar20,
			ISNULL(OT2002.Description,'''') AS Description, ISNULL(Inherit_OT2002.Ana01ID,'''') AS PO, Inherit_OT2002.SalePrice, ISNULL(Inherit_OT2002.Notes,'''') as NotesDeSO,ISNULL(Inherit_OT2002.InventoryCommonName,'''') as InventoryCommonName,
			ISNULL(Inherit_OT2001.Notes,'''') AS NotesSO, ISNULL(Inherit_OT2001.ContractNo,'''') AS ContractNo,
			( SELECT SUM(ISNULL(SignQuantity,0)) FROM WQ7000 WHERE DivisionID = OT2001.DivisionID 
															   AND InventoryID = OT2002.InventoryID
															   AND WareHouseID IN '+@WarehouseID+'
															   AND VoucherDate <= OT2001.OrderDate ) AS EndQuantity'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.SOrderID = OT2001.InheritSOrderID AND Inherit_OT2001.DivisionID = OT2001.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 	
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
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
	
	IF @CustomizeName = 54 --- An Phát
	BEGIN
		SET @sSQL = @sSQL + ',
		M37.MaterialID, AT02.InventoryName as MaterialName, M37.MaterialUnitID, M37.MaterialTypeID, M37.MaterialQuantity, M37.Rate, M37.RateDecimalApp, M37.RateWastage, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID, 
		M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
		a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
		a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
		a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
		a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
		'
		
		SET @sSQL3 = '
			LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID  AND M36.ProductID = OT2002.InventoryID AND
							ISNULL(O99.S01ID,'''') = ISNULL(M36.S01ID,'''') AND 
							ISNULL(O99.S02ID,'''') = ISNULL(M36.S02ID,'''') AND 
							ISNULL(O99.S03ID,'''') = ISNULL(M36.S03ID,'''') AND 
							ISNULL(O99.S04ID,'''') = ISNULL(M36.S04ID,'''') AND 
							ISNULL(O99.S05ID,'''') = ISNULL(M36.S05ID,'''') AND 
							ISNULL(O99.S06ID,'''') = ISNULL(M36.S06ID,'''') AND 
							ISNULL(O99.S07ID,'''') = ISNULL(M36.S07ID,'''') AND 
							ISNULL(O99.S08ID,'''') = ISNULL(M36.S08ID,'''') AND 
							ISNULL(O99.S09ID,'''') = ISNULL(M36.S09ID,'''') AND 
							ISNULL(O99.S10ID,'''') = ISNULL(M36.S10ID,'''') AND 
							ISNULL(O99.S11ID,'''') = ISNULL(M36.S11ID,'''') AND 
							ISNULL(O99.S12ID,'''') = ISNULL(M36.S12ID,'''') AND 
							ISNULL(O99.S13ID,'''') = ISNULL(M36.S13ID,'''') AND 
							ISNULL(O99.S14ID,'''') = ISNULL(M36.S14ID,'''') AND 
							ISNULL(O99.S15ID,'''') = ISNULL(M36.S15ID,'''') AND 
							ISNULL(O99.S16ID,'''') = ISNULL(M36.S16ID,'''') AND 
							ISNULL(O99.S17ID,'''') = ISNULL(M36.S17ID,'''') AND 
							ISNULL(O99.S18ID,'''') = ISNULL(M36.S18ID,'''') AND 
							ISNULL(O99.S19ID,'''') = ISNULL(M36.S19ID,'''') AND 
							ISNULL(O99.S20ID,'''') = ISNULL(M36.S20ID,'''') 
			LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
			LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', M37.DivisionID) AND AT02.InventoryID = M37.MaterialID
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID

			' + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE IF @CustomizeName = 43 --Customize secoin
		 BEGIN
			SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name 
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
			SET @sSQL3 = ' LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID

						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
		 END
	ELSE
		SET @sSQL2 = @sSQL2 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END
ELSE
BEGIN
	IF @CustomizeName = 43 --Customize secoin
	BEGIN
		SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
									
		SET @sSQL1 = @sSQL1 + '	LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID
						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE
		SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END			

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='OV3014')
	EXEC ('CREATE VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)
ELSE
	EXEC( 'ALTER VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In don hang san xuat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/09/2004 by Vo Thanh Huong
---- 
---- Last Edit Thuy Tuyen, date 03/10/2009
---- Edit Thuy Tuyen, date 20/11/2009  them cac truong ma phan tich nghiep vu.
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung them 1 so truong
---- Modified on 10/10/2011 by Le Thi Thu Hien : Bo sung Phonenumber, ObjectName
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung 20 tham so varchar01->varchar20
---- Modified on 19/11/2011 by Le Thi Thu Hien : Chuoi dai hon 4000 ky tu
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bổ sung Decription
---- Modified on 25/12/2015 Tieu by Mai: Bo sung thong tin quy cach khi co thiet lap quan ly hang theo quy cach
---- Modified by Tiểu Mai on 05/01/2016: Lấy thông tin bộ định mức đính kèm đơn hàng sản xuất
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát (CustomizeIndex = 54)
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng Vũ on 14/07/2016: Customize secoin, Load thêm hình và code màu mã phân tích mặt hàng
---- Modified by Hoàng Vũ on 10/08/2016: Customize secoin, Xử lý đơn vị tính quy đổi (Vien, Hop, met và pallet)
---- Modified by Hải Long on 07/04/2017: Bổ sung trường PO, SalePrice được lấy từ chi tiết đơn hàng bán (HHP)
---- Modify on 27/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Anh on 03/07/2018: Bổ sung trường NotesDeSO, InventoryCommonName, NotesSO, ContractNo
---- Modified by Kim Thư on 02/04/2019: Bổ sung ISNULL cho các trường mã phân tích, bổ sung cột InNotes01
---- Modified by Kim Thư on 12/05/2019: Sửa ContractNo lấy của đơn hàng bán (trường hợp đơn hàng sản xuất kế thừa từ đơn hàng bán)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đình Định on 09/03/2023: [THIENNAM] - Lấy lên thẻ OV3014.Endquantity giống với mẫu cũ ở bản ERP7.

/*
EXEC OP3012 @DivisionID = 'SC' ,@SOrderID = 'BD_IO/16/01/004'

*/
CREATE PROCEDURE [dbo].[OP3012] 	
				@DivisionID AS nvarchar(50),			
				@SOrderID AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX), 
		@sSQL2 AS NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@sSelect NVARCHAR(MAX) = '', 
		@sSQLFrom NVARCHAR(MAX),
		@WarehouseID AS VARCHAR(100)

SET @WarehouseID='(''SG01'',''SF09'')'

DECLARE @CustomizeName INT
SET @CustomizeName  = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL2 = ''
Set @sSQLFrom = ''
IF @CustomizeName = 43 --Customize secoin
	Set @sSQLFrom = @sSQLFrom + '(  Select OT2002.*, Case When OT2002.UnitID =''M2'' then OT2002.ConvertedQuantity else null end as Met_Quantity,
													 Case When OT2002.UnitID =''H'' then OT2002.ConvertedQuantity else null end as Hop_Quantity,
													 Case When OT2002.UnitID =''P'' then OT2002.ConvertedQuantity else null end as Pallets_Quantity
									from OT2002  WITH (NOLOCK) 
								  ) OT2002 '
Else		 
	Set @sSQLFrom = @sSQLFrom + ' OT2002 WITH (NOLOCK) '               	


SET @sSQL = N'
	SELECT	OT2002.DivisionID, OT2001.SOrderID, OT2002.TransactionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, 
			OT2001.ObjectID, 
			CASE WHEN ISNULL(OT2001.ObjectName,'''') = ''''  THEN AT1202.ObjectName ELSE OT2001.ObjectName end AS ObjectName,
			CASE WHEN ISNULL(OT2001.Address, '''') = '''' THEN AT1202.Address ELSE OT2001.Address end AS ObjectAddress, 
			OT2001.EmployeeID, AT1103.FullName, AT1103.Address AS EmployeeAddress,
			OT2002.InventoryID, AT1302.InventoryName, AT1302.Notes01 as InNotes01, AT1302.UnitID, AT1304.UnitName, 
			OT2002.MethodID, MethodName, OT2002.OrderQuantity, OT2001.DepartmentID, 
			ISNULL(AT1102.DepartmentName, '''') AS DepartmentName, OT2002.LinkNo, ISNULL(OT2002.EndDate,'''') AS EndDate, OT2002.Orders , OT2002.RefInfor, OT2001.Notes	,
			InheritedQuantity,OT2001.PeriodID, 
			OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, 
			ISNULL(OT1002_1.AnaName,'''') AS AnaName1,
			ISNULL(OT1002_2.AnaName,'''') AS AnaName2,
			ISNULL(OT1002_3.AnaName,'''') AS AnaName3,
			ISNULL(OT1002_4.AnaName,'''') AS AnaName4,
			ISNULL(OT1002_5.AnaName,'''') AS AnaName5,
			ISNULL(OT2002.nvarchar01,'''') AS nvarchar01,	ISNULL(OT2002.nvarchar02,'''') AS nvarchar02,	ISNULL(OT2002.nvarchar03,'''') AS nvarchar03,	ISNULL(OT2002.nvarchar04,'''') AS nvarchar04,	ISNULL(OT2002.nvarchar05,'''') AS nvarchar05,	
			ISNULL(OT2002.nvarchar06,'''') AS nvarchar06,	ISNULL(OT2002.nvarchar07,'''') AS nvarchar07,	ISNULL(OT2002.nvarchar08,'''') AS nvarchar08,	ISNULL(OT2002.nvarchar09,'''') AS nvarchar09,	ISNULL(OT2002.nvarchar10,'''') AS nvarchar10,
			OT2001.InheritSOrderID,
			ISNULL(AT1202.Contactor,'''') AS ObjectContactor,
			ISNULL(AT1103_2.FullName,'''') AS SalesManName,
			AT1302.InventoryTypeID,
			AT1202.Phonenumber,
			ISNULL(OT2001.Varchar01,'''') AS Varchar01, ISNULL(OT2001.Varchar02,'''') AS Varchar02, ISNULL(OT2001.Varchar03,'''') AS Varchar03, ISNULL(OT2001.Varchar04,'''') AS Varchar04, ISNULL(OT2001.Varchar05,'''') AS Varchar05,
			ISNULL(OT2001.Varchar06,'''') AS Varchar06, ISNULL(OT2001.Varchar07,'''') AS Varchar07, ISNULL(OT2001.Varchar08,'''') AS Varchar08, ISNULL(OT2001.Varchar09,'''') AS Varchar09, ISNULL(OT2001.Varchar10,'''') AS Varchar10,
			ISNULL(OT2001.Varchar11,'''') AS Varchar11, ISNULL(OT2001.Varchar12,'''') AS Varchar12, ISNULL(OT2001.Varchar13,'''') AS Varchar13, ISNULL(OT2001.Varchar14,'''') AS Varchar14, ISNULL(OT2001.Varchar15,'''') AS Varchar15,
			ISNULL(OT2001.Varchar16,'''') AS Varchar16, ISNULL(OT2001.Varchar17,'''') AS Varchar17, ISNULL(OT2001.Varchar18,'''') AS Varchar18, ISNULL(OT2001.Varchar19,'''') AS Varchar19, ISNULL(OT2001.Varchar20,'''') AS Varchar20,
			ISNULL(OT2002.Description,'''') AS Description, ISNULL(Inherit_OT2002.Ana01ID,'''') AS PO, Inherit_OT2002.SalePrice, ISNULL(Inherit_OT2002.Notes,'''') as NotesDeSO,ISNULL(Inherit_OT2002.InventoryCommonName,'''') as InventoryCommonName,
			ISNULL(Inherit_OT2001.Notes,'''') AS NotesSO, ISNULL(Inherit_OT2001.ContractNo,'''') AS ContractNo,
			( SELECT SUM(ISNULL(SignQuantity,0)) FROM WQ7000 WHERE DivisionID = OT2001.DivisionID 
															   AND InventoryID = OT2002.InventoryID
															   AND WareHouseID IN '+@WarehouseID+'
															   AND VoucherDate <= OT2001.OrderDate ) AS EndQuantity'
SET @sSQL1 = N'	FROM ' + @sSQLFrom +	
			'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
	LEFT JOIN OT1003 WITH (NOLOCK) ON OT1003.MethodID = OT2002.MethodID  AND OT1003.DivisionID = OT2002.DivisionID
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2001.DivisionID = OT2002.DivisionID
	LEFT JOIN OT2001 Inherit_OT2001 WITH (NOLOCK) ON Inherit_OT2001.SOrderID = OT2001.InheritSOrderID AND Inherit_OT2001.DivisionID = OT2001.DivisionID	
	LEFT JOIN OT2002 Inherit_OT2002 WITH (NOLOCK) ON Inherit_OT2002.DivisionID = OT2002.DivisionID AND Inherit_OT2002.TransactionID = OT2002.RefSTransactionID 	
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) on AT1103_2.EmployeeID = OT2001.SalesManID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = OT2001.ObjectID
	LEFT JOIN (	SELECT  DivisionID, TransactionID, SOrderID, SUM(ISNULL(InheritedQuantity,0)) AS InheritedQuantity  
				FROM	MQ2221 GROUP BY DivisionID, TransactionID,SOrderID)  AS G ON G.TransactionID = OT2002.TransactionID AND G.DivisionID = OT2002.DivisionID
	LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2002.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2002.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2002.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2002.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2002.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
	'
	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN 
	SET @sSQL = @sSQL + ',
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name'
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
	
	IF @CustomizeName = 54 --- An Phát
	BEGIN
		SET @sSQL = @sSQL + ',
		M37.MaterialID, AT02.InventoryName as MaterialName, M37.MaterialUnitID, M37.MaterialTypeID, M37.MaterialQuantity, M37.Rate, M37.RateDecimalApp, M37.RateWastage, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.DS01ID, M37.DS02ID, M37.DS03ID, M37.DS04ID, M37.DS05ID, M37.DS06ID, M37.DS07ID, M37.DS08ID, M37.DS09ID, M37.DS10ID, 
		M37.DS11ID, M37.DS12ID, M37.DS13ID, M37.DS14ID, M37.DS15ID, M37.DS16ID, M37.DS17ID, M37.DS18ID, M37.DS19ID, M37.DS20ID,
		a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
		a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
		a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
		a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
		'
		
		SET @sSQL3 = '
			LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = OT2001.DivisionID AND M36.ApportionID = OT2001.InheritApportionID  AND M36.ProductID = OT2002.InventoryID AND
							ISNULL(O99.S01ID,'''') = ISNULL(M36.S01ID,'''') AND 
							ISNULL(O99.S02ID,'''') = ISNULL(M36.S02ID,'''') AND 
							ISNULL(O99.S03ID,'''') = ISNULL(M36.S03ID,'''') AND 
							ISNULL(O99.S04ID,'''') = ISNULL(M36.S04ID,'''') AND 
							ISNULL(O99.S05ID,'''') = ISNULL(M36.S05ID,'''') AND 
							ISNULL(O99.S06ID,'''') = ISNULL(M36.S06ID,'''') AND 
							ISNULL(O99.S07ID,'''') = ISNULL(M36.S07ID,'''') AND 
							ISNULL(O99.S08ID,'''') = ISNULL(M36.S08ID,'''') AND 
							ISNULL(O99.S09ID,'''') = ISNULL(M36.S09ID,'''') AND 
							ISNULL(O99.S10ID,'''') = ISNULL(M36.S10ID,'''') AND 
							ISNULL(O99.S11ID,'''') = ISNULL(M36.S11ID,'''') AND 
							ISNULL(O99.S12ID,'''') = ISNULL(M36.S12ID,'''') AND 
							ISNULL(O99.S13ID,'''') = ISNULL(M36.S13ID,'''') AND 
							ISNULL(O99.S14ID,'''') = ISNULL(M36.S14ID,'''') AND 
							ISNULL(O99.S15ID,'''') = ISNULL(M36.S15ID,'''') AND 
							ISNULL(O99.S16ID,'''') = ISNULL(M36.S16ID,'''') AND 
							ISNULL(O99.S17ID,'''') = ISNULL(M36.S17ID,'''') AND 
							ISNULL(O99.S18ID,'''') = ISNULL(M36.S18ID,'''') AND 
							ISNULL(O99.S19ID,'''') = ISNULL(M36.S19ID,'''') AND 
							ISNULL(O99.S20ID,'''') = ISNULL(M36.S20ID,'''') 
			LEFT JOIN MT0137 M37 WITH (NOLOCK) ON M37.DivisionID = M36.DivisionID AND M37.ProductID = M36.ProductID AND M37.ReTransactionID = M36.TransactionID
			LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', M37.DivisionID) AND AT02.InventoryID = M37.MaterialID
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID

			' + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE IF @CustomizeName = 43 --Customize secoin
		 BEGIN
			SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name 
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
			SET @sSQL3 = ' LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID

						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
		 END
	ELSE
		SET @sSQL2 = @sSQL2 + ' WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END
ELSE
BEGIN
	IF @CustomizeName = 43 --Customize secoin
	BEGIN
		SET @sSQL = @sSQL + ' , A00003.Image01ID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I06ID, I07ID, I08ID, I09ID, I10ID 
								  , AT1015_01.AnaName as I01Name, AT1015_02.AnaName as I02Name, AT1015_03.AnaName as I03Name, AT1015_04.AnaName as I04Name
								  , AT1015_05.AnaName as I05Name, AT1015_06.AnaName as I06Name, AT1015_07.AnaName as I07Name, AT1015_08.AnaName as I08Name
								  , AT1015_09.AnaName as I09Name, AT1015_10.AnaName as I10Name
								  , OT2002.ExtraID, AT1320.ExtraName
								  , AT1302.I04ID as Code_mau
								  , AT1302.I02ID as Kich_thuoc_Cm
								  , OT2002.UnitID as ConvertedUnitID, AT1304_01.UnitName as ConvertedUnitName 
								  , OT2002.ConvertedQuantity
								  , AT1302.UnitID as Vien
								  , OT2002.OrderQuantity as Vien_Quantity
								  , AT1309_M.UnitID  as Met
								  , AT1309_M.ConversionFactor as Met_Rate
								  , Case	  When AT1309_M.Operator = 0 then isnull(OT2002.Met_Quantity, OT2002.OrderQuantity / AT1309_M.ConversionFactor)
											  When AT1309_M.Operator = 1 then isnull(OT2002.Met_Quantity,OT2002.OrderQuantity * AT1309_M.ConversionFactor)
											  When Isnull(AT1309_M.Operator, '''') = '''' then isnull(OT2002.Met_Quantity,0)
											  end as Met_Quantity
								  , AT1309_H.UnitID as Hop
								  , AT1309_H.ConversionFactor as Hop_Rate
								  , Case	  When AT1309_H.Operator = 0 then isnull(OT2002.Hop_Quantity, OT2002.OrderQuantity / AT1309_H.ConversionFactor)
											  When AT1309_H.Operator = 1 then isnull(OT2002.Hop_Quantity,OT2002.OrderQuantity * AT1309_H.ConversionFactor)
											  When Isnull(AT1309_H.Operator, '''') = '''' then isnull(OT2002.Hop_Quantity,0)
											  end as Hop_Quantity
								  , AT1309_P.UnitID as Pallets
								  , AT1309_P.ConversionFactor as Pallets_Rate
								  , Case    When AT1309_P.Operator = 0 then isnull(OT2002.Pallets_Quantity , OT2002.OrderQuantity / AT1309_P.ConversionFactor)
											When AT1309_P.Operator = 1 then isnull(OT2002.Pallets_Quantity, OT2002.OrderQuantity * AT1309_P.ConversionFactor)
											When Isnull(AT1309_P.Operator, '''') = '''' then isnull(OT2002.Pallets_Quantity,0)
											end as Pallets_Quantity'
									
		SET @sSQL1 = @sSQL1 + '	LEFT JOIN A00003 on AT1302.InventoryID = A00003.InventoryID
						   LEFT JOIN AT1320 on AT1320.ExtraID= OT2002.ExtraID	and AT1320.DivisionID = OT2002.DivisionID and OT2002.InventoryID= AT1320.InventoryID
						   left join AT1309 AT1309_M on AT1309_M.InventoryID = OT2002.InventoryID and AT1309_M.UnitID = ''M2''
						   left join AT1309 AT1309_H on AT1309_H.InventoryID = OT2002.InventoryID and AT1309_H.UnitID = ''H''
						   left join AT1309 AT1309_P on AT1309_P.InventoryID = OT2002.InventoryID and AT1309_P.UnitID = ''P''	
						   LEFT JOIN AT1304 AT1304_01 WITH (NOLOCK) ON AT1304_01.UnitID = OT2002.UnitID
						   LEFT JOIN AT1015 AT1015_01 on AT1302.I01ID = AT1015_01.AnaID and AT1015_01.AnaTypeID = ''I01''
						   LEFT JOIN AT1015 AT1015_02 on AT1302.I02ID = AT1015_02.AnaID and AT1015_02.AnaTypeID = ''I02''
						   LEFT JOIN AT1015 AT1015_03 on AT1302.I03ID = AT1015_03.AnaID and AT1015_03.AnaTypeID = ''I03''
						   LEFT JOIN AT1015 AT1015_04 on AT1302.I04ID = AT1015_04.AnaID and AT1015_04.AnaTypeID = ''I04''
						   LEFT JOIN AT1015 AT1015_05 on AT1302.I05ID = AT1015_05.AnaID and AT1015_05.AnaTypeID = ''I05''
						   LEFT JOIN AT1015 AT1015_06 on AT1302.I06ID = AT1015_06.AnaID and AT1015_06.AnaTypeID = ''I06''
						   LEFT JOIN AT1015 AT1015_07 on AT1302.I07ID = AT1015_07.AnaID and AT1015_07.AnaTypeID = ''I07''
						   LEFT JOIN AT1015 AT1015_08 on AT1302.I08ID = AT1015_08.AnaID and AT1015_08.AnaTypeID = ''I08''
						   LEFT JOIN AT1015 AT1015_09 on AT1302.I09ID = AT1015_09.AnaID and AT1015_09.AnaTypeID = ''I09''
						   LEFT JOIN AT1015 AT1015_10 on AT1302.I10ID = AT1015_10.AnaID and AT1015_10.AnaTypeID = ''I10''
						   WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
	END
	ELSE
		SET @sSQL1 = @sSQL1 + '	WHERE	OT2001.DivisionID = N''' + @DivisionID + ''' AND OT2001.SOrderID = N''' + @SOrderID + ''''
END			

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='OV3014')
	EXEC ('CREATE VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)
ELSE
	EXEC( 'ALTER VIEW OV3014  ---TAO BOI OP3012
		AS '+@sSQL+@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

