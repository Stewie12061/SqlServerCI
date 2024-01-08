IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load edit/view cho các phiếu Nhập, xuất, VCNB
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
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 07/07/2016: Bổ sung trường ObjectShipID
---- Modified by Bảo Thy on 07/09/2016: Bổ sung trường SOrderIDRecognition
---- Modified by Hải Long on 28/12/2016: Bổ sung các trường ObjectShipName, ObjectShipAddress, ObjectShipTel, KITTypeID, KITTypeName cho ANGEL
---- Modified by Hải Long on 28/12/2016: Bổ sung subquery cho ANGEL
---- Modified by Hải Long on 28/12/2016: Bổ sung KITQurantity cho subquery
---- Modified by Hải Long on 06/03/2017: Bổ sung trường OrderDate lấy từ đơn hàng mua (HV_GODREJ)
---- Modified by Bảo Anh on 24/04/2017: Bổ sung trường SOQuantity (Chí Thành)
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Bảo Thy on 13/06/2017: Bổ sung trường Address, InheritVoucherNo, 10 mã phân tích mặt hàng
---- Modified by Bảo Thy on 22/06/2017: Bổ sung AT9000.UnitPrice, AT9000.ConvertedAmount (Hùng Thịnh - CAR)
---- Modified by Bảo Thy on 06/07/2017: Bổ sung A06.EmployeeID,A1103.FullName EmployeeName, A26_NK.VoucherDate AS ReVoucherDate (EIMSKIP)
---- Modified by Phương Thảo on 16/08/2017: Bổ sung IsReturn: Phiếu nhập trả
---- Modified by Phương Thảo on 16/10/2017: Bổ sung đơn giá ĐH bán: SOUnitPrice (Đông Dương)
---- Modified by Thị Phượng on 27/02/2018: load lên thêm số A07.SerialNo cho các phiếu nhập xuất
---- Modified by Thị Phượng on 27/02/2018: load lên thêm số A07.WarrantyCard cho các phiếu nhập xuất
---- Modified by Kim Thư on 11/12/2018: Bổ sung load thông tin hóa đơn điện tử (CustomerIndex = 16 - Siêu Thanh)
---- Modified by Kim Thư on 18/03/2019: Thêm trường ghi chú của đơn hàng bán vào phiếu xuất kho khi in (CustomizeIndex = 74 - Godrej)
---- Modified by Kim Thư on 11/04/2019: Bổ sung OrderID mà phiếu cha kế thừa (trường hợp phiếu xuất đang in được kế thừa từ phiếu xuất kho khác - CustomizeIndex = 36 - SGPT)
---- Modified by Văn Minh on 27/11/2019: Bổ sung Distinct tránh bị đúp dữ liệu
---- Modified by Huỳnh Thử on 27/08/2020: EMISKIP: Bổ sung Diễn giải lệnh xuất kho
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 12/10/2020 : Cộng subQuery vào Exce 
---- Modified by Huỳnh Thử on 16/10/2020 : EMISKIP: Bổ sung cột số chứng từ yêu cầu xuất kho
---- Modified by Đức Thông on 26/10/2020 : SAVI: Đẩy result vào bảng WT0009 thay thế view AV0014 ở báo cáo AR2018
---- Modified by Đức Thông on 27/10/2020 : SAVI: Bỏ Đẩy result vào bảng WT0009 thay thế view AV0014 ở báo cáo AR2018 (dùng trực tiếp câu select bảng tạm)
---- Modified by Huỳnh Thử on 09/11/2020 : EMISKIP: Fix Bổ sung cột số chứng từ yêu cầu xuất kho
---- Modified by Văn Tài   on 09/11/2020 : QTC: Bổ sung lấy trường InvoiceNo, InvoiceDate từ Phiều mua hàng.
---- Modified by Huỳnh Thử   on 16/12/2020 : Lấy số hóa đơn từ AT1035 đưa vào chuẩn.
---- Modified by Đức Thông   on 11/01/2021 : [NKTTN] 2021/01/IS/0118 Lấy thêm thông tin từ AT1035 phục vụ hủy hddt ở phiếu vcnb
---- Modified by Đức Thông   on 04/02/2021 : [KHV] 2021/02/IS/0019 HTML decode trường địa chỉ nhận hàng (RDAddress)
---- Modified by Văn Tài	 on 02/03/2021 : [Đức Phát] Lấy dữ liệu của phiếu xuất NVL tự động.
---- Modified by Nhựt Trường on 24/05/2021 : Bổ sung thêm điều kiện DivisionID khi join bảng AT1303.
---- Modified by Xuân Nguyên on 26/10/2021 : 2021/10/IS/0137 Bỏ DISTINCT khi SELECT dữ liệu vào #WP0009
---- Modified by Xuân Nguyên on 27/10/2021 : revert: không bỏ DISTINCT
---- Modified by Nhật Thanh on 24/01/2022 : [Angel] Bổ sung các cột dữ liệu
---- Modified by Nhật Thanh on 22/02/2022 : [Siêu Thanh] Bổ sung cột dữ liệu phương tiện vận chuyển
---- Modified by Nhật Thanh on 17/03/2022 : [ANGEL]	Cập nhật tên trường địa chỉ kho nhập - xuất
---- Modified by Nhật Thanh on 29/03/2022 : Bổ sung điều kiện divisionID dùng chung khi join bảng
---- Modified by Đức Tuyên	on 28/12/2022 : Bổ sung lấy thêm trường ghi chú (Ana04Notes) cho mã phân tích 04
---- Modified by Đình Định 	on 24/02/2023 : [BBA] Lấy cột hàng khuyến mãi khi xem 'Xuất kho' 
---- Modified by Xuân Nguyên on 08/03/2023 : [Thiên Nam]Bổ sung cột SOrderNo từ ERP7
---- Modified by Đình Định  on 20/03/2023 : [Thiên Nam] Lấy lên trường InvoiceNo & Tham số.
---- Modified by Nhật Thanh on 21/03/2023 : Bổ sung load MT2161APK
---- Modified by Thành Sang on 29/03/2023 : Bổ sung thêm trường ProjectID, Status, CreateDate, LastModifyUserID, LastModifyDate, VATRate, WareHouseName
---- Modified by Hoài Thanh on 15/05/2023 : Bổ sung thêm trường IsAutoSellOut
---- Modified by Thanh Lượng on 16/06/2023 : [2023/06/IS/0165] Bổ sung thêm trường ApportionID.
-- <Example>
/*
	WP0009 'EM','ARfe3c1568-36ee-4a4c-8052-9e505f8168af'
*/


