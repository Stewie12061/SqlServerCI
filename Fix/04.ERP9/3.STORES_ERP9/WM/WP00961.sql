﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP00961]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP00961]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load edit cho các phiếu yêu cầu Nhập, xuất, VCNB trên Web
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 03/02/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Minh Dũng on 29/11/2023: Bổ sung quy cách và đơn vị quy đổi.
---- Modified by Đức Tuyên on 05/12/2023: Chỉnh sửa lưu quy vào bảng WT8899 theo chuẩn.
---- Modified by Viết Toàn on 22/12/2023: Bổ sung cột tên tài xế và mã xe (Customize NKC)
---- Modified by Viết Toàn on 03/01/2023: Rename column FullName => DriverName
-- <Example>
/*
	 WP00961 @DivisionID=N'HT',@VoucherID=N'bb3ca221-f67e-4a1f-a7ab-39ec751ff197', @PageNumber = 1, @PageSize = 25, @UserID = 'TEST'
*/

CREATE PROCEDURE WP00961
(
    @DivisionID NVARCHAR(50),
	@VoucherID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@UserID VARCHAR(50) = ''
)
AS
DECLARE @sSQL NVARCHAR(MAX)  = '',
		@sSQL0 NVARCHAR(MAX) = '',
	    @sSQL1 NVARCHAR(MAX) = '',
	    @sSQL2 NVARCHAR(MAX) = '',
	    @sSQL3 NVARCHAR(MAX) = '',
	    @sSQL4 NVARCHAR(MAX) = '',
	    @sSQL5 NVARCHAR(MAX) = '',
		@sSQL6 NVARCHAR(MAX) = '',
	    @TranMonth INT = 0,
		@TranYear INT = 0,
		@WareHouseID NVARCHAR(50) = '',
		@CustomerIndex INT,
		@sSelect NVARCHAR(2000)='',
		@sSelect1 NVARCHAR(MAX)='',
		@sJoin NVARCHAR(MAX)='',
		@TotalRow NVARCHAR(50) = '',
		@sSQLPer VARCHAR(MAX) = '',
		@sWHEREPer VARCHAR(MAX) = ''

SELECT @TranMonth = TranMonth, @TranYear = TranYear, @WareHouseID = (CASE WHEN KindVoucherID = 3 THEN WareHouseID2 ELSE WareHouseID END)
FROM WT0095 W95 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

SELECT @CustomerIndex = ISNULL(CustomerName,-1) FROM CustomerIndex

---Phân trang
IF @PageNumber IS NULL 
BEGIN
	SET @sSQL1=''
	SET @TotalRow = 'NULL'	
END
ELSE 
if @PageNumber = 1 
BEGIN
	SET @TotalRow = 'COUNT(*) OVER ()'
END

IF @CustomerIndex = 70 ----EIMSKIP
BEGIN
	----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
	IF EXISTS (SELECT TOP 1 1 FROM WT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = N' 
		LEFT JOIN AT0010 ON AT0010.DivisionID = W95.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = W95.CreateUserID '
		SET @sWHEREPer = N' 
		AND (W95.CreateUserID = AT0010.UserID
			OR  W95.CreateUserID = '''+@UserID+''' 
			OR W95.ObjectID = '''+@UserID+''')'
	
	END
	
	-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	

	SET @sSelect = ', W95.ContractID, W95.ContractNo'
	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.InventoryName ELSE '''' END) ImWareHouseName,
					(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.InventoryName
					ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.InventoryName ELSE '''' END END) ExWareHouseName'

	SET @sJoin = 'LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', W95.DivisionID) AND A33.InventoryID = W95.WareHouseID
				  LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', W95.DivisionID) AND A03.InventoryID = W95.WareHouseID2'
