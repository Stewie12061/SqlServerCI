IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0105_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0105_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- In báo cáo Phiếu yêu cầu nhập, xuất, vận chuyển nội bộ theo quy cách
----Edit by Mai Duyen, Date 12/09/2014: Bo sung them field AT1302.Notes01(KH Kingcom)
----Edit by Mai Duyen, Date 06/05/2015: Bo sung them field AT1302.BarCode(KH MANHPHUONG)
----Modified by Tiểu Mai on 25/12/2015: Bo sung thong tin quy cach hang hoa khi co thiet lap quan ly hang theo quy cach
----MOdified by Tiểu Mai on 07/01/2016: Bổ sung các cột của đơn hàng sx khi có thiết lập quản lý hàng theo quy cách.
----Modified by Tiểu Mai on 31/08/2016: Bổ sung các cột tham số NotesXX
----Modified by Tiểu Mai on 08/09/2016: Bổ sung các trường quy đổi cho AN PHÁT
----Modified by Tiểu Mai on 08/09/2016: Bổ sung các trường QuantityUnit
----Modified by Bảo Thy on 13/06/2017: bổ sung tham số
--- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
--- Modified on 14/04/2018 by Thị Phượng: Fix lỗi A03.WareHouseName -> A34.WareHouseName
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/*
    exec WP0105 @DivisionID=N'HCM',@UserID='ASSUPPORT',@VoucherID='c4ac45db-75db-4bf4-9e23-68221b7095e5',@Mode=3
*/

 CREATE PROCEDURE WP0105_QC
(
     @DivisionID NVARCHAR(2000),
     @UserID VARCHAR(50),
     @VoucherID VARCHAR(50),
     @Mode TINYINT  --: 1,5: Phiếu yêu cầu nhập, 2,4: Phiếu yêu cầu xuất, 3: Phiếu yêu cầu VCNB

)
AS
DECLARE @sSQL VARCHAR(MAX),
		@sSQL1 VARCHAR(MAX),
		@sWhere VARCHAR(MAX),
		@sSQL2 VARCHAR(MAX),
		@sSQL3 VARCHAR(MAX) = ''
		
SET @sWhere = ''		
IF @Mode = 3
SET @sWhere = 'W95.WareHouseID2 ExVoucherID, A34.WareHouseName ExVoucherName, W95.WareHouseID ImWareHouseID, A33.WareHouseName ImWareHouseName,'

IF @Mode IN (1,5)
SET @sWhere = ' W95.WareHouseID ImWareHouseID, A33.WareHouseName ImWareHouseName,'