CREATE PROCEDURE [DBO].[WP0009]
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
		@sSQL5 NVARCHAR(MAX),
	    @sFrom NVARCHAR(500) = '',
	    @TranMonth INT = 0,
		@TranYear INT = 0,
		@WareHouseID NVARCHAR(50) = '',
		@CustomerName INT = -1

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WP0009_QC @DivisionID, @VoucherID
ELSE 
BEGIN 

SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)
IF @CustomerName = 29 --- Customer TBIV
BEGIN
	SET @sSQL2 = ', ISNULL(A00.UnitPrice, 0) TUnitPrice, ISNULL(A00.OriginalAmount, 0) TOriginalAmount'
	SET @sFrom = 'LEFT JOIN AT9000 A00 WITH (NOLOCK) ON A00.DivisionID = A07.DivisionID AND A00.VoucherID = A07.VoucherID 
						AND A00.TransactionID = A07.TransactionID AND A00.TableID = ''AT9000'' AND A00.TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')'
END

IF @CustomerName = 57 --- Customer Angel
BEGIN
	SET @sSQL2 = ', A07.KITID, A07.KITQuantity, AT1326.KITTypeID, AT0168.KITTypeName, AT1326.InventoryQuantity, AT1326.Weight, A06.IsProduct, A06.ObjectShipID, A05.ObjectName AS ObjectShipName, A05.Address AS ObjectShipAddress, A05.Tel AS ObjectShipTel, A06.IsLedger'
	SET @sFrom = 'LEFT JOIN AT1326 WITH (NOLOCK) On AT1326.DivisionID = A07.DivisionID And AT1326.KITID = A07.KITID And AT1326.InventoryID = A07.InventoryID
				  LEFT JOIN AT1202 A05 WITH (NOLOCK) ON A05.DivisionID in (''@@@'',A06.DivisionID) AND A05.ObjectID = A06.ObjectShipID
				  LEFT JOIN AT0168 WITH (NOLOCK) ON AT0168.DivisionID = AT1326.DivisionID AND AT0168.KITTypeID = AT1326.KITTypeID
				  '
