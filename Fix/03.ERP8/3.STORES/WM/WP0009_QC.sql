IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0009_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0009_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load edit/view cho các phiếu Nhập, xuất, VCNB theo quy cách
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Bảo Anh on Date: 02/10/2013
---- Modified by Thanh Sơn on 19/06/2015: Bổ sung 20 quy cách hàng
---- Modified by Quốc Tuấn on 07/08/2015: Bổ sung thêm RefVoucherNo cho khách hàng Secoin
---- Modified by Phương Thảo on 15/10/2015: Bổ sung thêm IsVAT
---- Modified by Kim Vũ on 21/10/2015: Bổ sung 20 columns Parameter cho khách hàng SGPT
---- Modified by Tiểu Mai on 28/10/2015: Bổ sung điều kiện left join WT8899
---- Modified by Tieu Mai on 07/12/2015: Bo sung cac truong ma phan tich mat hang, fax, BankAccountID
---- Modify on 18/01/2016: Bổ sung các trường mã vạch thùng, số lượng thùng (Angel)
---- Modified by Phương Thảo on 18/05/2016 : Cải tiến tốc độ (1 phần)
---- Modified by Tiểu Mai on 27/05/2016: Fix ko lấy được ConvertUnitID
---- Modified by Tiểu Mai on 17/08/2016: Fix cho AN PHÁT lên sai dữ liệu do dùng ĐVT chuyển đổi theo quy cách
---- Modified by Tiểu Mai on 16/09/2016: Bổ sung trường AT2007.SOrderIDRecognition
---- Modified by Tiểu Mai on 08/11/2016: Bổ sung Số chứng từ, ngày chứng từ của Phiếu yêu cầu
---- Modified by Bảo Thy on 24/03/2017: Trả ra thông tin IsExMaterial kiểm tra phiếu xuất thành phẩm đã được xuất NVL chưa (TUNGTEX)
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Phương Thảo on 16/08/2017: Bổ sung IsReturn: Phiếu nhập trả
---- Modified by Hải Long on 05/09/2017: Bổ sung IsDelivery (Bê Tông Long An)
---- Modified by Phương Thảo on 16/10/2017: Bổ sung đơn giá ĐH bán: SOUnitPrice (Đông Dương)
---- Modified by Bảo Anh on 03/04/2018: Bổ sung trường SL yêu cầu RequireQuantity
---- Modified by Bảo Thy on 06/04/2018: fix lỗi tính ActEndQty
---- Modified by Kiều Nga on 27/04/2020: Fix lỗi cho sửa số lượng xuất kho nhiều hơn số lượng kế thừa từ Yêu cầu xuất kho (customer MaiThu)
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Thanh Lượng on 26/10/2023: [2023/10/TA/0218] - Bổ sung trường MVoucherdate + ProductionOrder (Customize NKC).
---- Modified by Thanh Lượng on 09/11/2023: [2023/11/TA/0047] - Bổ sung thêm trường SerialNo(AT2007).
-- <Example>
/*
	WP0009 'TL','ARTL201200000637'
*/