IF @Mode IN (2,4)
SET @sWhere = ' W95.WareHouseID ExVoucherID, A33.WareHouseName ExVoucherName,'
SET @sSQL2 = ''

	SET @sSQL = '
	SELECT O01.SOrderID, O01.ObjectID as ObjectID_DHSX, A203.ObjectName as ObjectName_DHSX, O01.OrderDate, O01.InheritApportionID, O02.TotalProductQuantity, 
	W95.VoucherNo, W95.VoucherDate, '+@sWhere+' W95.[Description],
	W96.InventoryID, A32.InventoryName, W96.UnitID, W96.ConvertedUnitID, SUM(W96.ConvertedQuantity) ConvertedQuantity, SUM(W96.ActualQuantity) ActualQuantity,
	W96.UnitPrice, W96.ConvertedPrice, SUM(W96.ConvertedAmount) ConvertedAmount, SUM(W96.OriginalAmount) OriginalAmount,
	A32.Notes01, W95.ObjectID, A202.ObjectName,A32.BarCode,
	--M36.ProductQuantity, 
	M37.MaterialID, M37.MaterialTypeID, M37.MaterialQuantity, M37.MaterialUnitID, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
	M37.QuantityUnit, M37.RateDecimalApp, M37.QuantityUnit,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
	A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
	A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
	A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name,
	a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
	a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20,
	W95.ContactPerson, W95.RDAddress, 
	W96.Ana01ID, W96.Ana02ID, W96.Ana03ID, W96.Ana04ID, W96.Ana05ID, W96.Ana06ID, W96.Ana07ID, W96.Ana08ID, W96.Ana09ID, W96.Ana10ID,
	A21.AnaName as AnaName01, A22.AnaName as AnaName02, A23.AnaName as AnaName03, A24.AnaName as AnaName04, A25.AnaName as AnaName05, 
	A26.AnaName as AnaName06, A27.AnaName as AnaName07, A28.AnaName as AnaName08, A29.AnaName as AnaName09, A30.AnaName as AnaName10,
	ISNULL(W95.SParameter01,'''') SParameter01, ISNULL(W95.SParameter02,'''') SParameter02, ISNULL(W95.SParameter03,'''') SParameter03, 
	ISNULL(W95.SParameter04,'''') SParameter04, ISNULL(W95.SParameter05,'''') SParameter05, ISNULL(W95.SParameter06,'''') SParameter06, 
	ISNULL(W95.SParameter07,'''') SParameter07, ISNULL(W95.SParameter08,'''') SParameter08, ISNULL(W95.SParameter09,'''') SParameter09, 
	ISNULL(W95.SParameter10,'''') SParameter10, ISNULL(W95.SParameter11,'''') SParameter11, ISNULL(W95.SParameter12,'''') SParameter12, 
	ISNULL(W95.SParameter13,'''') SParameter13, ISNULL(W95.SParameter14,'''') SParameter14, ISNULL(W95.SParameter15,'''') SParameter15, 
	ISNULL(W95.SParameter16,'''') SParameter16, ISNULL(W95.SParameter17,'''') SParameter17, ISNULL(W95.SParameter18,'''') SParameter18, 
	ISNULL(W95.SParameter19,'''') SParameter19, ISNULL(W95.SParameter20,'''') SParameter20,
	W96.Notes01 WNotes01, W96.Notes02 WNotes02, W96.Notes03 WNotes03, W96.Notes04 WNotes04,
	W96.Notes05 WNotes05, W96.Notes06 WNotes06, W96.Notes07 WNotes07, W96.Notes08 WNotes08,	W96.Notes09 WNotes09,
	W96.Notes10 WNotes10, W96.Notes11 WNotes11, W96.Notes12 WNotes12, W96.Notes13 WNotes13, W96.Notes14 WNotes14,
	W96.Notes15 WNotes15, A32.InventoryTypeID, A31.InventoryTypeName, W96.Notes, A32.S1, A32.S2, A32.S3,
	A35.SName SName1, A36.SName SName2, A37.SName SName3 '
	SET @sSQL1 = '
	FROM WT0095 W95 WITH (NOLOCK)
	LEFT JOIN AT1202 A202 WITH (NOLOCK) ON A202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A202.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
	LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = W96.DivisionID AND O01.SOrderID = W96.OrderID
	LEFT JOIN AT1202 A203 WITH (NOLOCK) ON A203.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A203.ObjectID = O01.ObjectID
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', W96.DivisionID) AND A32.InventoryID = W96.InventoryID
	LEFT JOIN AT1301 A31 WITH (NOLOCK) ON A32.InventoryTypeID = A31.InventoryTypeID
	LEFT JOIN AT1310 A35 WITH (NOLOCK) ON A32.S1 = A35.S AND A35.STypeID  = ''I01''
	LEFT JOIN AT1310 A36 WITH (NOLOCK) ON A32.S2 = A36.S AND A36.STypeID  = ''I02''
	LEFT JOIN AT1310 A37 WITH (NOLOCK) ON A32.S3 = A37.S AND A37.STypeID  = ''I03''
	LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A33.WareHouseID = W95.WareHouseID
	LEFT JOIN AT1303 A34 WITH (NOLOCK) ON A34.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A34.WareHouseID = W95.WareHouseID2
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = W96.DivisionID AND O99.VoucherID = W96.VoucherID AND O99.TransactionID  = W96.TransactionID and O99.TableID  = ''WT0096''
	LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = O99.DivisionID
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON O99.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON O99.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON O99.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON O99.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON O99.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON O99.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON O99.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON O99.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON O99.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON O99.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON O99.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON O99.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON O99.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON O99.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON O99.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON O99.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON O99.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON O99.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON O99.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON O99.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	'
	
	SET @sSQL2 = '
	LEFT JOIN MT0137 M37 WITH (NOLOCK) ON W96.DivisionID = M37.DivisionID AND M37.TransactionID = W96.OTransactionID AND M37.ExpenseID = ''COST001'' AND M37.MaterialID = W96.InventoryID AND
							Isnull(M37.DS01ID,'''') = Isnull(O99.S01ID, '''') AND Isnull(M37.DS02ID, '''') = Isnull(O99.S02ID, '''') AND
							Isnull(M37.DS03ID,'''') = Isnull(O99.S03ID, '''') AND Isnull(M37.DS04ID, '''') = Isnull(O99.S04ID, '''') AND
							Isnull(M37.DS05ID,'''') = Isnull(O99.S05ID, '''') AND Isnull(M37.DS06ID, '''') = Isnull(O99.S06ID, '''') AND
							Isnull(M37.DS07ID,'''') = Isnull(O99.S07ID, '''') AND Isnull(M37.DS08ID, '''') = Isnull(O99.S08ID, '''') AND
							Isnull(M37.DS09ID,'''') = Isnull(O99.S09ID, '''') AND Isnull(M37.DS10ID, '''') = Isnull(O99.S10ID, '''') AND
							Isnull(M37.DS11ID,'''') = Isnull(O99.S11ID, '''') AND Isnull(M37.DS12ID, '''') = Isnull(O99.S12ID, '''') AND
							Isnull(M37.DS13ID,'''') = Isnull(O99.S13ID, '''') AND Isnull(M37.DS14ID, '''') = Isnull(O99.S14ID, '''') AND
							Isnull(M37.DS15ID,'''') = Isnull(O99.S15ID, '''') AND Isnull(M37.DS16ID, '''') = Isnull(O99.S16ID, '''') AND
							Isnull(M37.DS17ID,'''') = Isnull(O99.S17ID, '''') AND Isnull(M37.DS18ID, '''') = Isnull(O99.S18ID, '''') AND
							Isnull(M37.DS19ID,'''') = Isnull(O99.S19ID, '''') AND Isnull(M37.DS20ID, '''') = Isnull(O99.S20ID, '''') 				
	--LEFT JOIN MT0136 M36 WITH (NOLOCK) ON M36.DivisionID = O01.DivisionID AND M36.ApportionID = O01.InheritApportionID
	LEFT JOIN AT1011 A21 WITH (NOLOCK) ON A21.AnaID = W96.Ana01ID AND A21.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A22 WITH (NOLOCK) ON A22.AnaID = W96.Ana02ID AND A21.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A23 WITH (NOLOCK) ON A23.AnaID = W96.Ana03ID AND A21.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A24 WITH (NOLOCK) ON A24.AnaID = W96.Ana04ID AND A21.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A25 WITH (NOLOCK) ON A25.AnaID = W96.Ana05ID AND A21.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A26 WITH (NOLOCK) ON A26.AnaID = W96.Ana06ID AND A21.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A27 WITH (NOLOCK) ON A27.AnaID = W96.Ana07ID AND A21.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A28 WITH (NOLOCK) ON A28.AnaID = W96.Ana08ID AND A21.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A29 WITH (NOLOCK) ON A29.AnaID = W96.Ana09ID AND A21.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A30 WITH (NOLOCK) ON A30.AnaID = W96.Ana10ID AND A21.AnaTypeID = ''A10''
	LEFT JOIN (SELECT SOrderID, SUM(OrderQuantity) AS TotalProductQuantity FROM OT2002 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+'''
				GROUP BY SOrderID) O02 ON O01.SOrderID = O02.SOrderID'
	
	SET @sSQL3 = '
	WHERE W95.DivisionID = '''+@DivisionID+'''
	AND W95.VoucherID = '''+@VoucherID+''' 
	GROUP BY O01.SOrderID, O01.ObjectID, A203.ObjectName, O01.OrderDate, O01.InheritApportionID, O02.TotalProductQuantity, W95.VoucherNo, W95.VoucherDate, 
		W95.WareHouseID2, A34.WareHouseName, W95.WareHouseID,
		A33.WareHouseName, W95.[Description], W96.InventoryID, A32.InventoryName, W96.UnitID, W96.ConvertedUnitID,
		W96.UnitPrice, W96.ConvertedPrice, A32.Notes01, W95.ObjectID, A202.ObjectName ,A32.Barcode,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, A05.StandardName,
		A06.StandardName, A07.StandardName, A08.StandardName, A09.StandardName, A10.StandardName,
		A11.StandardName, A12.StandardName, A13.StandardName, A14.StandardName, A15.StandardName,
		A16.StandardName, A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName,
		--M36.ProductQuantity, 
		M37.MaterialID, M37.MaterialTypeID, M37.MaterialQuantity, M37.MaterialUnitID, M37.MaterialPrice, M37.MaterialAmount, M37.MaterialGroupID, 
		M37.QuantityUnit, M37.RateDecimalApp, M37.QuantityUnit,
		a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
		a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20,
		W95.ContactPerson, W95.RDAddress, 
		W96.Ana01ID, W96.Ana02ID, W96.Ana03ID, W96.Ana04ID, W96.Ana05ID, W96.Ana06ID, W96.Ana07ID, W96.Ana08ID, W96.Ana09ID, W96.Ana10ID,
		A21.AnaName, A22.AnaName, A23.AnaName, A24.AnaName, A25.AnaName, A26.AnaName, A27.AnaName, A28.AnaName, A29.AnaName, A30.AnaName,
		ISNULL(W95.SParameter01,''''), ISNULL(W95.SParameter02,''''), ISNULL(W95.SParameter03,''''), ISNULL(W95.SParameter04,''''), ISNULL(W95.SParameter05,''''), 
		ISNULL(W95.SParameter06,''''), ISNULL(W95.SParameter07,''''), ISNULL(W95.SParameter08,''''), ISNULL(W95.SParameter09,''''), ISNULL(W95.SParameter10,''''), 
		ISNULL(W95.SParameter11,''''), ISNULL(W95.SParameter12,''''), ISNULL(W95.SParameter13,''''), ISNULL(W95.SParameter14,''''), ISNULL(W95.SParameter15,''''), 
		ISNULL(W95.SParameter16,''''), ISNULL(W95.SParameter17,''''), ISNULL(W95.SParameter18,''''), ISNULL(W95.SParameter19,''''), ISNULL(W95.SParameter20,''''),
		W96.Notes01, W96.Notes02, W96.Notes03, W96.Notes04, W96.Notes05,
		W96.Notes06, W96.Notes07, W96.Notes08, W96.Notes09, W96.Notes10,
		W96.Notes11, W96.Notes12, W96.Notes13, W96.Notes14, W96.Notes15, A32.InventoryTypeID, A31.InventoryTypeName, W96.Notes, A32.S1, A32.S2, A32.S3,
		A35.SName, A36.SName, A37.SName '

EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
