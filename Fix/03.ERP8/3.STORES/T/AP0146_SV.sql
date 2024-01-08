IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_SV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_SV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- AP0146_SV
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử cho SaVi
---- Created on 02/08/2019 - Hoàng Trúc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Hoàng Trúc on 15/08/2019 : load lên dòng diễn giải lưu vào cột ProdName lấy từ 3 tham số Parameter03 , Parameter04, Parameter05, set null cho các trường còn lại
---- Modified by Văn Tài	on 02/10/2019 : Bổ sung Order By Remark do dữ liệu select đổ vào khối data cha làm mất index đúng.

---- Modified by Huỳnh Thử on 03/10/2019 : load lên LimitDate, SourceNo cho KindVoucherID ( 4, 7, 10)
---- Modified by Huỳnh Thử on 31/03/2020 : Round theo thiết lập vì trên Code Round đúng nguyên tắc: 0.5 = 1 và 1.5 = 1
---- Modified by Đức Thông on 03/07/2020 : + thuế hiệu chỉnh ở thành tiền thay vì thuế gốc
---- Modified by Huỳnh Thử	on 17/09/2020: Bổ sung trường ParentInvoiceSign và ParentSerial của hóa đơn gốc
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 28/12/2020: Cắt chuỗi @sSQL3, bỏ bớt vào chuỗi @sSQL3a để fix lỗi tràn dữ liệu.
---- Modified by Nhật Thanh on 07/04/2022: Bổ sung trường mới theo tt78
---- Modified by Nhật Thanh on 13/04/2022: Cập nhật lại kho xuất và kho nhập cho phiếu VCNB
---- Modified by Nhật Thanh on 29/12/2022: Bổ sung các trường GrossValue ...
---- Modified by Nhật Thanh on 13/01/2023: Bổ sung các trường GrossValue ... cho trường hợp Parameter05
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- EXEC AP0146_SV @DivisionID = 'SV0',@UserID='ASOFTADMIN',@VoucherID='AV71a37f58-4dd0-4ea9-82d3-1b2853577f4c'

CREATE PROCEDURE [dbo].[AP0146_SV]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1 AS NVARCHAR(MAX) = '',
		@sSQL2 AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',
		@sSQL3a AS NVARCHAR(MAX) = '',
		@sSQL4 AS NVARCHAR(MAX) = '',
		@sSQL5 AS NVARCHAR(MAX) = '',
		@sSQL6 AS NVARCHAR(MAX) = '',
		@sSQL7 AS NVARCHAR(MAX) = '',
		@VoucherTypeID AS NVARCHAR(50),
		@KindVoucherID AS TINYINT = 0,
		@ConvertedDecimals int = 0


		SELECT @ConvertedDecimals = ConvertedDecimals from AT0001 where DivisionID = @DivisionID
		SET @KindVoucherID = (SELECT KindVoucherID FROM AT2006 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID)
		print @KindVoucherID