END

IF @CustomerName in (73,76) --- Chí Thành
BEGIN
	SET @sSQL2 = ', OT2002.OrderQuantity as SOQuantity, OT2002.SalePrice as SOUnitPrice'
	SET @sFrom = 'LEFT JOIN OT2002 WITH (NOLOCK) ON A07.DivisionID = OT2002.DivisionID And A07.OTransactionID = OT2002.TransactionID'
END



IF @CustomerName in (74) --- Godrej
BEGIN
	SET @sSQL2 = ',OT2002.Notes AS Notes1'
	SET @sFrom = 'LEFT JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = A07.DivisionID AND OT2002.SOrderID = A07.OrderID AND OT2002.TransactionID = A07.OTransactionID
'
END

IF @CustomerName in (36) --- Sài Gòn Petro
BEGIN
	SET @sSQL2 = ', A207.OrderID AS A207_OrderID'
	SET @sFrom = 'LEFT JOIN AT2007 A207  WITH (NOLOCK) ON A207.VoucherID = A07.InheritVoucherID and A207.TransactionID = A07.InheritTransactionID
'
END
--IF @CustomerName in (16) --- Siêu Thanh
BEGIN
	SET @sSQL2 += ', A06.Transportation '
END
--IF @CustomerName in (16) --- Siêu Thanh -- Đưa vào chuẩn
--BEGIN
	SET @sSQL2 += ', A35.InvoiceSign, A35.Serial, A35.InvoiceNo, A35.InvoiceGuid, A35.BranchID '
	SET @sFrom += 'LEFT JOIN AT1035 A35 WITH (NOLOCK) ON A35.VoucherID = A06.VoucherID AND A35.IsLastEInvoice = 1'