CREATE PROCEDURE [DBO].[WP0009_QC]
(
    @DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL0 NVARCHAR(MAX),
		@sSQL00 NVARCHAR(MAX),
	    @sSQL1 NVARCHAR(MAX),
	    @sSQL2 NVARCHAR(MAX) = '',
	    @sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
	    @sFrom NVARCHAR(500) = '',
	    @TranMonth INT = 0,
		@TranYear INT = 0,
		@WareHouseID NVARCHAR(50) = '',
		@CustomerName INT = -1
		
CREATE TABLE #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 29 --- Customer TBIV
BEGIN
	SET @sSQL2 = ', ISNULL(A00.UnitPrice, 0) TUnitPrice, ISNULL(A00.OriginalAmount, 0) TOriginalAmount'
	SET @sFrom = 'LEFT JOIN AT9000 A00 ON A00.DivisionID = A07.DivisionID AND A00.VoucherID = A07.VoucherID 
						AND A00.TransactionID = A07.TransactionID AND A00.TableID = ''AT9000'' AND A00.TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')'
END

IF @CustomerName = 57 --- Customer Angel
BEGIN
	SET @sSQL2 = ', A07.KITID, A07.KITQuantity, AT1326.InventoryQuantity, A06.IsProduct'
	SET @sFrom = 'LEFT JOIN AT1326 On AT1326.KITID = A07.KITID And AT1326.InventoryID = A07.InventoryID'
END

IF @CustomerName in (73,76) --- Chí Thành
BEGIN
	SET @sSQL2 = ', OT2002.OrderQuantity as SOQuantity, OT2002.SalePrice as SOUnitPrice'
	SET @sFrom = 'LEFT JOIN OT2002 WITH (NOLOCK) ON A07.DivisionID = OT2002.DivisionID And A07.OTransactionID = OT2002.TransactionID'
END

IF @CustomerName = 166 --- NEMKIMCUONG
BEGIN
	SET @sSQL2 = ',  CONVERT(varchar,MT0810.VoucherDate,101) as MVoucherDate, MT2211.ProductionOrder'
	SET @sFrom = 'LEFT JOIN MT0810 WITH (NOLOCK) ON A07.DivisionID = MT0810.DivisionID And MT0810.VoucherID = (SELECT TOP 1 VoucherID FROM MT1001 where MT1001.TransactionID = A07.MTransactionID)
				  LEFT JOIN MT2211 WITH (NOLOCK) ON A07.DivisionID = MT2211.DivisionID And  MT2211.APK = (SELECT TOP 1 InheritTransactionID FROM MT1001 where MT1001.TransactionID = A07.MTransactionID)				  
	'
END		
SELECT @TranMonth = TranMonth, @TranYear = TranYear, @WareHouseID = (CASE WHEN KindVoucherID = 3 THEN WareHouseID2 ELSE WareHouseID END)
FROM AT2006
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

SET @ssQL = '
SELECT A06.ReDeTypeID, A06.VoucherTypeID, A06.VoucherNo, A06.IsGoodsFirstVoucher, A06.IsGoodsRecycled,
	A06.VoucherDate, A06.RefNo01, A06.RefNo02, A06.KindVoucherID, A06.RDAddress, A06.ContactPerson,
	A06.InventoryTypeID, A06.ObjectID,
	A06.CarID,A06.DriverID,
	A07.ProductionOrder as ProductionOrderM,A07.ImVoucherDate,A07.SeriNo,
	-- A02.ObjectName, 
	Convert(Nvarchar(250),'''') AS ObjectName,
	
	A06.VATObjectName,
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A06.WareHouseID ELSE '''' END) ImWareHouseID,
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A03.WareHouseName ELSE '''' END) ImWareHouseName,

	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A06.WareHouseID ELSE CASE WHEN A06.KindVoucherID = 3 THEN A06.WareHouseID2 ELSE '''' END END) ExWareHouseID,
	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A03.WareHouseName ELSE CASE WHEN A06.KindVoucherID = 3 THEN A031.WareHouseName ELSE '''' END END) ExWareHouseName,
	
	A06.EmployeeID,A1103.FullName EmployeeName,A07.TransactionID, A06.VoucherID, A07.InventoryID, 
	-- A12.InventoryName, 
	Convert(Nvarchar(250),'''') AS InventoryName,
	A07.UnitID, A04.UnitName,
	A07.ActualQuantity, A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A06.[Description], A06.TranMonth,
	A06.TranYear, A06.DivisionID, A07.SaleUnitPrice, A07.SaleAmount, A07.DiscountAmount, A07.SourceNo,	
	A07.DebitAccountID, A07.CreditAccountID, DA.GroupID DebitGroupID, CA.GroupID CreditGroupID,			
	A07.LocationID, A07.ImLocationID, A07.Ana01ID, A_01.AnaName Ana01Name,
	A07.Ana02ID, A_02.AnaName Ana02Name, A07.Ana03ID, A_03.AnaName Ana03Name, A07.Ana04ID, A_04.AnaName Ana04Name,
	A07.Ana05ID, A_05.AnaName Ana05Name, A07.Ana06ID, A_06.AnaName Ana06Name, A07.Ana07ID, A_07.AnaName Ana07Name,
	A07.Ana08ID, A_08.AnaName Ana08Name, A07.Ana09ID, A_09.AnaName Ana09Name, A07.Ana10ID, A_10.AnaName Ana10Name,
	A06.IsInheritWarranty, A06.EVoucherID, A07.WVoucherID, A06.IsVoucher,
	A07.Orders, A07.LimitDate, A07.Notes, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID,
	A07.ConversionFactor, A07.ReVoucherID, A07.ReTransactionID, A07.ReVoucherID ReOldVoucherID,A07.ReTransactionID ReOldTransactionID,
	A07.ActualQuantity OldQuantity, A07.CreditAccountID OldCreditAccountID, A07.MarkQuantity OldMarkQuantity,
	A24.OrderNo, A07.OrderID, A07.OTransactionID, A07.MOrderID, A07.SOrderID, A07.MTransactionID, A07.STransactionID,
	-- A12.IsSource, A12.IsLimitDate, A12.IsLocation, A12.MethodID, 
	-- V06.VoucherNo ReVoucherNo, 
	Convert(Varchar(50),'''') AS ReVoucherNo,
	--(SELECT TOP 1 VoucherNo FROM AT2006 t1 inner join AT2007 t2 on t1.DivisionID = t2.DivisionID and t1.VoucherID = t2.VoucherID WHERE A07.ReVoucherID = t2.VoucherID and A07.ReTransactionID = t2.TransactionID) AS ReVoucherNo,
	--A12.AccountID,
	-- A12.Specification, A12.S1, A12.S2, A12.S3, A12.Notes01, A12.Notes02, A12.Notes03, A12.Barcode,
	-------------//
	Convert(Tinyint,0) AS IsSource, Convert(Tinyint,0) AS IsLimitDate, Convert(Tinyint,0) AS IsLocation, Convert(Tinyint,0) AS MethodID,
	Convert(Varchar(50),'''') AS AccountID,
	Convert(Nvarchar(250),'''') AS Specification, Convert(Varchar(50),'''') AS S1, Convert(Varchar(50),'''') AS S2, Convert(Varchar(50),'''') AS S3,
	Convert(Nvarchar(250),'''') AS Notes01, Convert(Nvarchar(250),'''') AS Notes02, Convert(Nvarchar(250),'''') AS Notes03,
	Convert(Varchar(50),'''') AS Barcode,
	--A02.[Address], A02.VATNo, A02.Tel, A02.Contactor,
	Convert(Nvarchar(250),'''') AS Address, Convert(Varchar(50),'''') AS VATNo,
	convert(nvarchar(100),'''') As Tel, Convert(Nvarchar(250),'''') AS Contactor,
'
SET @sSQL0 = '
	---- Phuc vu bao cao  DVT qui doi  cho cac khach hang dung version cu truoc 7.1
	A07.PeriodID, A09.UnitID ConversionUnitID, A09.ConversionFactor ConversionFactor2, A09.Operator,
	M01.[Description] PeriodName, A07.ProductID, 
	-- A13.InventoryName ProductName,
	Convert(Nvarchar(250),'''') AS ProductName,
	(SELECT TOP 1 ISNULL(ExpenseConvertedAmount, 0) FROM AT9000 WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID 
	 AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) ExpenseConvertedAmount,
	(SELECT TOP 1 ISNULL(DiscountAmount, 0) FROM AT9000 WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID
	AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) DiscountAmount2,
	(SELECT TOP 1 InvoiceDate FROM AT9000 WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID
	AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) InvoiceDate,
	
	--(SELECT EndQuantity FROM AT2008 WHERE DivisionID = ''' + @DivisionID + ''' AND InventoryID = A07.InventoryID
	--AND InventoryAccountID = A12.AccountID AND TranMonth + 100 * TranYear = ' + LTRIM(@TranMonth + 100 * @TranYear) + '
	--AND WarehouseID = ''' + @WarehouseID + ''') ActEndQty, 
	Convert(Decimal(28,8),0) AS ActEndQty,
	
	A07.ETransactionID, O03.EstimateID,
	----- Cac thong tin lien quan den DVT qui doi  cho 
	A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedQuantity,
	A07.ConvertedPrice, 
	
	ISNULL(A07.ConvertedUnitID, '''') ConvertedUnitID, 
	
	ISNULL(T04.UnitName, A04.UnitName) ConvertedUnitName,
	ISNULL(T09.Operator, 0) T09Operator, ISNULL(T09.ConversionFactor,1) T09ConversionFactor, ISNULL(T09.DataType, 0) DataType,
	T09.FormulaID, A19.FormulaDes, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID,
	----- SL mark (yeu cau cua 2T)
	A07.MarkQuantity, A07.Notes TDescription,
	----- CP khac	(yeu cau cua 2T)
	A07.OExpenseConvertedAmount, A07.Notes01 WNotes01, A07.Notes02 WNotes02, A07.Notes03 WNotes03, A07.Notes04 WNotes04, A07.Notes05 WNotes05,
	A07.Notes06 WNotes06, A07.Notes07 WNotes07, A07.Notes08 WNotes08, A07.Notes09 WNotes09, A07.Notes10 WNotes10,
	A07.Notes11 WNotes11, A07.Notes12 WNotes12, A07.Notes13 WNotes13, A07.Notes14 WNotes14, A07.Notes15 WNotes15, A06.CreateUserID,
	DA.IsObject DIsObject, CA.IsObject CIsObject, A07.StandardPrice, A07.StandardAmount, A06.ImVoucherID, A07.RefInfor,'

SET @sSQL00 = '
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
	AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
	AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
	AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
	MT27.VoucherNo RefVoucherNo, 
	CAST(0 AS BIT) AS IsVAT, 	
	A06.SParameter01 as Parameter01_A06, A06.SParameter02 as Parameter02_A06, A06.SParameter03 as Parameter03_A06,
	A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, 
	A06.SParameter08, A06.SParameter09, A06.SParameter10, A06.SParameter11,
	A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15,
	A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, 
	A06.SParameter20, 
	A06.IsReturn,
	A06.IsDelivery,
	--A02.BankAccountNo, A02.Fax, 
	convert(nvarchar(50),'''') AS BankAccountNo, convert(nvarchar(100),'''') AS Fax,
	--A12.I01ID, A12.I02ID, A12.I03ID, A12.I04ID, A12.I05ID,
	--B01.AnaName as AnaNameI01, B02.AnaName as AnaNameI02, B03.AnaName as AnaNameI03, B04.AnaName as AnaNameI04, B05.AnaName as AnaNameI05
	convert(nvarchar(50),'''') AS I01ID, convert(nvarchar(50),'''') AS I02ID, convert(nvarchar(50),'''') AS I03ID, convert(nvarchar(50),'''') AS I04ID, convert(nvarchar(50),'''') AS I05ID,
	convert(nvarchar(250),'''') AS AnaNameI01, convert(nvarchar(250),'''') AS AnaNameI02, convert(nvarchar(250),'''') AS AnaNameI03, convert(nvarchar(250),'''') AS AnaNameI04, convert(nvarchar(250),'''') AS AnaNameI05,
	A07.SOrderIDRecognition, W95.VoucherNo AS LCP_VoucherNo, W95.VoucherDate AS LCP_VoucherDate, W96.ActualQuantity AS RequireQuantity, 
	CASE WHEN ISNULL((SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK)
					 WHERE DivisionID = '''+@DivisionID+''' AND InheritVoucherID = '''+@VoucherID+''' AND InheritTableID = ''AT2007''),0) =1
		 THEN 1 ELSE 0 END AS IsExMaterial
	,ISNULL(W96.ReceiveQuantity,0)  - ISNULL(A07.ActualQuantity,0) as ReceiveQuantity,ISNULL(W96.ActualQuantity,0) as InheritQuantity,W95.VoucherNo as InheritVoucherNo, A07.SerialNo
	
'+@sSQL2+' '

SET @sSQL1 = '
INTO #WP0009
FROM AT2006 A06 WITH (NOLOCK)
LEFT JOIN AT2004 A24 WITH (NOLOCK) ON A24.DivisionID = A06.DivisionID AND A24.OrderID = A06.OrderID
LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = A06.DivisionID AND A07.VoucherID = A06.VoucherID
LEFT JOIN WT0096 W96 WITH (NOLOCK) ON A07.DivisionID = W96.DivisionID AND A07.InheritVoucherID = W96.VoucherID AND A07.InheritTransactionID = W96.TransactionID AND A07.InheritTableID = ''WT0095''
LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.DivisionID = W96.DivisionID AND W95.VoucherID = W96.VoucherID
LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = ISNULL(A07.ConvertedUnitID,'''')
LEFT JOIN OT2203 O03 WITH (NOLOCK) ON O03.DivisionID = A07.DivisionID AND O03.TransactionID = A07.ETransactionID
LEFT JOIN MT1601 M01 WITH (NOLOCK) ON M01.DivisionID = A07.DivisionID AND M01.PeriodID = A07.PeriodID
--LEFT JOIN AV2006 V06 WITH (NOLOCK) ON V06.DivisionID = A07.DivisionID AND V06.VoucherID = A07.ReVoucherID AND V06.TransactionID = A07.ReTransactionID
LEFT JOIN
	(
		SELECT InventoryID, MIN(UnitID) UnitID, MIN(ConversionFactor)ConversionFactor, MIN(Operator) Operator, DivisionID
        FROM AT1309 WITH (NOLOCK)
		GROUP BY InventoryID, DivisionID
	) A09 
ON A09.InventoryID = A07.InventoryID --- Phuc vu bao cao nen chua bo oin nay duoc
LEFT JOIN AT1011 A_01 WITH (NOLOCK) ON A_01.AnaID = A07.Ana01ID AND A_01.AnaTypeID = ''A01''
LEFT JOIN AT1011 A_02 WITH (NOLOCK) ON A_02.AnaID = A07.Ana02ID AND A_02.AnaTypeID = ''A02''
LEFT JOIN AT1011 A_03 WITH (NOLOCK) ON A_03.AnaID = A07.Ana03ID AND A_03.AnaTypeID = ''A03''
LEFT JOIN AT1011 A_04 WITH (NOLOCK) ON A_04.AnaID = A07.Ana04ID AND A_04.AnaTypeID = ''A04''
LEFT JOIN AT1011 A_05 WITH (NOLOCK) ON A_05.AnaID = A07.Ana05ID AND A_05.AnaTypeID = ''A05''
LEFT JOIN AT1011 A_06 WITH (NOLOCK) ON A_06.AnaID = A07.Ana06ID AND A_06.AnaTypeID = ''A06''
LEFT JOIN AT1011 A_07 WITH (NOLOCK) ON A_07.AnaID = A07.Ana07ID AND A_07.AnaTypeID = ''A07''
LEFT JOIN AT1011 A_08 WITH (NOLOCK) ON A_08.AnaID = A07.Ana08ID AND A_08.AnaTypeID = ''A08''
LEFT JOIN AT1011 A_09 WITH (NOLOCK) ON A_09.AnaID = A07.Ana09ID AND A_09.AnaTypeID = ''A09''
LEFT JOIN AT1011 A_10 WITH (NOLOCK) ON A_10.AnaID = A07.Ana10ID AND A_10.AnaTypeID = ''A10''
LEFT JOIN AT1005 DA	WITH (NOLOCK) ON DA.AccountID = A07.DebitAccountID
LEFT JOIN AT1005 CA	WITH (NOLOCK) ON CA.AccountID = A07.CreditAccountID
LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A07.UnitID
--LEFT JOIN AT1302 A12 WITH (NOLOCK) ON A12.DivisionID = A07.DivisionID AND A12.InventoryID = A07.InventoryID
--LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = A07.DivisionID AND A13.InventoryID = A07.ProductID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A03.WareHouseID = A06.WareHouseID
LEFT JOIN AT1303 A031 WITH (NOLOCK) ON A031.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A031.WareHouseID = A06.WareHouseID2
--LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A06.ObjectID
LEFT JOIN AT1103 A1103 WITH (NOLOCK) ON A1103.EmployeeID = A06.EmployeeID
'

SET @sSQL3 = '
LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A07.DivisionID AND O99.VoucherID = A07.VoucherID AND O99.TransactionID = A07.TransactionID
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
LEFT JOIN MT2007 MT27 WITH (NOLOCK) ON MT27.DivisionID = A07.DivisionID AND MT27.VoucherID =A07.InheritVoucherID
LEFT JOIN AT1309 T09 WITH (NOLOCK) ON T09.InventoryID = A07.InventoryID AND A07.ConvertedUnitID = T09.UnitID
	AND Isnull(T09.S01ID,'''') = Isnull(O99.S01ID,'''')
	AND Isnull(T09.S02ID,'''') = Isnull(O99.S02ID,'''')
	AND Isnull(T09.S03ID,'''') = Isnull(O99.S03ID,'''')
	AND Isnull(T09.S04ID,'''') = Isnull(O99.S04ID,'''') 
	AND Isnull(T09.S05ID,'''') = Isnull(O99.S05ID,'''')
	AND Isnull(T09.S06ID,'''') = Isnull(O99.S06ID,'''')
	AND Isnull(T09.S07ID,'''') = Isnull(O99.S07ID,'''')
	AND Isnull(T09.S08ID,'''') = Isnull(O99.S08ID,'''')
	AND Isnull(T09.S09ID,'''') = Isnull(O99.S09ID,'''')
	AND Isnull(T09.S10ID,'''') = Isnull(O99.S10ID,'''')
	AND Isnull(T09.S11ID,'''') = Isnull(O99.S11ID,'''')
	AND Isnull(T09.S12ID,'''') = Isnull(O99.S12ID,'''')
	AND Isnull(T09.S13ID,'''') = Isnull(O99.S13ID,'''')
	AND Isnull(T09.S14ID,'''') = Isnull(O99.S14ID,'''') 
	AND Isnull(T09.S15ID,'''') = Isnull(O99.S15ID,'''')
	AND Isnull(T09.S16ID,'''') = Isnull(O99.S16ID,'''')
	AND Isnull(T09.S17ID,'''') = Isnull(O99.S17ID,'''')
	AND Isnull(T09.S18ID,'''') = Isnull(O99.S18ID,'''')
	AND Isnull(T09.S19ID,'''') = Isnull(O99.S19ID,'''')
	AND Isnull(T09.S20ID,'''') = Isnull(O99.S20ID,'''')
LEFT JOIN AT1319 A19 WITH (NOLOCK) ON ISNULL(T09.FormulaID,'''') = A19.FormulaID
'+@sFrom+'
WHERE A06.DivisionID = '''+@DivisionID+'''
AND A06.VoucherID = '''+@VoucherID+''' 
'

SET @sSQL4 = '
	UPDATE #WP0009
	SET		ISVAT = 1
	WHERE  EXISTS (SELECT Top 1 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+'''
														  AND VoucherID = '''+@VoucherID+'''
														  AND TransactionTypeID = ''T14'')
	
	Update t1
	set	t1.InventoryName = t2.InventoryName,
		t1.I01ID = t2.I01ID,
		t1.I02ID = t2.I02ID,
		t1.I03ID = t2.I03ID,
		t1.I04ID = t2.I04ID,
		t1.I05ID = t2.I05ID,
		t1.IsSource = t2.IsSource,
		t1.IsLimitDate = t2.IsLimitDate,
		t1.IsLocation = t2.IsLocation,
		t1.MethodID = t2.MethodID,
		t1.AccountID = t2.AccountID,
		t1.Specification = t2.Specification,
		t1.S1 = t2.S1, t1.S2 = t2.S2, t1.S3 = t2.S3,
		t1.Notes01 = t2.Notes01, t1.Notes02 = t2.Notes02, t1.Notes03 = t2.Notes03,
		t1.Barcode = t2.Barcode,
		t1.ConvertedUnitID = ISNULL(T1.ConvertedUnitID,t2.UnitID)
	from #WP0009 t1
	inner join AT1302 t2 WITH (NOLOCK) ON t2.DivisionID IN (''@@@'', t1.DivisionID) AND t1.InventoryID = t2.InventoryID

	Update t1
	set	t1.ProductName = t2.InventoryName
	from #WP0009 t1
	inner join AT1302 t2 WITH (NOLOCK) ON t2.DivisionID IN (''@@@'', t1.DivisionID) AND t1.ProductID = t2.InventoryID


	Update t1
	set	t1.ObjectName = t2.ObjectName,
		t1.Address = t2.[Address], 
		t1.VATNo = t2.VATNo, 
		t1.Tel = t2.Tel, 
		t1.Contactor = t2.Contactor,
		t1.BankAccountNo = t2.BankAccountNo, 
		t1.Fax = t2.Fax 
	from #WP0009 t1
	inner join AT1202 t2 WITH (NOLOCK) ON t2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND t1.ObjectID = t2.ObjectID

	Update A12
	set	A12.AnaNameI01 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I01ID AND B01.AnaTypeID = ''I01''

	Update A12
	set	A12.AnaNameI02 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I02ID AND B01.AnaTypeID = ''I02''

	Update A12
	set	A12.AnaNameI03 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I03ID AND B01.AnaTypeID = ''I03''

	Update A12
	set	A12.AnaNameI04 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I04ID AND B01.AnaTypeID = ''I04''

	Update A12
	set	A12.AnaNameI05 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I05ID AND B01.AnaTypeID = ''I05''

	UPDATE T1
	SET		T1.ActEndQty = T2.EndQuantity
	FROM  #WP0009 T1
	INNER JOIN AT2008_QC T2 WITH (NOLOCK) ON t1.DivisionID = t2.DivisionID AND t1.InventoryID = t2.InventoryID
	AND Isnull(T1.S01ID,'''') = Isnull(T2.S01ID,'''')
	AND Isnull(T1.S02ID,'''') = Isnull(T2.S02ID,'''')
	AND Isnull(T1.S03ID,'''') = Isnull(T2.S03ID,'''')
	AND Isnull(T1.S04ID,'''') = Isnull(T2.S04ID,'''')
	AND Isnull(T1.S05ID,'''') = Isnull(T2.S05ID,'''')
	AND Isnull(T1.S06ID,'''') = Isnull(T2.S06ID,'''')
	AND Isnull(T1.S07ID,'''') = Isnull(T2.S07ID,'''')
	AND Isnull(T1.S08ID,'''') = Isnull(T2.S08ID,'''')
	AND Isnull(T1.S09ID,'''') = Isnull(T2.S09ID,'''')
	AND Isnull(T1.S10ID,'''') = Isnull(T2.S10ID,'''')
	AND Isnull(T1.S11ID,'''') = Isnull(T2.S11ID,'''')
	AND Isnull(T1.S12ID,'''') = Isnull(T2.S12ID,'''')
	AND Isnull(T1.S13ID,'''') = Isnull(T2.S13ID,'''')
	AND Isnull(T1.S14ID,'''') = Isnull(T2.S14ID,'''')
	AND Isnull(T1.S15ID,'''') = Isnull(T2.S15ID,'''')
	AND Isnull(T1.S16ID,'''') = Isnull(T2.S16ID,'''')
	AND Isnull(T1.S17ID,'''') = Isnull(T2.S17ID,'''')
	AND Isnull(T1.S18ID,'''') = Isnull(T2.S18ID,'''')
	AND Isnull(T1.S19ID,'''') = Isnull(T2.S19ID,'''')
	AND Isnull(T1.S20ID,'''') = Isnull(T2.S20ID,'''')
	INNER JOIN AT1302 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T2.InventoryAccountID = T3.AccountID
	WHERE  T2.DivisionID = ''' + @DivisionID + ''' AND T2.WarehouseID = ''' + @WarehouseID + ''' 
		   AND T2.TranMonth + 100 * T2.TranYear = ' + LTRIM(@TranMonth + 100 * @TranYear) + '

	
	UPDATE T1
	SET	T1.ReVoucherNo = T2.VoucherNo
	FROM #WP0009 T1
	INNER JOIN AV2006 T2 ON T1.DivisionID = T2.DivisionID AND T2.VoucherID = T1.ReVoucherID AND T2.TransactionID = T1.ReTransactionID

	SELECT * FROM #WP0009 ORDER BY Orders 
	DROP TABLE #WP0009
'


EXEC (@sSQL + @sSQL0 + @sSQL00 + @sSQL1 + @sSQL3 + @sSQL4)
PRINT (@sSQL)
PRINT (@sSQL0)
PRINT (@sSQL00)
PRINT (@sSQL1)
PRINT (@sSQL3)
PRINT (@sSQL4)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