END
ELSE
BEGIN
	SET @sJoin = 'LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.WareHouseID = W95.WareHouseID
				  LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = W95.WareHouseID2'

	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
		(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName'

	
	IF @CustomerIndex = 166
	BEGIN
		SET @sJoin = @sJoin + ' 
			LEFT JOIN AT1103 A13_1 WITH (NOLOCK) ON A13_1.EmployeeID = W96.DriverID
		'
		SET @sSelect1 = @sSelect1 + N', A13_1.FullName AS DriverName, W96.CarID'

	END

END

SET @sSQL4 = '
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
	AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
	AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
	AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,'
SET @sSQL5 = '
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = W96.DivisionID AND O99.TransactionID = W96.TransactionID and O99.VoucherID = W96.VoucherID
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
	LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20'''


SET @sSQL = 'SELECT  ROW_NUMBER() OVER (ORDER BY BT.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, BT.*
FROM
	(
	SELECT W95.ReDeTypeID, W95.VoucherTypeID, W95.VoucherNo, W95.IsGoodsFirstVoucher, W95.IsGoodsRecycled,
	W95.VoucherDate, W95.RefNo01, W95.RefNo02, W95.KindVoucherID, W95.RDAddress, W95.ContactPerson,
	W95.InventoryTypeID, W95.ObjectID, A22.ObjectName, W95.VATObjectName,	
	(CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN W95.WareHouseID ELSE '''' END) ImWareHouseID,
	(CASE WHEN W95.KindVoucherID IN (2,4,6,8,10) THEN W95.WareHouseID
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN W95.WareHouseID2 ELSE '''' END END) ExWareHouseID,
	W95.EmployeeID,	W96.TransactionID, W95.VoucherID, W96.InventoryID, A32.InventoryName, W96.UnitID, A04.UnitName,
    W96.ActualQuantity, W96.UnitPrice, W96.OriginalAmount, W96.ConvertedAmount, W96.OriginalAmount AS ActualAmount, W95.[Description], W95.TranMonth,
    W95.TranYear, W95.DivisionID, W96.SaleUnitPrice, W96.SaleAmount, W96.DiscountAmount, W96.SourceNo,	
    W96.DebitAccountID, A05_1.AccountName AS DebitAccountName, W96.CreditAccountID, A05_2.AccountName AS CreditAccountName, A05_1.GroupID DebitGroupID, A05_2.GroupID CreditGroupID,			
    W96.LocationID, W96.ImLocationID, W96.Ana01ID, A11_01.AnaName Ana01Name, W96.Ana02ID, A11_02.AnaName Ana02Name,
	W96.Ana03ID, A11_03.AnaName Ana03Name, W96.Ana04ID, A11_04.AnaName Ana04Name, 
	W96.Ana05ID, A11_05.AnaName Ana05Name, W96.Ana06ID, A11_06.AnaName Ana06Name,
	W96.Ana07ID, A11_07.AnaName Ana07Name, W96.Ana08ID,	A11_08.AnaName Ana08Name,
	W96.Ana09ID, A11_09.AnaName Ana09Name, W96.Ana10ID,	A11_10.AnaName Ana10Name,
	W95.IsInheritWarranty, W95.EVoucherID, W96.WVoucherID, W95.IsVoucher, 
	W96.InheritTransactionID, W96.InheritVoucherID, W96.InheritTableID,W96.InheritApportionID,'
	
SET @sSQL0 = '
	W96.Orders, W96.LimitDate, W96.Notes, W96.ConversionFactor, W96.ReVoucherID, W96.ReTransactionID, W96.IsProInventoryID,
	W96.ReVoucherID ReOldVoucherID, W96.ReTransactionID ReOldTransactionID, W96.ActualQuantity OldQuantity,
	W96.CreditAccountID OldCreditAccountID, W96.MarkQuantity OldMarkQuantity, A24.OrderNo as OrderNo,
	W96.OrderID, W96.OTransactionID, W96.MOrderID, W96.SOrderID, W96.MTransactionID, W96.STransactionID,
	A32.IsSource, A32.IsLimitDate, A32.IsLocation, A32.MethodID, V06.VoucherNo ReVoucherNo, A32.AccountID,
	A32.Specification, A32.S1, A32.S2, A32.S3, A32.Notes01, A32.Notes02, A32.Notes03, A32.Barcode,	
	---- Phuc vu bao cao  DVT qui doi  cho cac khach hang dung version cu truoc 7.1
	W96.PeriodID, A39.UnitID ConversionUnitID, A39.ConversionFactor ConversionFactor2, A39.Operator,
	------------------------
	M01.[Description] PeriodName, W96.ProductID, A02.InventoryName ProductName, 
	(SELECT TOP 1 ISNULL(ExpenseConvertedAmount, 0)
	 FROM AT9000 WITH (NOLOCK)
	 WHERE DivisionID = W96.DivisionID
		AND VoucherID = W96.VoucherID
		AND TransactionID = W96.TransactionID
		AND TableID = ''AT9000''
		AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) ExpenseConvertedAmount,
	(SELECT TOP 1 ISNULL(DiscountAmount,0)
	 FROM AT9000 WITH (NOLOCK)
	 WHERE DivisionID = W96.DivisionID
		AND VoucherID = W96.VoucherID
		AND TransactionID = W96.TransactionID
		AND TableID = ''AT9000''
		AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) DiscountAmount2,
	(SELECT TOP 1 InvoiceDate
	 FROM AT9000 WITH (NOLOCK)
	 WHERE DivisionID = W96.DivisionID
		AND VoucherID = W96.VoucherID
		AND AT9000.TransactionID = W96.TransactionID
		AND TableID = ''AT9000''
		AND TransactionTypeID IN (''T03'',''T04'',''T24'',''T25'')) InvoiceDate,'
	
SET @sSQL1 = '
	(SELECT AT2008.EndQuantity
	 FROM AT2008 WITH (NOLOCK)
	 WHERE DivisionID = '''+@DivisionID+'''
		AND InventoryID = W96.InventoryID
		AND InventoryAccountID = A32.AccountID
		AND TranMonth + 100 * AT2008.TranYear = '+STR(@TranMonth + 100 * @TranYear)+'
		AND WarehouseID = '''+@WarehouseID+''') ActEndQty, W96.ETransactionID, O23.EstimateID,
---- Cac thong tin lien quan den DVT qui doi  cho 
	W96.Parameter01, W96.Parameter02, W96.Parameter03, W96.Parameter04, W96.Parameter05,
	W96.ConvertedQuantity, W96.ConvertedPrice, ISNULL(W96.ConvertedUnitID, A32.UnitID) ConvertedUnitID,
	ISNULL(T04.UnitName, A04.UnitName) ConvertedUnitName, ISNULL(T09.Operator, 0) T09Operator,
	ISNULL(T09.ConversionFactor, 1) T09ConversionFactor, ISNULL(T09.DataType, 0) DataType, T09.FormulaID, A19.FormulaDes,
	W96.LocationCode, W96.Location01ID, W96.Location02ID, W96.Location03ID, W96.Location04ID, W96.Location05ID,
---- SL mark (yeu cau cua 2T)
	W96.MarkQuantity, W96.Notes TDescription,
---- CP khac	(yeu cau cua 2T)
	W96.OExpenseConvertedAmount, W96.Notes01 WNotes01, W96.Notes02 WNotes02, W96.Notes03 WNotes03, W96.Notes04 WNotes04,
	W96.Notes05 WNotes05, W96.Notes06 WNotes06, W96.Notes07 WNotes07, W96.Notes08 WNotes08,	W96.Notes09 WNotes09,
	W96.Notes10 WNotes10, W96.Notes11 WNotes11, W96.Notes12 WNotes12, W96.Notes13 WNotes13, W96.Notes14 WNotes14,
	W96.Notes15 WNotes15, W95.CreateUserID,
	A05_1.IsObject DIsObject, A05_2.IsObject CIsObject, W96.StandardPrice, W96.StandardAmount,
	W95.StatusID, W96.ReceiveQuantity, W96.ActualQuantity - W96.ReceiveQuantity EndQuantity, W95.[Status], A07.VoucherTypeName, A13.FullName AS EmployeeName,
	W95.LastmodifyUserID, W95.LastmodifyDate, W95.CreateDate
	'+@sSelect+@sSelect1+' '
	
	SET @sSQL2 = '
	FROM WT0096 W96 WITH (NOLOCK)
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', W96.DivisionID) AND A32.InventoryID = W96.InventoryID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = W96.UnitID
	INNER JOIN WT0095 W95 WITH (NOLOCK) ON W95.DivisionID = W96.DivisionID AND W95.VoucherID = W96.VoucherID
	LEFT JOIN AT2004 A24 WITH (NOLOCK) ON A24.DivisionID = W95.DivisionID AND A24.OrderID = W95.OrderID
	LEFT JOIN AV2006 V06 ON V06.DivisionID = W96.DivisionID AND V06.VoucherID = W96.ReVoucherID AND V06.TransactionID = W96.ReTransactionID --AND V06.VoucherNo = W95.VoucherNo
	LEFT JOIN MT1601 M01 WITH (NOLOCK) ON M01.DivisionID = W96.DivisionID AND M01.PeriodID = W96.PeriodID
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', W96.DivisionID) AND A02.InventoryID = W96.ProductID
	LEFT JOIN
		(
			SELECT InventoryID, MIN(UnitID) UnitID, MIN(ConversionFactor) ConversionFactor, MIN(Operator) Operator, DivisionID
			FROM AT1309  WITH (NOLOCK)
			GROUP BY InventoryID, DivisionID
		) A39 
	on W96.InventoryID = A39.InventoryID --- Phuc vu bao cao nen chua bo oin nay duoc
	LEFT JOIN AT1011 A11_01 WITH (NOLOCK) ON A11_01.AnaID = W96.Ana01ID AND A11_01.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A11_02 WITH (NOLOCK) ON A11_02.AnaID = W96.Ana02ID AND A11_02.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A11_03 WITH (NOLOCK) ON A11_03.AnaID = W96.Ana03ID AND A11_03.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A11_04 WITH (NOLOCK) ON A11_04.AnaID = W96.Ana04ID AND A11_04.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A11_05 WITH (NOLOCK) ON A11_05.AnaID = W96.Ana05ID AND A11_05.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A11_06 WITH (NOLOCK) ON A11_06.AnaID = W96.Ana06ID AND A11_06.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A11_07 WITH (NOLOCK) ON A11_07.AnaID = W96.Ana07ID AND A11_07.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A11_08 WITH (NOLOCK) ON A11_08.AnaID = W96.Ana08ID AND A11_08.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A11_09 WITH (NOLOCK) ON A11_09.AnaID = W96.Ana09ID AND A11_09.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A11_10 WITH (NOLOCK) ON A11_10.AnaID = W96.Ana10ID AND A11_10.AnaTypeID = ''A10''
	LEFT JOIN OT2203 O23 WITH (NOLOCK) ON O23.DivisionID = W96.DivisionID AND O23.TransactionID = W96.ETransactionID
	LEFT JOIN AT1309 T09 WITH (NOLOCK) ON T09.InventoryID = W96.InventoryID AND W96.ConvertedUnitID = T09.UnitID
	LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = ISNULL(W96.ConvertedUnitID,'''')
	LEFT JOIN AT1319 A19 WITH (NOLOCK) ON ISNULL(T09.FormulaID,'''') = A19.FormulaID 
	LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.ObjectID = W95.ObjectID
	LEFT JOIN AT1005 A05_1 WITH (NOLOCK) ON A05_1.AccountID = W96.DebitAccountID
	LEFT JOIN AT1005 A05_2 WITH (NOLOCK) ON A05_2.AccountID = W96.CreditAccountID
	LEFT JOIN AT1007 A07 WITH (NOLOCK) ON A07.DivisionID = W95.DivisionID AND A07.VoucherTypeID = W95.VoucherTypeID
	LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = W95.EmployeeID
	'+@sJoin+' '+@sSQLPer+' '
	
SET @sSQL3 = '	
	WHERE W96.DivisionID = '''+@DivisionID+'''
	AND W96.TranMonth = '+STR(@TranMonth)+'
	AND W96.TranYear = '+STR(@TranYear)+' 
	AND W96.VoucherID = '''+@VoucherID+'''
	'+@sWHEREPer+'
)BT
ORDER BY BT.Orders
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT @sSQL
--PRINT @sSQL4
--PRINT @sSQL0
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL5
--PRINT @sSQL3

EXEC(@sSQL + @sSQL4 + @sSQL0 + @sSQL1 + @sSQL2 + @sSQL5 + @sSQL3 )



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