--END
IF @CustomerName IN (70) --- EMISKIP
BEGIN
	 SELECT DISTINCT dbo.WT2001.Description INTO #Temp FROM  WT2001 
	 LEFT JOIN WT2002 ON WT2002.DivisionID = WT2001.DivisionID AND WT2002.VoucherID = WT2001.VoucherID
	 LEFT JOIN AT2007 ON AT2007.DivisionID = WT2001.DivisionID AND AT2007.InheritVoucherID = WT2002.VoucherID AND AT2007.InheritTransactionID = WT2002.TransactionID
	 WHERE WT2001.DivisionID = @DivisionID AND AT2007.VoucherID = @VoucherID

	 DECLARE @DescriptionLXK NVARCHAR(MAX)
	 SELECT  @DescriptionLXK = STUFF(
							(   
							
								SELECT '/' + Description FROM #Temp
								FOR xml path('')
							)
							, 1
							, 1
							, '')
	SET @sSQL2 = N' , '''+ISNULL(@DescriptionLXK,'')+''' AS DescriptionLXK'

	-- Số chứng từ yêu cầu xuất kho
	DECLARE @VoucherNoWT0095 NVARCHAR(MAX)
	SELECT DISTINCT A06.VoucherID,W95_LXK.VoucherNo AS ReExVoucherNo INTO #TEMP1 FROM AT2007  A07
	LEFT JOIN AT2006 A06 ON A06.VoucherID = A07.VoucherID
	LEFT JOIN WT2001 W01 WITH (NOLOCK) ON W01.DivisionID = A06.DivisionID AND W01.VoucherID = A07.InheritVoucherID 
	LEFT JOIN WT2002 W02 WITH (NOLOCK) ON W02.DivisionID = A06.DivisionID AND W02.VoucherID = W01.VoucherID 
	LEFT JOIN WT0095 W95_LXK WITH (NOLOCK) ON W95_LXK.DivisionID = A06.DivisionID AND W95_LXK.VoucherID = W02.InheritVoucherID 
	WHERE A06.VoucherID = @VoucherID

	SELECT  @VoucherNoWT0095 =
	  STUFF((
		SELECT ', ' + t2.ReExVoucherNo  
		FROM #TEMP1 t2
		WHERE t2.VoucherID = t1.VoucherID
		FOR XML PATH (''))
	  ,1,2,'') 
	   
	FROM #TEMP1 t1
	GROUP BY t1.VoucherID

	SET @sSQL2 += N' , '''+ISNULL(@VoucherNoWT0095,'')+''' AS ReExVoucherNo'

END

IF @CustomerName IN (41) --- QTC
BEGIN
	SET @sSQL2 = N', (SELECT TOP 1 InvoiceNo FROM AT9000 WITH (NOLOCK) WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID
					AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) InvoiceNo 
					'
END 

IF @CustomerName IN (134) --- Đức Phát
BEGIN
	SET @sSQL2 = N' , MT10.PeriodID AS ExPeriodID,
				MT10.VoucherTypeID AS ExVoucherTypeID,
				MT10.ExWarehouseID AS ExAutoWareHouseID,
				MT10.DepartmentID AS DepartmentID,
				MT10.ApportionID AS ExApportionID
			'
	SET @sFrom = ' LEFT JOIN MT0810 MT10 WITH (NOLOCK) ON MT10.DivisionID = A06.DivisionID 
                                                AND MT10.BatchID = A06.VoucherID
			'
END

IF @CustomerName IN (92) --- Thiên Nam
BEGIN
	SET @sSQL2 = N', A06.InvoiceNo'
END
			
SELECT @TranMonth = TranMonth, @TranYear = TranYear, @WareHouseID = (CASE WHEN KindVoucherID = 3 THEN WareHouseID2 ELSE WareHouseID END)
FROM AT2006 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID



SET @ssQL = '
SELECT DISTINCT A07.SOrderIDRecognition,A06.ReDeTypeID, A06.VoucherTypeID, A06.VoucherNo, A06.IsGoodsFirstVoucher, A06.IsGoodsRecycled,
	A06.VoucherDate, A06.RefNo01, A06.RefNo02, A06.KindVoucherID,
	dbo.DecodeHTML(ISNULL(A06.RDAddress, '''')) AS RDAddress,
	Convert(Nvarchar(250),'''') AS AT1202_Note,
	A06.IsNotUpdatePrice,
	A06.IsNotJoinPrice,
	A06.ContactPerson,
	A06.InventoryTypeID, A06.ObjectID, 
	-- A02.ObjectName, 
	Convert(Nvarchar(250),'''') AS ObjectName,
	
	A06.VATObjectName,
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A06.WareHouseID ELSE '''' END) ImWareHouseID,
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A03.WareHouseName ELSE '''' END) ImWareHouseName,
	(CASE WHEN A06.KindVoucherID IN (1,3,5,7,9) THEN A03.Address ELSE '''' END) ImWareHouseAddress,
	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A06.WareHouseID ELSE CASE WHEN A06.KindVoucherID = 3 THEN A06.WareHouseID2 ELSE '''' END END) ExWareHouseID,
	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A03.WareHouseName ELSE CASE WHEN A06.KindVoucherID = 3 THEN A031.WareHouseName ELSE '''' END END) ExWareHouseName,
	(CASE WHEN A06.KindVoucherID IN (2,4,6,8,10) THEN A03.Address ELSE CASE WHEN A06.KindVoucherID = 3 THEN A031.Address ELSE '''' END END) ExWareHouseAddress,
	A06.EmployeeID,A1103.FullName EmployeeName, A26_NK.VoucherDate AS ReVoucherDate,
	A07.TransactionID, A06.VoucherID, A07.InventoryID, A07.IsProInventoryID,
	-- A12.InventoryName, 
	Convert(Nvarchar(250),'''') AS InventoryName,
	A07.UnitID, A04.UnitName,
	A07.ActualQuantity, A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A06.[Description], A06.TranMonth,
	A06.TranYear, A06.DivisionID, A07.SaleUnitPrice, A07.SaleAmount, A07.DiscountAmount, A07.SourceNo,	A07.WarrantyNo, A07.ShelvesID, W69.ShelvesName, A07.FloorID, W70.FloorName,
	A07.DebitAccountID, A07.CreditAccountID, DA.GroupID DebitGroupID, CA.GroupID CreditGroupID,			
	A07.LocationID, A07.ImLocationID, A07.Ana01ID, A_01.AnaName Ana01Name,
	A07.Ana02ID, A_02.AnaName Ana02Name, A07.Ana03ID, A_03.AnaName Ana03Name, A07.Ana04ID, A_04.AnaName Ana04Name, A_04.Notes Ana04Notes,
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
	(SELECT TOP 1 ISNULL(ExpenseConvertedAmount, 0) FROM AT9000 WITH (NOLOCK) WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID 
	 AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) ExpenseConvertedAmount,
	(SELECT TOP 1 ISNULL(DiscountAmount, 0) FROM AT9000 WITH (NOLOCK) WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID
	AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) DiscountAmount2,
	(SELECT TOP 1 InvoiceDate FROM AT9000 WITH (NOLOCK) WHERE DivisionID = A07.DivisionID AND VoucherID = A07.VoucherID
	AND TransactionID = A07.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) InvoiceDate,
	
	--(SELECT EndQuantity FROM AT2008 WHERE DivisionID = ''' + @DivisionID + ''' AND InventoryID = A07.InventoryID
	--AND InventoryAccountID = A12.AccountID AND TranMonth + 100 * TranYear = ' + LTRIM(@TranMonth + 100 * @TranYear) + '
	--AND WarehouseID = ''' + @WarehouseID + ''') ActEndQty, 
	Convert(Decimal(28,8),0) AS ActEndQty,
	
	A07.ETransactionID, O03.EstimateID,
	----- Cac thong tin lien quan den DVT qui doi  cho 
	A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedQuantity, A07.ConvertedPrice, 
	ISNULL(A07.ConvertedUnitID, NULL) ConvertedUnitID, 
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
	MT27.VoucherNo RefVoucherNo, 
	CAST(0 AS BIT) AS IsVAT, 	
	A06.SParameter01, A06.SParameter02, A06.SParameter03 ,
	A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, 
	A06.SParameter08, A06.SParameter09, A06.SParameter10, A06.SParameter11,
	A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15,
	A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, 
	A06.SParameter20,
	A06.IsReturn,
	--A02.BankAccountNo, A02.Fax, 
	convert(nvarchar(50),'''') AS BankAccountNo, convert(nvarchar(100),'''') AS Fax,
	--A12.I01ID, A12.I02ID, A12.I03ID, A12.I04ID, A12.I05ID,
	--B01.AnaName as AnaNameI01, B02.AnaName as AnaNameI02, B03.AnaName as AnaNameI03, B04.AnaName as AnaNameI04, B05.AnaName as AnaNameI05
	convert(nvarchar(50),'''') AS I01ID, convert(nvarchar(50),'''') AS I02ID, convert(nvarchar(50),'''') AS I03ID, convert(nvarchar(50),'''') AS I04ID, convert(nvarchar(50),'''') AS I05ID,
	convert(nvarchar(50),'''') AS I06ID, convert(nvarchar(50),'''') AS I07ID, convert(nvarchar(50),'''') AS I08ID, convert(nvarchar(50),'''') AS I09ID, convert(nvarchar(50),'''') AS I10ID,
	convert(nvarchar(250),'''') AS AnaNameI01, convert(nvarchar(250),'''') AS AnaNameI02, convert(nvarchar(250),'''') AS AnaNameI03, convert(nvarchar(250),'''') AS AnaNameI04, convert(nvarchar(250),'''') AS AnaNameI05, 
	convert(nvarchar(250),'''') AS AnaNameI06, convert(nvarchar(250),'''') AS AnaNameI07, convert(nvarchar(250),'''') AS AnaNameI08, convert(nvarchar(250),'''') AS AnaNameI09, convert(nvarchar(250),'''') AS AnaNameI10, 
	OT3001.OrderDate, W95.VoucherNo AS InheritVoucherNo, AT9000.UnitPrice AS AT9000UnitPrice, AT9000.ConvertedAmount AS AT9000ConvertedAmount
	, A07.SerialNo, A07.WarrantyCard,
	Case when A06.KindVoucherID in (2,3,4,6,8,10) then OT2001.VoucherNo else A07.OrderID end as SOrderNo, APKMT2161,
	A06.ProjectID, A06.Status, A06.CreateDate, A06.LastModifyUserID, A06.LastModifyDate, Isnull(A.VATRate,0) as VATRate, A03.WareHouseName,
	A06.IsAutoSellOut,A06.ApportionID
 '

SET @sSQL1 = '
INTO #WP0009
FROM AT2006 A06 WITH (NOLOCK)
LEFT JOIN AT2004 A24 WITH (NOLOCK) ON A24.DivisionID = A06.DivisionID AND A24.OrderID = A06.OrderID
LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = A06.DivisionID AND A07.VoucherID = A06.VoucherID
LEFT JOIN WT0169 W69 WITH (NOLOCK) ON A07.ShelvesID = W69.ShelvesID
LEFT JOIN WT0170 W70 WITH (NOLOCK) ON A07.FloorID = W70.FloorID
LEFT JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = A07.DivisionID AND AT9000.TransactionID = A07.TransactionID AND AT9000.TransactionTypeID = ''T04''
LEFT JOIN AT1309 T09 WITH (NOLOCK) ON T09.InventoryID = A07.InventoryID AND A07.ConvertedUnitID = T09.UnitID
LEFT JOIN AT1319 A19 WITH (NOLOCK) ON ISNULL(T09.FormulaID,'''') = A19.FormulaID 
LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = ISNULL(A07.ConvertedUnitID,'''')
LEFT JOIN OT2203 O03 WITH (NOLOCK) ON O03.DivisionID = A07.DivisionID AND O03.TransactionID = A07.ETransactionID
LEFT JOIN MT1601 M01 WITH (NOLOCK) ON M01.DivisionID = A07.DivisionID AND M01.PeriodID = A07.PeriodID
LEFT JOIN WT0095 W95 WITH (NOLOCK) ON A07.DivisionID = W95.DivisionID AND A07.InheritVoucherID = W95.VoucherID AND A07.InheritTableID = ''WT0095''
--LEFT JOIN AV2006 V06 ON V06.DivisionID = A07.DivisionID AND V06.VoucherID = A07.ReVoucherID AND V06.TransactionID = A07.ReTransactionID
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
--LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.InventoryID = A07.ProductID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A03.WareHouseID = A06.WareHouseID
LEFT JOIN AT1303 A031 WITH (NOLOCK) ON A031.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A031.WareHouseID = A06.WareHouseID2
--LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.ObjectID = A06.ObjectID
LEFT JOIN AT1103 A1103 WITH (NOLOCK) ON A1103.EmployeeID = A06.EmployeeID
LEFT JOIN OT3001 WITH (NOLOCK) ON OT3001.DivisionID = A07.DivisionID AND OT3001.POrderID = A07.OrderID
LEFT JOIN AT2006 A26_NK ON A26_NK.DivisionID = A07.DivisionID AND A26_NK.VoucherID = A07.ReVoucherID
LEFT JOIN OT2001 With (Nolock) on OT2001.SOrderID=A07.OrderID
'

SET @sSQL3 = '
	LEFT JOIN MT2007 MT27 WITH (NOLOCK) ON MT27.DivisionID = A07.DivisionID AND MT27.VoucherID =A07.InheritVoucherID
	--LEFT JOIN AT1015 B01 WITH (NOLOCK) ON B01.AnaID = A12.I01ID AND B01.AnaTypeID = ''I01''
	--LEFT JOIN AT1015 B02 WITH (NOLOCK) ON B02.AnaID = A12.I02ID AND B02.AnaTypeID = ''I02''
	--LEFT JOIN AT1015 B03 WITH (NOLOCK) ON B03.AnaID = A12.I03ID AND B03.AnaTypeID = ''I03''
	--LEFT JOIN AT1015 B04 WITH (NOLOCK) ON B04.AnaID = A12.I04ID AND B04.AnaTypeID = ''I04''
	--LEFT JOIN AT1015 B05 WITH (NOLOCK) ON B05.AnaID = A12.I05ID AND B05.AnaTypeID = ''I05''
	LEFT JOIN (Select distinct VoucherID,VATRate from AT9000 T9 With (Nolock)
             left join AT1010 T0 on T0.VATGroupID=T9.VATGroupID
            Where T9.TranMonth='+str(@TranMonth)+ ' And T9.TranYear ='+str(@TranYear)+ '
			And TransactionTypeID in (''T13'',''T14'',''T34'',''T35'') And TranMonth=8
			And TranYear=2013) A on A.VoucherID=A06.VoucherID
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
		t1.I01ID = t2.I01ID, t1.I02ID = t2.I02ID, t1.I03ID = t2.I03ID, t1.I04ID = t2.I04ID, t1.I05ID = t2.I05ID,
		t1.I06ID = t2.I06ID, t1.I07ID = t2.I07ID, t1.I08ID = t2.I08ID, t1.I09ID = t2.I09ID, t1.I10ID = t2.I10ID,
		t1.IsSource = t2.IsSource,
		t1.IsLimitDate = t2.IsLimitDate,
		t1.IsLocation = t2.IsLocation,
		t1.MethodID = t2.MethodID,
		t1.AccountID = t2.AccountID,
		t1.Specification = t2.Specification,
		t1.S1 = t2.S1, t1.S2 = t2.S2, t1.S3 = t2.S3,
		t1.Notes01 = t2.Notes01, t1.Notes02 = t2.Notes02, t1.Notes03 = t2.Notes03,
		t1.Barcode = t2.Barcode,
		t1.ConvertedUnitID = ISNULL(T1.ConvertedUnitID,t2.UnitID),
		t1.AnaNameI01 = I_01.AnaName, t1.AnaNameI02 = I_02.AnaName, t1.AnaNameI03 = I_03.AnaName, t1.AnaNameI04 = I_04.AnaName, t1.AnaNameI05 = I_05.AnaName,
		t1.AnaNameI06 = I_06.AnaName, t1.AnaNameI07 = I_07.AnaName, t1.AnaNameI08 = I_08.AnaName, t1.AnaNameI09 = I_09.AnaName, t1.AnaNameI10 = I_10.AnaName
	from #WP0009 t1
	inner join AT1302 t2 WITH (NOLOCK) ON t2.DivisionID IN (''@@@'', t1.DivisionID) AND t1.InventoryID = t2.InventoryID
	LEFT JOIN AT1015 I_01 WITH (NOLOCK) ON I_01.AnaID = t2.I01ID AND I_01.AnaTypeID = ''I01''
	LEFT JOIN AT1015 I_02 WITH (NOLOCK) ON I_02.AnaID = t2.I02ID AND I_02.AnaTypeID = ''I02''
	LEFT JOIN AT1015 I_03 WITH (NOLOCK) ON I_03.AnaID = t2.I03ID AND I_03.AnaTypeID = ''I03''
	LEFT JOIN AT1015 I_04 WITH (NOLOCK) ON I_04.AnaID = t2.I04ID AND I_04.AnaTypeID = ''I04''
	LEFT JOIN AT1015 I_05 WITH (NOLOCK) ON I_05.AnaID = t2.I05ID AND I_05.AnaTypeID = ''I05''
	LEFT JOIN AT1015 I_06 WITH (NOLOCK) ON I_06.AnaID = t2.I06ID AND I_06.AnaTypeID = ''I06''
	LEFT JOIN AT1015 I_07 WITH (NOLOCK) ON I_07.AnaID = t2.I07ID AND I_07.AnaTypeID = ''I07''
	LEFT JOIN AT1015 I_08 WITH (NOLOCK) ON I_08.AnaID = t2.I08ID AND I_08.AnaTypeID = ''I08''
	LEFT JOIN AT1015 I_09 WITH (NOLOCK) ON I_09.AnaID = t2.I09ID AND I_09.AnaTypeID = ''I09''
	LEFT JOIN AT1015 I_10 WITH (NOLOCK) ON I_10.AnaID = t2.I10ID AND I_10.AnaTypeID = ''I10''

	Update t1
	set	t1.ProductName = t2.InventoryName
	from #WP0009 t1
	inner join AT1302 t2 WITH (NOLOCK) ON t2.DivisionID IN (''@@@'', t1.DivisionID) AND t1.ProductID = t2.InventoryID'

SET @sSQL5 = '
	Update t1
	set	t1.ObjectName = t2.ObjectName,
		t1.Address = t2.[Address], 
		t1.VATNo = t2.VATNo, 
		t1.Tel = t2.Tel, 
		t1.Contactor = t2.Contactor,
		t1.BankAccountNo = t2.BankAccountNo, 
		t1.Fax = t2.Fax,
		t1.AT1202_Note = t2.Note
	from #WP0009 t1
	inner join AT1202 t2 WITH (NOLOCK) ON t2.DivisionID in (''@@@'',t1.DivisionID) AND t1.ObjectID = t2.ObjectID

	Update A12
	set	A12.AnaNameI01 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.DivisionID = A12.DivisionID AND B01.AnaID = A12.I01ID AND B01.AnaTypeID = ''I01''

	Update A12
	set	A12.AnaNameI02 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.DivisionID = A12.DivisionID AND B01.AnaID = A12.I02ID AND B01.AnaTypeID = ''I02''

	Update A12
	set	A12.AnaNameI03 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.DivisionID = A12.DivisionID AND B01.AnaID = A12.I03ID AND B01.AnaTypeID = ''I03''

	Update A12
	set	A12.AnaNameI04 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.DivisionID = A12.DivisionID AND B01.AnaID = A12.I04ID AND B01.AnaTypeID = ''I04''

	Update A12
	set	A12.AnaNameI05 = B01.AnaName
	from #WP0009 A12
	inner join AT1015 B01 WITH (NOLOCK) ON B01.DivisionID = A12.DivisionID AND B01.AnaID = A12.I05ID AND B01.AnaTypeID = ''I05''

	UPDATE T1
	SET		T1.ActEndQty = T2.EndQuantity
	FROM  #WP0009 T1
	INNER JOIN AT2008 T2 WITH (NOLOCK) ON t1.DivisionID = t2.DivisionID AND t1.InventoryID = t2.InventoryID
	INNER JOIN AT1302 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T2.InventoryAccountID = T3.AccountID
	WHERE  T2.DivisionID = ''' + @DivisionID + ''' AND T2.WarehouseID = ''' + @WarehouseID + ''' 
		   AND T2.TranMonth + 100 * T2.TranYear = ' + LTRIM(@TranMonth + 100 * @TranYear) + '

	
	UPDATE T1
	SET	T1.ReVoucherNo = T2.VoucherNo
	FROM #WP0009 T1
	INNER JOIN AV2006 T2 ON T1.DivisionID = T2.DivisionID AND T2.VoucherID = T1.ReVoucherID AND T2.TransactionID = T1.ReTransactionID

	'
+ CASE WHEN @CustomerName = 57 THEN '
	UPDATE T1
	SET	T1.SOrderID = A.OrderID
	FROM #WP0009 T1
	LEFT JOIN ( SELECT '''+@DivisionID+''' AS DivisionID, STUFF(
                 (SELECT DISTINCT '', '' + OrderID FROM AT3206_AG  WHERE DivisionID = ''' + @DivisionID + ''' AND VoucherID = '''+@VoucherID+''' FOR XML PATH ('''')), 1, 1, ''''
	) AS OrderID ) A ON A.DivisionID  = T1.DivisionID'
ELSE '' END  +'
	SELECT *
	FROM #WP0009
	ORDER BY Orders	

		
'

PRINT (@sSQL)
PRINT (@sSQL0)
PRINT (@sSQL00)
PRINT (@sSQL2)
PRINT (@sSQL1)
PRINT (@sSQL3)
PRINT (@sSQL4)
PRINT (@sSQL5)

EXEC (@sSQL + @sSQL0 + @sSQL00 +@sSQL2+ @sSQL1 + @sSQL3 + @sSQL4 + @sSQL5)





IF @CustomerName = 57 --- Customer Angel
BEGIN
	SET @sSQL = 'SELECT AT0168.KITTypeName, COUNT(AT0168.KITTypeName) AS Quantity, SUM(CONVERT(DECIMAL(28,8), AT2007.Notes02)) AS KITQuantity
				 FROM AT2007 WITH (NOLOCK)
				 INNER JOIN AT1326 WITH (NOLOCK) On AT1326.DivisionID = AT2007.DivisionID And AT1326.KITID = AT2007.KITID And AT1326.InventoryID = AT2007.InventoryID
				 INNER JOIN AT0168 WITH (NOLOCK) ON AT0168.DivisionID = AT1326.DivisionID AND AT0168.KITTypeID = AT1326.KITTypeID
				 WHERE AT2007.DivisionID = ''' + @DivisionID + '''
				 AND AT2007.VoucherID = ''' + @VoucherID + '''
				 GROUP BY AT0168.KITTypeName'
	EXEC (@sSQL)	
	--PRINT @sSQL		 
END

END 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