IF @KindVoucherID = 3 or @KindVoucherID = 2  -- Phiếu VCNB, xuất kho
BEGIN
	SET @sSQL = '  
	SELECT ROW_NUMBER() OVER(ORDER BY A07.Orders) AS Remark, 
	-- CÁC CỘT THEO MẪU TEMPLATE XML HDDT
	A02.ObjectID AS CusCode, A02.ObjectName AS Buyer, 
	NULL AS PaymentMethod, A03_2.WareHouseName as CusAddress, A02.ObjectName AS CusName, A02.Email AS CusEmail
	, NULL AS Warehouse, NULL AS ShippingNo, A06.VoucherDate AS ShippingDate, NULL AS SoXe, A07.Notes06 AS HopDongSo,
	NULL AS SoVT, '''' AS ImWarehouseID, A02.Address AS ImWarehouseName
	, '''' AS ExWarehouseID  
	, (CASE WHEN A06.KindVoucherID = 3 THEN A11.Address ELSE A06.RDAddress END) AS ExWarehouseName
	, A06.VoucherDate AS ContractDate,
	A06.VoucherDate AS ImportDate, (SELECT SUM(ActualQuantity) FROM AT2007 WHERE VoucherID = '''+@VoucherID+''') AS Total, NULL AS VATRate, 0 AS VATAmount,
	0 AS Amount, NULL AS ArisingDate, A04.InventoryName AS ProdName, 
	A07.InventoryID AS ProdID, A07.UnitID AS ProdUnit, A07.ActualQuantity AS ProdQuantity, 0 AS ProdPrice,
	0 AS AfterAmount,
	-- CÁC CỘT TỪ BẢNG AT2006 VÀ AT2007
	A06.VoucherID, A06.TranMonth, A06.TranYear, A06.VoucherTypeID, A06.VoucherNo, CONVERT(CHAR(10), A06.VoucherDate, 126) AS VoucherDate, A06.ObjectID, A02.ObjectName, A06.WarehouseID, A03.WarehouseName,
	A06.WarehouseID2, A03_2.WarehouseName AS WarehouseName2, A06.ProjectID, A06.OrderID, A06.BatchID, A06.ReDeTypeID, A06.KindVoucherID, A06.Status, A06.EmployeeID, A06.Description,
	A06.CreateDate, A06.CreateUserID, A06.LastModifyUserID, A06.LastModifyDate, A06.RefNo01, A06.RefNo02, A06.RDAddress, A06.ContactPerson, A06.VATObjectName, A06.InventoryTypeID, 
	A06.IsGoodsFirstVoucher, A06.MOrderID, A06.ApportionID, A06.EVoucherID, A06.IsGoodsRecycled, A06.IsVoucher, A06.IsReceiving, A06.ImVoucherID, A06.ReVoucherID,
	A06.SParameter01, A06.SParameter02, A06.SParameter03, A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, A06.SParameter08, A06.SParameter09, A06.SParameter10, 
	A06.SParameter11, A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15, A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, A06.SParameter20, 
	A06.RouteID, A06.InTime, A06.OutTime, A06.DeliveryEmployeeID, A06.DeliveryStatus, A06.IsWeb, A06.CashierID, A06.CashierTime, A06.IsDeposit, A06.ObjectShipID, 
	A06.ContractID, A06.ContractNo, A06.IsCalCost, A06.IsReturn, A06.IsDelivery, A06.IsInTime, A06.IsOutTime, A06.IsPayment, A06.IsTransferMoney, A06.IsReceiptMoney, 
	A07.InventoryID, A04.InventoryName, A07.UnitID, A05.UnitName, A07.ActualQuantity, 0 AS Unitprice, 0 AS OriginalAmount, 0 AS ConvertedAmount, A07.Notes, A11.BaseCurrencyID AS CurrencyID, A07.ExchangeRate, A07.SaleUnitPrice,
	A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.DebitAccountID, A07.CreditAccountID, A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.ConversionFactor, A07.ReTransactionID,
	A07.ReVoucherID AS ReVoucherID_AT2007, A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID,(SELECT REPLACE (A07.Ana08ID,'''+@DivisionID+''','''' )) as Ana08ID, A07.Ana09ID, A07.Ana10ID,
	A1.AnaName as Ana01Name, A2.AnaName as Ana02Name, A3.AnaName as Ana03Name, A4.AnaName as Ana04Name, A5.AnaName as Ana05Name,
	A6.AnaName as Ana06Name, A7.AnaName as Ana07Name, A8.AnaName as Ana08Name, A9.AnaName as Ana09Name, A10.AnaName as Ana10Name,  
	A07.PeriodID, A07.ProductID, A07.OrderID AS OrderID_AT2007, A07.InventoryName1, 
	'
	SET @sSQL1=N'
	A07.OTransactionID, A07.ReSPVoucherID, A07.ReSPTransactionID, A07.ETransactionID, A07.MTransactionID,
	A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedQuantity, A07.ConvertedPrice, A07.ConvertedUnitID, A07.MOrderID as MOrderID_AT2007,
	A07.SOrderID, A07.STransactionID, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID, A07.MarkQuantity, A07.OExpenseConvertedAmount, 
	A07.WVoucherID, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08, A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15,
	A07.RefInfor, A07.StandardPrice, A07.StandardAmount, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID, A07.KITID, A07.KITQuantity, A07.TVoucherID, A07.SOrderIDRecognition,
	A07.SerialNo, A07.WarrantyCard, A16.BankAccountNo, A16.BankName, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson, 0 AS ItemTypeID, 5 AS InvoiceTypeID
	,(SELECT TOP 1 InvoiceSign FROM WT0000 WHERE WT0000.DefDivisionID = '''+@DivisionID+''') AS ParentInvoiceSign, (SELECT TOP 1 Serial FROM WT0000 WHERE WT0000.DefDivisionID = '''+@DivisionID+''') AS ParentSerial, 1 AS PayMethodID, (SELECT TOP 1 Serial FROM WT0000 WHERE WT0000.DefDivisionID = '''+@DivisionID+''') AS Serial,(SELECT TOP 1 InvoiceSign FROM WT0000 WHERE WT0000.DefDivisionID = '''+@DivisionID+''') AS InvoiceSign,
	A06.VoucherDate AS InvoiceDate, 0 AS VAT_Rate, 1 AS Extra, A02.TradeName AS CusBankName, '''' AS KindOfService, '''' AS CusTaxCode,
	A11.DivisionName AS Extra1, '''' AS ExtraKHV,A02.Tel AS CusPhone,  A02.VATNo AS CusTaxCode
	FROM AT2006 A06 WITH (NOLOCK) INNER JOIN AT2007 A07 WITH (NOLOCK) ON A06.VoucherID = A07.VoucherID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectID = A02.ObjectID
	LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID = A03.WarehouseID
	LEFT JOIN AT1303 A03_2 WITH (NOLOCK) ON A03_2.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID2 = A03_2.WarehouseID
	LEFT JOIN AT1302 A04 WITH (NOLOCK) ON A04.DivisionID IN (A07.DivisionID,''@@@'') AND A07.InventoryID = A04.InventoryID
	LEFT JOIN AT1304 A05 WITH (NOLOCK) ON A07.UnitID = A05.UnitID
	LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A07.DivisionID = A1.DivisionID AND  A07.Ana01ID = A1.AnaID AND A1.AnaTypeID = ''A01'' 
	LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A07.DivisionID = A2.DivisionID AND  A07.Ana02ID = A2.AnaID	AND	A2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A07.DivisionID = A3.DivisionID AND  A07.Ana03ID = A3.AnaID	AND	A3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A07.DivisionID = A4.DivisionID AND  A07.Ana04ID = A4.AnaID	AND	A4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A5 WITH (NOLOCK) ON A07.DivisionID = A5.DivisionID AND  A07.Ana05ID = A5.AnaID	AND	A5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A07.DivisionID = A6.DivisionID AND  A07.Ana06ID = A6.AnaID	AND	A6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A7 WITH (NOLOCK) ON A07.DivisionID = A7.DivisionID AND  A07.Ana07ID = A7.AnaID	AND	A7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A8 WITH (NOLOCK) ON A07.DivisionID = A8.DivisionID AND  A07.Ana08ID = A8.AnaID	AND	A8.AnaTypeID = ''A08''
    LEFT JOIN AT1011 A9 WITH (NOLOCK) ON A07.DivisionID = A9.DivisionID AND  A07.Ana09ID = A9.AnaID	AND	A9.AnaTypeID = ''A09''
    LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A07.DivisionID = A10.DivisionID AND  A07.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
	LEFT JOIN AT1101 A11 WITH (NOLOCK) ON A06.DivisionID = A11.DivisionID
	LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A11.BankAccountID = A16.BankAccountID
	WHERE A06.DivisionID = '''+@DivisionID+''' AND A06.VoucherID = '''+@VoucherID+'''
	--ORDER BY A07.Orders'
END
ELSE
BEGIN
	SET @sSQL = '     
	SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
	AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, AT9000.VATNo AS CusTaxCode,
	ISNULL(AT9000.Parameter02,'''') AS Buyer, AT1202.TradeName AS CusbankNo,
		
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
	- ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,

	ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
	- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,

	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
	- ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS OriginalAfterAmount,	
	
	ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'') AND VATGroupID = ''T00''), 0) AS VATAmount0,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'') AND VATGroupID = ''T05''), 0) AS VATAmount5,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'') AND VATGroupID = ''T08''), 0) AS VATAmount8,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN  (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T00''), 0) AS GrossValue0,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN  (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T05''), 0) AS GrossValue5,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN  (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T08''), 0) AS GrossValue8,
	ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN  (''T04'',''T24'',''T25'',''T64'') AND VATGroupID = ''T10''), 0) AS GrossValue10,

	'
	SET @sSQL1=N'
	CASE WHEN AT9000.VATGroupID=''TS0'' THEN -1 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID, 
	ISNULL(AT9000.InventoryName1,AT1302.InventoryName) AS ProdName, 
	AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
	ABS(AT9000.ConvertedPrice) AS ProdPrice, ABS(AT9000.ConvertedAmount) AS Amount,
	AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name,
	AT9000.PaymentID AS PaymentMethod,
	AT9000.BDescription as DonDatHangSo, ABS(AT9000.OriginalAmount) AS OriginalAmount, ISNULL(A02.AnaName+''/''+AT9000.VDescription,AT9000.VDescription) AS KindOfService, 
	AT9000.CurrencyID as Extra1, AT9000.ExchangeRate AS Extra,
	AT9000.InvoiceDate, AT9000.CurrencyID, AT9000.PaymentID, AT9000.VoucherNo,
	AT9000.VoucherID, AT9000.BatchID, AT9000.TransactionID, AT9000.TableID, AT9000.TranMonth, AT9000.TranYear, AT9000.TransactionTypeID, AT9000.ObjectID, AT9000.CreditObjectID, AT9000.VATNo,
	AT9000.VATObjectID, AT9000.VATObjectName, AT9000.VATObjectAddress, AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.ExchangeRate, AT9000.UnitPrice, AT9000.OriginalAmount as OriginalAmountAT9000,
	AT9000.ConvertedAmount, AT9000.ImTaxOriginalAmount, AT9000.ImTaxConvertedAmount, AT9000.ExpenseOriginalAmount, AT9000.ExpenseConvertedAmount, AT9000.IsStock, AT9000.VoucherDate,
	AT9000.VoucherTypeID, AT9000.VATGroupID, AT9000.Serial, AT9000.InvoiceNo, AT9000.Orders, AT9000.EmployeeID, AT9000.SenderReceiver, AT9000.SRDivisionName, AT9000.SRAddress,
	AT9000.RefNo01, AT9000.RefNo02, AT9000.VDescription, AT9000.BDescription, AT9000.Quantity, AT9000.InventoryID, AT9000.UnitID, AT9000.Status, AT9000.IsAudit, AT9000.IsCost, 
	AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.PeriodID,
	AT9000.ExpenseID, AT9000.MaterialTypeID, AT9000.ProductID, AT9000.CreateDate, AT9000.CreateUserID, AT9000.LastModifyUserID, AT9000.LastModifyDate, AT9000.OriginalAmountCN,
	AT9000.ExchangeRateCN, AT9000.CurrencyIDCN, AT9000.DueDays, AT9000.DueDate, AT9000.DiscountRate, AT9000.OrderID, AT9000.CreditBankAccountID, AT9000.DebitBankAccountID,
	AT9000.CommissionPercent, AT9000.InventoryName1, AT9000.PaymentTermID,
	'
	SET @sSQL2=N' AT9000.DiscountAmount as DiscountAmountAT9000, AT9000.OTransactionID, AT9000.IsMultiTax, 
	ABS(AT9000.VATOriginalAmount) AS VATOriginalAmount, ABS(AT9000.VATConvertedAmount) AS VATConvertedAmount,
	AT9000.ReVoucherID, AT9000.ReBatchID, AT9000.ReTransactionID, AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05, AT9000.Parameter06,
	AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10, AT9000.MOrderID, AT9000.SOrderID, AT9000.MTransactionID,AT9000.STransactionID,AT9000.RefVoucherNo,
	AT9000.IsLateInvoice,AT9000.ConvertedQuantity,AT9000.ConvertedPrice,AT9000.ConvertedUnitID,AT9000.ConversionFactor,AT9000.UParameter01,AT9000.UParameter02,AT9000.UParameter03,
	AT9000.UParameter04,AT9000.UParameter05,AT9000.PriceListID,AT9000.WOrderID,AT9000.WTransactionID,AT9000.MarkQuantity,AT9000.TVoucherID,AT9000.OldCounter,AT9000.NewCounter,
	AT9000.OtherCounter,AT9000.TBatchID,AT9000.ContractDetailID,AT9000.InvoiceCode,AT9000.InvoiceSign,AT9000.RefInfor,AT9000.StandardPrice,AT9000.StandardAmount,AT9000.IsCom,
	AT9000.VirtualPrice,AT9000.VirtualAmount,AT9000.ReTableID,AT9000.DParameter01,AT9000.DParameter02,AT9000.DParameter03,AT9000.DParameter04,AT9000.DParameter05,AT9000.DParameter06,
	AT9000.DParameter07,AT9000.DParameter08,AT9000.DParameter09,AT9000.DParameter10,AT9000.InheritTableID,AT9000.InheritVoucherID,AT9000.InheritTransactionID,AT9000.ETaxVoucherID,
	AT9000.ETaxID,AT9000.ETaxConvertedUnit,AT9000.ETaxConvertedAmount,AT9000.ETaxTransactionID,AT9000.AssignedSET,AT9000.SETID,AT9000.SETUnitID,AT9000.SETTaxRate,
	AT9000.SETConvertedUnit,AT9000.SETQuantity,AT9000.SETOriginalAmount,AT9000.SETConvertedAmount,AT9000.SETConsistID,AT9000.SETTransactionID,AT9000.AssignedNRT,AT9000.NRTTaxAmount,
	AT9000.NRTClassifyID,AT9000.NRTUnitID,AT9000.NRTTaxRate,AT9000.NRTConvertedUnit,AT9000.NRTQuantity,AT9000.NRTOriginalAmount,AT9000.NRTConvertedAmount,AT9000.NRTConsistID,
	AT9000.NRTTransactionID,AT9000.CreditObjectName,AT9000.CreditVATNo,AT9000.IsPOCost,AT9000.TaxBaseAmount,AT9000.WTCExchangeRate,AT9000.WTCOperator,AT9000.IsFACost,
	AT9000.IsInheritFA,AT9000.InheritedFAVoucherID,AT9000.AVRExchangeRate,AT9000.PaymentExchangeRate,AT9000.IsMultiExR,AT9000.ExchangeRateDate,AT9000.DiscountSalesAmount,
	AT9000.IsProInventoryID,AT9000.InheritQuantity,AT9000.DiscountPercentSOrder,AT9000.DiscountAmountSOrder,AT9000.IsWithhodingTax,AT9000.IsSaleInvoice,AT9000.WTTransID,
	AT9000.DiscountSaleAmountDetail, A01.AnaName as Ana01Name, A03.AnaName as Ana03Name, A04.AnaName as Ana04Name, A05.AnaName as Ana05Name, A06.AnaName as Ana06Name,
	A07.AnaName as Ana07Name, A08.AnaName as Ana08Name, A09.AnaName as Ana09Name, A10.AnaName as Ana10Name,'
	
	SET @sSQL3='
	AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,
	AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
	AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
	AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,
	AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,
	CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
	CASE AT9000.PaymentID WHEN ''TM'' THEN 1 WHEN ''CK'' THEN 2 WHEN ''TM/CK'' THEN 3 ELSE NULL END AS PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
	A16.BankAccountNo, A16.BankName, A26.ContactPerson, 
	ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as DVATOriginalAmount, ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) as DVATConvertedAmount,
	A13.UnitName AS ConvertedUnitName, A12.PaymentName, CASE WHEN TransactionTypeID = ''T64'' THEN 1 ELSE 0 END AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
	ISNULL(AT9000.OriginalAmount,0) + ISNULL(AT9000.VATOriginalAmount,0) AS OriginalAfterVATAmount, 
	ROUND(ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT9000.VATConvertedAmount,0),'+ cast(@ConvertedDecimals  AS nvarchar(10))+') AS ConvertedAfterVATAmount,
	A27.SourceNo as WSourceNo, CONVERT(NVARCHAR(10),A27.LimitDate,103) as WLimitDate, AT1302.I04ID, AT1015.AnaName as I04Name,
	AT1202.BankAccountNo as CusBankAccountNo ,
	(SELECT TOP 1 InvoiceSign  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentInvoiceSign,
	(SELECT TOP 1 Serial  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentSerial,
	Case 
	when isnull(DiscountRate,0)<>0 then 2 
	else 
		case 
		when isnull(AT9000.UnitPrice,0)=0 then 1 
		else 0 
		end
	end
	 as IsSum

	INTO #TEMP
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' and A01.AnaID=AT9000.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' and A02.AnaID=AT9000.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' and A03.AnaID=AT9000.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' and A04.AnaID=AT9000.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' and A05.AnaID=AT9000.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' and A06.AnaID=AT9000.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' and A07.AnaID=AT9000.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' and A08.AnaID=AT9000.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' and A09.AnaID=AT9000.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' and A10.AnaID=AT9000.Ana10ID
	LEFT JOIN AT1101 A11 WITH (NOLOCK) ON AT9000.DivisionID = A11.DivisionID
	LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A16.BankAccountID = A11.BankAccountID
	LEFT JOIN AT2006 A26 WITH (NOLOCK) ON AT9000.VoucherID = A26.VoucherID AND A26.KindVoucherID IN (4, 7, 10)
	LEFT JOIN AT1304 A13 WITH (NOLOCK) ON A13.UnitID = AT9000.ConvertedUnitID'
	SET @sSQL3a ='
	LEFT JOIN AT1205 A12 WITH (NOLOCK) ON A12.PaymentID = AT9000.PaymentID
	LEFT JOIN AT2007 A27 WITH (NOLOCK) ON A27.VoucherID = A26.VoucherID AND A27.TransactionID = AT9000.TransactionID 
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaTypeID = ''I04'' and AT1015.AnaID = AT1302.I04ID
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND AT9000.VoucherID = ''' + @VoucherID + ''' 
	AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
	-- AND A26.KindVoucherID IN (4, 7, 10)
	ORDER BY AT9000.Orders
	'

	SET @sSQL4 = '
		SELECT * FROM (
			SELECT	TOP 100 PERCENT Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail, CusTaxCode, Buyer, CusbankNo, PaymentMethod, 
				Total, DiscountAmount, AfterAmount,OriginalAfterAmount, VATAmount, VAT_Rate,
				ProdID, ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, Ana02ID, Ana02Name,
				DonDatHangSo, OriginalAmount, KindOfService, Extra1, VATAmount0,VATAmount5,VATAmount8, VATAmount10,GrossValue0,GrossValue5,GrossValue8, GrossValue10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
				 VoucherID, BatchID, TransactionID, TableID, TranMonth, TranYear, TransactionTypeID, ObjectID, CreditObjectID, VATNo,
				 VATObjectID, VATObjectName, VATObjectAddress, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice, OriginalAmountAT9000,
				 ConvertedAmount, ImTaxOriginalAmount, ImTaxConvertedAmount, ExpenseOriginalAmount, ExpenseConvertedAmount, IsStock, VoucherDate,
				 VoucherTypeID, VATGroupID, Serial, InvoiceNo, Orders, EmployeeID, SenderReceiver, SRDivisionName, SRAddress,
				 RefNo01, RefNo02, VDescription, BDescription, Quantity, InventoryID, UnitID, Status, IsAudit, IsCost,
				 Ana01ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, PeriodID,
				 ExpenseID, MaterialTypeID, ProductID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, OriginalAmountCN,
				 ExchangeRateCN, CurrencyIDCN, DueDays, DueDate, DiscountRate, OrderID, CreditBankAccountID, DebitBankAccountID,
				 CommissionPercent, InventoryName1, PaymentTermID, DiscountAmountAT9000, OTransactionID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
				 ReVoucherID, ReBatchID, ReTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06,
				 Parameter07, Parameter08, Parameter09, Parameter10, MOrderID, SOrderID, MTransactionID, STransactionID, RefVoucherNo,
				 IsLateInvoice, ConvertedQuantity, ConvertedPrice, ConvertedUnitID, ConversionFactor, UParameter01, UParameter02, UParameter03,
				 UParameter04, UParameter05, PriceListID, WOrderID, WTransactionID, MarkQuantity, TVoucherID, OldCounter, NewCounter,
				 OtherCounter, TBatchID, ContractDetailID, InvoiceCode, InvoiceSign, RefInfor, StandardPrice, StandardAmount, IsCom,
				 VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
				 DParameter07, DParameter08, DParameter09, DParameter10, InheritTableID, InheritVoucherID, InheritTransactionID, ETaxVoucherID,
				 ETaxID, ETaxConvertedUnit, ETaxConvertedAmount, ETaxTransactionID, AssignedSET, SETID, SETUnitID, SETTaxRate,
				 SETConvertedUnit, SETQuantity, SETOriginalAmount, SETConvertedAmount, SETConsistID, SETTransactionID, AssignedNRT, NRTTaxAmount,
				 NRTClassifyID, NRTUnitID, NRTTaxRate, NRTConvertedUnit, NRTQuantity, NRTOriginalAmount, NRTConvertedAmount, NRTConsistID,
				 NRTTransactionID, CreditObjectName, CreditVATNo, IsPOCost, TaxBaseAmount, WTCExchangeRate, WTCOperator, IsFACost,
				 IsInheritFA, InheritedFAVoucherID, AVRExchangeRate, PaymentExchangeRate, IsMultiExR, ExchangeRateDate, DiscountSalesAmount,
				 IsProInventoryID, InheritQuantity, DiscountPercentSOrder, DiscountAmountSOrder, IsWithhodingTax, IsSaleInvoice, WTTransID,
				 DiscountSaleAmountDetail, ABParameter01, ABParameter02, ABParameter03, ABParameter04, ABParameter05, ABParameter06,
				 ABParameter07, ABParameter08, ABParameter09, ABParameter10, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
				 IsVATWithhodingTax, VATWithhodingRate, IsEInvoice, EInvoiceStatus, IsAdvancePayment, Fkey, IsInheritInvoicePOS,
				 InheritInvoicePOS, IsInheritPayPOS, InheritPayPOS, IsInvoiceSuggest, RefVoucherDate, IsDeposit, ReTransactionTypeID,
				 ImVoucherID, ImTransactionID, SourceNo, LimitDate, IsPromotionItem, ObjectName1, TaxRateID, PayMethodID, DiscountedUnitPrice, 
				 ConvertedDiscountedUnitPrice, IsReceived, Ana01Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name,
				 BankAccountNo, BankName, ContactPerson, DVATOriginalAmount, DVATConvertedAmount, ConvertedUnitName, PaymentName, IsDiscount, DivisionNameE, AddressE, District, DContactPerson,
				 OriginalAfterVATAmount, ConvertedAfterVATAmount, WSourceNo, WLimitDate, I04ID, I04Name,
				 CusBankAccountNo, ParentInvoiceSign, ParentSerial, IsSum
			FROM #TEMP
			ORDER BY Remark
		) X
		-- ORDER BY Remark
	'
	
	
--DECLARE @param03 AS NVARCHAR(MAX), 
--		@param04 AS NVARCHAR(MAX),  
--		@param05 AS NVARCHAR(MAX)

--SET @param03 = (SELECT TOP 1 Parameter03 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter03,'') <> '')
--SET @param04 = (SELECT TOP 1 Parameter04 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter04,'') <> '') 
--SET @param05 = (SELECT TOP 1 Parameter05 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter05,'') <> '') 
 
--declare @prodName AS NVARCHAR(MAX)


--DECLARE @index INT = 0;
--WHILE @index < 1
--BEGIN 
--SET @prodName = ''
--IF @index = 0 
--	IF ISNULL(@param03, '') <> '' 
--			SET @prodName = @param03 
--	ELSE
--	BEGIN 
--		SET @index = @index + 1;
--		CONTINUE
--	END
--ELSE 
--IF @index = 1
--	IF ISNULL(@param04, '') <> '' 
--			SET @prodName = @param04 
--	ELSE 
--	BEGIN
--		SET @index = @index + 1;
--		CONTINUE
--	END
--ELSE
--IF @index = 2
--	IF ISNULL(@param05, '') <> '' 
--			SET @prodName = @param05
--	ELSE 
--	BEGIN
--		SET @index = @index + 1;
--		CONTINUE
--		END

IF EXISTS (SELECT TOP 1 Parameter03 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter03,'') <> '')
	SET @sSQL5 =' 
    UNION ALL
    SELECT	NULL AS Remark, NULL AS CusCode, NULL AS CusName, NULL AS CusAddress, NULL AS CusPhone, NULL AS CusEmail, NULL AS CusTaxCode, NULL AS Buyer, NULL AS CusbankNo, NULL AS PaymentMethod, 
				NULL AS Total, NULL AS DiscountAmount, NULL AS AfterAmount,NULL as OriginalAfterAmount, NULL AS VATAmount, NULL AS VAT_Rate,
				NULL AS ProdID, Parameter03  AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice, NULL AS Amount, NULL AS InheritFkey, NULL AS EInvoiceType, NULL AS TypeOfAdjust, NULL AS TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
				NULL AS DonDatHangSo, NULL AS OriginalAmount, NULL AS KindOfService, NULL AS Extra1, null as VATAmount0,null as VATAmount5,null as VATAmount8, null as VATAmount10,null as GrossValue0,null as GrossValue5,null as GrossValue8, null as GrossValue10, NULL AS Extra, NULL AS InvoiceDate, NULL AS CurrencyID, NULL AS PaymentID, NULL AS VoucherNo,
				 NULL AS VoucherID, NULL AS BatchID, NULL AS TransactionID, NULL AS TableID, NULL AS TranMonth, NULL AS TranYear, NULL AS TransactionTypeID, NULL AS ObjectID, NULL AS CreditObjectID, NULL AS VATNo,
				 NULL AS VATObjectID, NULL AS VATObjectName, NULL AS VATObjectAddress, NULL AS DebitAccountID, NULL AS CreditAccountID, NULL AS ExchangeRate, NULL AS UnitPrice, NULL AS OriginalAmountAT9000,
				 NULL AS ConvertedAmount, NULL AS ImTaxOriginalAmount, NULL AS ImTaxConvertedAmount, NULL AS ExpenseOriginalAmount, NULL AS ExpenseConvertedAmount, NULL AS IsStock, NULL AS VoucherDate,
				 NULL AS VoucherTypeID, NULL AS VATGroupID, NULL AS Serial, NULL AS InvoiceNo, NULL AS Orders, NULL AS EmployeeID, NULL AS SenderReceiver, NULL AS SRDivisionName, NULL AS SRAddress,
				 NULL AS RefNo01, NULL AS RefNo02, NULL AS VDescription, NULL AS BDescription, NULL AS Quantity, NULL AS InventoryID, NULL AS UnitID, NULL AS Status, NULL AS IsAudit, NULL AS IsCost,
				 NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, NULL AS PeriodID,
				 NULL AS ExpenseID, NULL AS MaterialTypeID, NULL AS ProductID, NULL AS CreateDate, NULL AS CreateUserID, NULL AS LastModifyUserID, NULL AS LastModifyDate, NULL AS OriginalAmountCN,
				 NULL AS ExchangeRateCN, NULL AS CurrencyIDCN, NULL AS DueDays, NULL AS DueDate, NULL AS DiscountRate, NULL AS OrderID, NULL AS CreditBankAccountID, NULL AS DebitBankAccountID,
				 NULL AS CommissionPercent, NULL AS InventoryName1, NULL AS PaymentTermID, NULL AS DiscountAmountAT9000, NULL AS OTransactionID, NULL AS IsMultiTax, NULL AS VATOriginalAmount, NULL AS VATConvertedAmount,
				 NULL AS ReVoucherID, NULL AS ReBatchID, NULL AS ReTransactionID, NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, NULL AS Parameter06,
				 NULL AS Parameter07, NULL AS Parameter08, NULL AS Parameter09, NULL AS Parameter10, NULL AS MOrderID, NULL AS SOrderID, NULL AS MTransactionID, NULL AS STransactionID, NULL AS RefVoucherNo,
				 NULL AS IsLateInvoice, NULL AS ConvertedQuantity, NULL AS ConvertedPrice, NULL AS ConvertedUnitID, NULL AS ConversionFactor, NULL AS UParameter01, NULL AS UParameter02, NULL AS UParameter03,
				 NULL AS UParameter04, NULL AS UParameter05, NULL AS PriceListID, NULL AS WOrderID, NULL AS WTransactionID, NULL AS MarkQuantity, NULL AS TVoucherID, NULL AS OldCounter, NULL AS NewCounter,
				 NULL AS OtherCounter, NULL AS TBatchID, NULL AS ContractDetailID, NULL AS InvoiceCode, NULL AS InvoiceSign, NULL AS RefInfor, NULL AS StandardPrice, NULL AS StandardAmount, NULL AS IsCom,
				 NULL AS VirtualPrice, NULL AS VirtualAmount, NULL AS ReTableID, NULL AS DParameter01, NULL AS DParameter02, NULL AS DParameter03, NULL AS DParameter04, NULL AS DParameter05, NULL AS DParameter06,
				 NULL AS DParameter07, NULL AS DParameter08, NULL AS DParameter09, NULL AS DParameter10, NULL AS InheritTableID, NULL AS InheritVoucherID, NULL AS InheritTransactionID, NULL AS ETaxVoucherID,
				 NULL AS ETaxID, NULL AS ETaxConvertedUnit, NULL AS ETaxConvertedAmount, NULL AS ETaxTransactionID, NULL AS AssignedSET, NULL AS SETID, NULL AS SETUnitID, NULL AS SETTaxRate,
				 NULL AS SETConvertedUnit, NULL AS SETQuantity, NULL AS SETOriginalAmount, NULL AS SETConvertedAmount, NULL AS SETConsistID, NULL AS SETTransactionID, NULL AS AssignedNRT, NULL AS NRTTaxAmount,
				 NULL AS NRTClassifyID, NULL AS NRTUnitID, NULL AS NRTTaxRate, NULL AS NRTConvertedUnit, NULL AS NRTQuantity, NULL AS NRTOriginalAmount, NULL AS NRTConvertedAmount, NULL AS NRTConsistID,
				 NULL AS NRTTransactionID, NULL AS CreditObjectName, NULL AS CreditVATNo, NULL AS IsPOCost, NULL AS TaxBaseAmount, NULL AS WTCExchangeRate, NULL AS WTCOperator, NULL AS IsFACost,
				 NULL AS IsInheritFA, NULL AS InheritedFAVoucherID, NULL AS AVRExchangeRate, NULL AS PaymentExchangeRate, NULL AS IsMultiExR, NULL AS ExchangeRateDate, NULL AS DiscountSalesAmount,
				 NULL AS IsProInventoryID, NULL AS InheritQuantity, NULL AS DiscountPercentSOrder, NULL AS DiscountAmountSOrder, NULL AS IsWithhodingTax, NULL AS IsSaleInvoice, NULL AS WTTransID,
				 NULL AS DiscountSaleAmountDetail, NULL AS ABParameter01, NULL AS ABParameter02, NULL AS ABParameter03, NULL AS ABParameter04, NULL AS ABParameter05, NULL AS ABParameter06,
				 NULL AS ABParameter07, NULL AS ABParameter08, NULL AS ABParameter09, NULL AS ABParameter10, NULL AS SOAna01ID, NULL AS SOAna02ID, NULL AS SOAna03ID, NULL AS SOAna04ID, NULL AS SOAna05ID,
				 NULL AS IsVATWithhodingTax, NULL AS VATWithhodingRate, NULL AS IsEInvoice, NULL AS EInvoiceStatus, NULL AS IsAdvancePayment, NULL AS Fkey, NULL AS IsInheritInvoicePOS,
				 NULL AS InheritInvoicePOS, NULL AS IsInheritPayPOS, NULL AS InheritPayPOS, NULL AS IsInvoiceSuggest, NULL AS RefVoucherDate, NULL AS IsDeposit, NULL AS ReTransactionTypeID,
				 NULL AS ImVoucherID, NULL AS ImTransactionID, NULL AS SourceNo, NULL AS LimitDate, NULL AS IsPromotionItem, NULL AS ObjectName1, NULL AS TaxRateID, NULL AS PayMethodID, NULL AS DiscountedUnitPrice, 
				 NULL AS ConvertedDiscountedUnitPrice, NULL AS IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
				 NULL AS BankAccountNo, NULL AS BankName, NULL AS ContactPerson, NULL AS DVATOriginalAmount, NULL AS DVATConvertedAmount, NULL AS ConvertedUnitName, NULL AS PaymentName, NULL AS IsDiscount, NULL AS DivisionNameE, NULL AS AddressE, NULL AS District, NULL AS DContactPerson,
				 NULL AS OriginalAfterVATAmount, NULL AS ConvertedAfterVATAmount, NULL AS WSourceNo, NULL AS WLimitDate, NULL AS I04ID, NULL AS I04Name,
				 NULL AS CusBankAccountNo,NULL AS ParentInvoiceSign,NULL AS ParentSerial, 4 as IsSum	
		FROM #TEMP
		GROUP BY Parameter03
		' 
    --SET @index = @index + 1

--END
IF EXISTS (SELECT TOP 1 Parameter04 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter04,'') <> '')
	SET @sSQL6 =' 
    UNION ALL 
	SELECT * FROM (
    SELECT	NULL AS Remark, NULL AS CusCode, NULL AS CusName, NULL AS CusAddress, NULL AS CusPhone, NULL AS CusEmail, NULL AS CusTaxCode, NULL AS Buyer, NULL AS CusbankNo, NULL AS PaymentMethod, 
				NULL AS Total, NULL AS DiscountAmount, NULL AS AfterAmount, NULL as OriginalAfterAmount,NULL AS VATAmount, NULL AS VAT_Rate,
				NULL AS ProdID, Parameter04  AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice, NULL AS Amount, NULL AS InheritFkey, NULL AS EInvoiceType, NULL AS TypeOfAdjust, NULL AS TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
				NULL AS DonDatHangSo, NULL AS OriginalAmount, NULL AS KindOfService, NULL AS Extra1, null as VATAmount0,null as VATAmount5,null as VATAmount8, null as VATAmount10,null as GrossValue0, NULL AS Extra, NULL AS InvoiceDate, NULL AS CurrencyID, NULL AS PaymentID, NULL AS VoucherNo,
				 NULL AS VoucherID, NULL AS BatchID, NULL AS TransactionID, NULL AS TableID, NULL AS TranMonth, NULL AS TranYear, NULL AS TransactionTypeID, NULL AS ObjectID, NULL AS CreditObjectID, NULL AS VATNo,
				 NULL AS VATObjectID, NULL AS VATObjectName, NULL AS VATObjectAddress, NULL AS DebitAccountID, NULL AS CreditAccountID, NULL AS ExchangeRate, NULL AS UnitPrice, NULL AS OriginalAmountAT9000,
				 NULL AS ConvertedAmount, NULL AS ImTaxOriginalAmount, NULL AS ImTaxConvertedAmount, NULL AS ExpenseOriginalAmount, NULL AS ExpenseConvertedAmount, NULL AS IsStock, NULL AS VoucherDate,
				 NULL AS VoucherTypeID, NULL AS VATGroupID, NULL AS Serial, NULL AS InvoiceNo, NULL AS Orders, NULL AS EmployeeID, NULL AS SenderReceiver, NULL AS SRDivisionName, NULL AS SRAddress,
				 NULL AS RefNo01, NULL AS RefNo02, NULL AS VDescription, NULL AS BDescription, NULL AS Quantity, NULL AS InventoryID, NULL AS UnitID, NULL AS Status, NULL AS IsAudit, NULL AS IsCost,
				 NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, NULL AS PeriodID,
				 NULL AS ExpenseID, NULL AS MaterialTypeID, NULL AS ProductID, NULL AS CreateDate, NULL AS CreateUserID, NULL AS LastModifyUserID, NULL AS LastModifyDate, NULL AS OriginalAmountCN,
				 NULL AS ExchangeRateCN, NULL AS CurrencyIDCN, NULL AS DueDays, NULL AS DueDate, NULL AS DiscountRate, NULL AS OrderID, NULL AS CreditBankAccountID, NULL AS DebitBankAccountID,
				 NULL AS CommissionPercent, NULL AS InventoryName1, NULL AS PaymentTermID, NULL AS DiscountAmountAT9000, NULL AS OTransactionID, NULL AS IsMultiTax, NULL AS VATOriginalAmount, NULL AS VATConvertedAmount,
				 NULL AS ReVoucherID, NULL AS ReBatchID, NULL AS ReTransactionID, NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, NULL AS Parameter06,
				 NULL AS Parameter07, NULL AS Parameter08, NULL AS Parameter09, NULL AS Parameter10, NULL AS MOrderID, NULL AS SOrderID, NULL AS MTransactionID, NULL AS STransactionID, NULL AS RefVoucherNo,
				 NULL AS IsLateInvoice, NULL AS ConvertedQuantity, NULL AS ConvertedPrice, NULL AS ConvertedUnitID, NULL AS ConversionFactor, NULL AS UParameter01, NULL AS UParameter02, NULL AS UParameter03,
				 NULL AS UParameter04, NULL AS UParameter05, NULL AS PriceListID, NULL AS WOrderID, NULL AS WTransactionID, NULL AS MarkQuantity, NULL AS TVoucherID, NULL AS OldCounter, NULL AS NewCounter,
				 NULL AS OtherCounter, NULL AS TBatchID, NULL AS ContractDetailID, NULL AS InvoiceCode, NULL AS InvoiceSign, NULL AS RefInfor, NULL AS StandardPrice, NULL AS StandardAmount, NULL AS IsCom,
				 NULL AS VirtualPrice, NULL AS VirtualAmount, NULL AS ReTableID, NULL AS DParameter01, NULL AS DParameter02, NULL AS DParameter03, NULL AS DParameter04, NULL AS DParameter05, NULL AS DParameter06,
				 NULL AS DParameter07, NULL AS DParameter08, NULL AS DParameter09, NULL AS DParameter10, NULL AS InheritTableID, NULL AS InheritVoucherID, NULL AS InheritTransactionID, NULL AS ETaxVoucherID,
				 NULL AS ETaxID, NULL AS ETaxConvertedUnit, NULL AS ETaxConvertedAmount, NULL AS ETaxTransactionID, NULL AS AssignedSET, NULL AS SETID, NULL AS SETUnitID, NULL AS SETTaxRate,
				 NULL AS SETConvertedUnit, NULL AS SETQuantity, NULL AS SETOriginalAmount, NULL AS SETConvertedAmount, NULL AS SETConsistID, NULL AS SETTransactionID, NULL AS AssignedNRT, NULL AS NRTTaxAmount,
				 NULL AS NRTClassifyID, NULL AS NRTUnitID, NULL AS NRTTaxRate, NULL AS NRTConvertedUnit, NULL AS NRTQuantity, NULL AS NRTOriginalAmount, NULL AS NRTConvertedAmount, NULL AS NRTConsistID,
				 NULL AS NRTTransactionID, NULL AS CreditObjectName, NULL AS CreditVATNo, NULL AS IsPOCost, NULL AS TaxBaseAmount, NULL AS WTCExchangeRate, NULL AS WTCOperator, NULL AS IsFACost,
				 NULL AS IsInheritFA, NULL AS InheritedFAVoucherID, NULL AS AVRExchangeRate, NULL AS PaymentExchangeRate, NULL AS IsMultiExR, NULL AS ExchangeRateDate, NULL AS DiscountSalesAmount,
				 NULL AS IsProInventoryID, NULL AS InheritQuantity, NULL AS DiscountPercentSOrder, NULL AS DiscountAmountSOrder, NULL AS IsWithhodingTax, NULL AS IsSaleInvoice, NULL AS WTTransID,
				 NULL AS DiscountSaleAmountDetail, NULL AS ABParameter01, NULL AS ABParameter02, NULL AS ABParameter03, NULL AS ABParameter04, NULL AS ABParameter05, NULL AS ABParameter06,
				 NULL AS ABParameter07, NULL AS ABParameter08, NULL AS ABParameter09, NULL AS ABParameter10, NULL AS SOAna01ID, NULL AS SOAna02ID, NULL AS SOAna03ID, NULL AS SOAna04ID, NULL AS SOAna05ID,
				 NULL AS IsVATWithhodingTax, NULL AS VATWithhodingRate, NULL AS IsEInvoice, NULL AS EInvoiceStatus, NULL AS IsAdvancePayment, NULL AS Fkey, NULL AS IsInheritInvoicePOS,
				 NULL AS InheritInvoicePOS, NULL AS IsInheritPayPOS, NULL AS InheritPayPOS, NULL AS IsInvoiceSuggest, NULL AS RefVoucherDate, NULL AS IsDeposit, NULL AS ReTransactionTypeID,
				 NULL AS ImVoucherID, NULL AS ImTransactionID, NULL AS SourceNo, NULL AS LimitDate, NULL AS IsPromotionItem, NULL AS ObjectName1, NULL AS TaxRateID, NULL AS PayMethodID, NULL AS DiscountedUnitPrice, 
				 NULL AS ConvertedDiscountedUnitPrice, NULL AS IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
				 NULL AS BankAccountNo, NULL AS BankName, NULL AS ContactPerson, NULL AS DVATOriginalAmount, NULL AS DVATConvertedAmount, NULL AS ConvertedUnitName, NULL AS PaymentName, NULL AS IsDiscount, NULL AS DivisionNameE, NULL AS AddressE, NULL AS District, NULL AS DContactPerson,
				 NULL AS OriginalAfterVATAmount, NULL AS ConvertedAfterVATAmount, NULL AS WSourceNo, NULL AS WLimitDate, NULL AS I04ID, NULL AS I04Name,
				 NULL AS CusBankAccountNo,NULL AS ParentInvoiceSign,NULL AS ParentSerial, 4 as IsSum
		FROM #TEMP
		GROUP BY Parameter04) Y
		' 
IF EXISTS (SELECT TOP 1 Parameter05 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter05,'') <> '')
	SET @sSQL7 =' 
    UNION ALL 
	SELECT * FROM (
    SELECT	NULL AS Remark, NULL AS CusCode, NULL AS CusName, NULL AS CusAddress, NULL AS CusPhone, NULL AS CusEmail, NULL AS CusTaxCode, NULL AS Buyer, NULL AS CusbankNo, NULL AS PaymentMethod, 
				NULL AS Total, NULL AS DiscountAmount, NULL AS AfterAmount, NULL AS OriginalAfterAmount, NULL AS VATAmount, NULL AS VAT_Rate,
				NULL AS ProdID, Parameter05  AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice, NULL AS Amount, NULL AS InheritFkey, NULL AS EInvoiceType, NULL AS TypeOfAdjust, NULL AS TDescription, NULL AS Ana02ID, NULL AS Ana02Name,
				NULL AS DonDatHangSo, NULL AS OriginalAmount, NULL AS KindOfService, NULL AS Extra1, null as VATAmount0,null as VATAmount5,null as VATAmount8, null as VATAmount10,null as GrossValue0, null as GrossValue5, null as GrossValue8, null as GrossValue10, NULL AS Extra, NULL AS InvoiceDate, NULL AS CurrencyID, NULL AS PaymentID, NULL AS VoucherNo,
				 NULL AS VoucherID, NULL AS BatchID, NULL AS TransactionID, NULL AS TableID, NULL AS TranMonth, NULL AS TranYear, NULL AS TransactionTypeID, NULL AS ObjectID, NULL AS CreditObjectID, NULL AS VATNo,
				 NULL AS VATObjectID, NULL AS VATObjectName, NULL AS VATObjectAddress, NULL AS DebitAccountID, NULL AS CreditAccountID, NULL AS ExchangeRate, NULL AS UnitPrice, NULL AS OriginalAmountAT9000,
				 NULL AS ConvertedAmount, NULL AS ImTaxOriginalAmount, NULL AS ImTaxConvertedAmount, NULL AS ExpenseOriginalAmount, NULL AS ExpenseConvertedAmount, NULL AS IsStock, NULL AS VoucherDate,
				 NULL AS VoucherTypeID, NULL AS VATGroupID, NULL AS Serial, NULL AS InvoiceNo, NULL AS Orders, NULL AS EmployeeID, NULL AS SenderReceiver, NULL AS SRDivisionName, NULL AS SRAddress,
				 NULL AS RefNo01, NULL AS RefNo02, NULL AS VDescription, NULL AS BDescription, NULL AS Quantity, NULL AS InventoryID, NULL AS UnitID, NULL AS Status, NULL AS IsAudit, NULL AS IsCost,
				 NULL AS Ana01ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID, NULL AS PeriodID,
				 NULL AS ExpenseID, NULL AS MaterialTypeID, NULL AS ProductID, NULL AS CreateDate, NULL AS CreateUserID, NULL AS LastModifyUserID, NULL AS LastModifyDate, NULL AS OriginalAmountCN,
				 NULL AS ExchangeRateCN, NULL AS CurrencyIDCN, NULL AS DueDays, NULL AS DueDate, NULL AS DiscountRate, NULL AS OrderID, NULL AS CreditBankAccountID, NULL AS DebitBankAccountID,
				 NULL AS CommissionPercent, NULL AS InventoryName1, NULL AS PaymentTermID, NULL AS DiscountAmountAT9000, NULL AS OTransactionID, NULL AS IsMultiTax, NULL AS VATOriginalAmount, NULL AS VATConvertedAmount,
				 NULL AS ReVoucherID, NULL AS ReBatchID, NULL AS ReTransactionID, NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, NULL AS Parameter06,
				 NULL AS Parameter07, NULL AS Parameter08, NULL AS Parameter09, NULL AS Parameter10, NULL AS MOrderID, NULL AS SOrderID, NULL AS MTransactionID, NULL AS STransactionID, NULL AS RefVoucherNo,
				 NULL AS IsLateInvoice, NULL AS ConvertedQuantity, NULL AS ConvertedPrice, NULL AS ConvertedUnitID, NULL AS ConversionFactor, NULL AS UParameter01, NULL AS UParameter02, NULL AS UParameter03,
				 NULL AS UParameter04, NULL AS UParameter05, NULL AS PriceListID, NULL AS WOrderID, NULL AS WTransactionID, NULL AS MarkQuantity, NULL AS TVoucherID, NULL AS OldCounter, NULL AS NewCounter,
				 NULL AS OtherCounter, NULL AS TBatchID, NULL AS ContractDetailID, NULL AS InvoiceCode, NULL AS InvoiceSign, NULL AS RefInfor, NULL AS StandardPrice, NULL AS StandardAmount, NULL AS IsCom,
				 NULL AS VirtualPrice, NULL AS VirtualAmount, NULL AS ReTableID, NULL AS DParameter01, NULL AS DParameter02, NULL AS DParameter03, NULL AS DParameter04, NULL AS DParameter05, NULL AS DParameter06,
				 NULL AS DParameter07, NULL AS DParameter08, NULL AS DParameter09, NULL AS DParameter10, NULL AS InheritTableID, NULL AS InheritVoucherID, NULL AS InheritTransactionID, NULL AS ETaxVoucherID,
				 NULL AS ETaxID, NULL AS ETaxConvertedUnit, NULL AS ETaxConvertedAmount, NULL AS ETaxTransactionID, NULL AS AssignedSET, NULL AS SETID, NULL AS SETUnitID, NULL AS SETTaxRate,
				 NULL AS SETConvertedUnit, NULL AS SETQuantity, NULL AS SETOriginalAmount, NULL AS SETConvertedAmount, NULL AS SETConsistID, NULL AS SETTransactionID, NULL AS AssignedNRT, NULL AS NRTTaxAmount,
				 NULL AS NRTClassifyID, NULL AS NRTUnitID, NULL AS NRTTaxRate, NULL AS NRTConvertedUnit, NULL AS NRTQuantity, NULL AS NRTOriginalAmount, NULL AS NRTConvertedAmount, NULL AS NRTConsistID,
				 NULL AS NRTTransactionID, NULL AS CreditObjectName, NULL AS CreditVATNo, NULL AS IsPOCost, NULL AS TaxBaseAmount, NULL AS WTCExchangeRate, NULL AS WTCOperator, NULL AS IsFACost,
				 NULL AS IsInheritFA, NULL AS InheritedFAVoucherID, NULL AS AVRExchangeRate, NULL AS PaymentExchangeRate, NULL AS IsMultiExR, NULL AS ExchangeRateDate, NULL AS DiscountSalesAmount,
				 NULL AS IsProInventoryID, NULL AS InheritQuantity, NULL AS DiscountPercentSOrder, NULL AS DiscountAmountSOrder, NULL AS IsWithhodingTax, NULL AS IsSaleInvoice, NULL AS WTTransID,
				 NULL AS DiscountSaleAmountDetail, NULL AS ABParameter01, NULL AS ABParameter02, NULL AS ABParameter03, NULL AS ABParameter04, NULL AS ABParameter05, NULL AS ABParameter06,
				 NULL AS ABParameter07, NULL AS ABParameter08, NULL AS ABParameter09, NULL AS ABParameter10, NULL AS SOAna01ID, NULL AS SOAna02ID, NULL AS SOAna03ID, NULL AS SOAna04ID, NULL AS SOAna05ID,
				 NULL AS IsVATWithhodingTax, NULL AS VATWithhodingRate, NULL AS IsEInvoice, NULL AS EInvoiceStatus, NULL AS IsAdvancePayment, NULL AS Fkey, NULL AS IsInheritInvoicePOS,
				 NULL AS InheritInvoicePOS, NULL AS IsInheritPayPOS, NULL AS InheritPayPOS, NULL AS IsInvoiceSuggest, NULL AS RefVoucherDate, NULL AS IsDeposit, NULL AS ReTransactionTypeID,
				 NULL AS ImVoucherID, NULL AS ImTransactionID, NULL AS SourceNo, NULL AS LimitDate, NULL AS IsPromotionItem, NULL AS ObjectName1, NULL AS TaxRateID, NULL AS PayMethodID, NULL AS DiscountedUnitPrice, 
				 NULL AS ConvertedDiscountedUnitPrice, NULL AS IsReceived, NULL AS Ana01Name, NULL AS Ana03Name, NULL AS Ana04Name, NULL AS Ana05Name, NULL AS Ana06Name, NULL AS Ana07Name, NULL AS Ana08Name, NULL AS Ana09Name, NULL AS Ana10Name,
				 NULL AS BankAccountNo, NULL AS BankName, NULL AS ContactPerson, NULL AS DVATOriginalAmount, NULL AS DVATConvertedAmount, NULL AS ConvertedUnitName, NULL AS PaymentName, NULL AS IsDiscount, NULL AS DivisionNameE, NULL AS AddressE, NULL AS District, NULL AS DContactPerson,
				 NULL AS OriginalAfterVATAmount, NULL AS ConvertedAfterVATAmount, NULL AS WSourceNo, NULL AS WLimitDate, NULL AS I04ID, NULL AS I04Name,
				 NULL AS CusBankAccountNo,NULL AS ParentInvoiceSign,NULL AS ParentSerial, 4 as IsSum
		FROM #TEMP
		GROUP BY Parameter05) Z
		' 



END

print (@sSQL)
print (@sSQL1)
print(@sSQL2)
print(@sSQL3)
print(@sSQL3a)
print(@sSQL4)
print(@sSQL5)
print(@sSQL6)
print(@sSQL7)

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL3a+@sSQL4+@sSQL5+@sSQL6+@sSQL7)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
