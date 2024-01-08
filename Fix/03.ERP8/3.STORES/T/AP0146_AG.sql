IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- AP0146
-- <Summary>
---- Stored load dữ liệu hóa đơn phục vụ phát hành hóa đơn điện tử
---- Created on 16/08/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Bảo Thy on 11/12/2017: Lấy thông tin địa chỉ, mã số thuế từ Đơn hàng bán (http://192.168.0.204:8069/web#id=6353&view_type=form&model=crm.helpdesk&action=423)
---- Modified by Kim Thư on 04/05/2019: Bổ sung trường hợp hóa đơn hàng biếu tặng (VoucherTypeID = HD8 - @sSQL21)
---- Modified by Huỳnh Thử on 25/09/2020: Xuất hóa hơn điện tử GTGT xuất khẩu (VoucherTypeID = 'HD2')
---- Modified by Huỳnh Thử on 23/10/2020: Sửa cách lấy dữ liệu xuất hóa đơn VCNB
---- Modified by Huỳnh Thử on 28/10/2020: Bổ sung phân cách tiền USD, tên đối tượng nhận hàng
---- Modified by Huỳnh Thử on 19/11/2020: Bổ sung CurrencyID all, ExchangeRate In VoucherType (HD2 và TL3)
---- Modified by Huỳnh Thử on 14/12/2020: Những dòng cùng mã hàng gom lại thành 1 dòng, số lượng = tổng các dòng.
---- Modified by Huỳnh Thử on 20/07/2021: Load InventoryName1
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


-- <Example>
---- EXEC AP0146 @DivisionID = 'ANG',@UserID='ASOFTADMIN',@VoucherID='AV561ee05d-44de-4d71-8e4c-4927876f60df'

CREATE PROCEDURE [dbo].[AP0146_AG]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1 AS NVARCHAR(MAX) = '',
		@sSQL2 AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',		
		@sSQL4 AS NVARCHAR(MAX) = '',	
		@sSQL5 AS NVARCHAR(MAX) = '',	
		@sSQL6 AS NVARCHAR(MAX) = '',	
		@sSQL7 AS NVARCHAR(MAX) = '',				
		@sSQL8 AS NVARCHAR(MAX) = '',	
		@sSQL9 AS NVARCHAR(MAX) = '',	
		@sSQL10 AS NVARCHAR(MAX) = '',	
		@sSQL11 AS NVARCHAR(MAX) = '',	
		@sSQL12 AS NVARCHAR(MAX) = '',	
		@sSQL13 AS NVARCHAR(MAX) = '',	
		@sSQL14 AS NVARCHAR(MAX) = '',	
		@sSQL15 AS NVARCHAR(MAX) = '',	
		@sSQL16 AS NVARCHAR(MAX) = '',			
		@sSQL17 AS NVARCHAR(MAX) = '',			
		@sSQL18 AS NVARCHAR(MAX) = '',	
		@sSQL19 AS NVARCHAR(MAX) = '',	
		@sSQL20 AS NVARCHAR(MAX) = '',		
		@sSQL21 AS NVARCHAR(MAX) = '',	
		@sSQL22 AS NVARCHAR(MAX) = '',	
		@Uni AS NVARCHAR(100),										
		@CustomerName INT,
		@VoucherTypeID AS NVARCHAR(50),
		@KindVoucherID INT ,
		@SSQLTAM NVARCHAR(max)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 		

SET @KindVoucherID = (SELECT KindVoucherID FROM AT2006 WHERE VoucherID = @VoucherID)

IF @CustomerName = 57 --- In theo mẫu hóa đơn theo yêu cầu của ANGEL
BEGIN
	IF @KindVoucherID = 3 or @KindVoucherID = 2

	BEGIN
		SET @SSQLTAM = 'SELECT *
						INTO #TAM 
						FROM AT2007 WHERE Voucherid = '''+@VOUCHERID+''' AND DIVISIONID ='''+@DIVISIONID+''''
		SET @sSQL = '  
		

		SELECT  ROW_NUMBER() OVER(ORDER BY A.Orders) AS Remark, * FROM (
			SELECT 
			(SELECT TOP 1 orders FROM #TAM  WHERE InventoryID= A07.InventoryID order by orders) As orders, 
			A02_2.ObjectName AS CusCode, A11.DivisionName AS CusName, (SELECT TOP 1 Notes03 FROM #TAM order by Notes03 DESC) AS Buyer
			, A03_2.Address as CusAddress, Format(A06.VoucherDate,''dd/MM/yyyy'') as CusPhone
			, (ISNULL(A11.VATNo,'''') + '';''+ ISNULL((SELECT TOP 1 Notes10 FROM #TAM order by Notes10 DESC),'''')) as CusTaxCode
			, (SELECT TOP 1 Notes09 FROM #TAM order by Notes09 DESC) + '' - '' + (SELECT TOP 1 Notes04 FROM #TAM order by Notes04 DESC) AS PaymentMethod
			, (SELECT TOP 1 Notes07 FROM #TAM order by Notes07 DESC) AS CusBankNo
			, (SELECT TOP 1 Notes08 FROM #TAM order by Notes08 DESC) AS CusBankName
			, NULL AS Warehouse, NULL AS ShippingNo, A06.VoucherDate AS ShippingDate, ISnull(A03.Address,'''') AS Extra, A07.CurrencyID AS Extra1, NULL AS SoXe, NULL AS HopDongSo,
			NULL AS SoVT, A06.WarehouseID AS ImWarehouseID, A03.WarehouseName AS ImWarehouseName
			, (CASE WHEN A06.KindVoucherID = 3 THEN A06.WarehouseID2 ELSE '''' END) AS ExWarehouseID  
			, (CASE WHEN A06.KindVoucherID = 3 THEN A03_2.WarehouseName ELSE A06.RDAddress END) AS ExWarehouseName
			, A06.VoucherDate AS ContractDate,
			A06.VoucherDate AS ImportDate, (SELECT SUM(ActualQuantity) FROM AT2007 WHERE VoucherID = '''+@VoucherID+''') AS Total, NULL AS VATRate, 0 AS VATAmount,
			(SELECT SUM(ConvertedAmount) FROM AT2007 WHERE VoucherID = '''+@VoucherID+''') AS Amount, NULL AS ArisingDate, A04.InventoryName AS ProdName, 
			A07.InventoryID AS ProdID, A05.UnitName AS ProdUnit, SUm(A07.ActualQuantity) AS ProdQuantity, A07.Unitprice AS ProdPrice,
			ISNULL((SELECT SUM(ABS(T07.ConvertedAmount)) FROM AT2007 T07 WITH (NOLOCK) WHERE T07.DivisionID = A06.DivisionID AND T07.VoucherID = A06.VoucherID), 0) AS AfterAmount,
			A06.VoucherID, A06.TranMonth, A06.TranYear, A06.VoucherTypeID, A06.VoucherNo, A06.VoucherDate, A06.ObjectID, A02.ObjectName, A06.WarehouseID, A03.WarehouseName,
			A06.WarehouseID2, A03_2.WarehouseName AS WarehouseName2, A06.ProjectID, A06.OrderID, A06.BatchID, A06.ReDeTypeID, A06.KindVoucherID, A06.Status, A06.EmployeeID, A06.Description,
			A06.CreateDate, A06.CreateUserID, A06.LastModifyUserID, A06.LastModifyDate, A06.RefNo01, A06.RefNo02, A06.RDAddress, A06.ContactPerson, A06.VATObjectName, A06.InventoryTypeID, 
			A06.IsGoodsFirstVoucher, A06.MOrderID, A06.ApportionID, A06.EVoucherID, A06.IsGoodsRecycled, A06.IsVoucher, A06.ImVoucherID, A06.ReVoucherID,
			A06.SParameter01, A06.SParameter02, A06.SParameter03, A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, A06.SParameter08, A06.SParameter09, A06.SParameter10, 
			A06.SParameter11, A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15, A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, A06.SParameter20, 
			A06.RouteID, A06.InTime, A06.OutTime, A06.DeliveryEmployeeID, A06.DeliveryStatus, A06.IsWeb, A06.CashierID, A06.CashierTime, A06.IsDeposit, A06.ObjectShipID, 
			A06.IsReturn, 
			A07.InventoryID, A04.InventoryName, A07.UnitID, A05.UnitName, Sum(A07.ActualQuantity) AS ActualQuantity, A07.Unitprice, A07.OriginalAmount, A07.ConvertedAmount
			, (SELECT TOP 1 Notes FROM #TAM order by Notes DESC) AS NOTES
			, A07.CurrencyID, A07.ExchangeRate, A07.SaleUnitPrice,
			A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.DebitAccountID, A07.CreditAccountID, A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.ConversionFactor, A07.ReTransactionID,
			A07.ReVoucherID AS ReVoucherID_AT2007, A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID,(SELECT REPLACE (A07.Ana08ID,''-'+@DivisionID+''','''' )) as Ana08ID, A07.Ana09ID, A07.Ana10ID,
			A07.PeriodID, A07.ProductID, A07.OrderID AS OrderID_AT2007
			'
		SET @sSQL1=N'
			, A07.InventoryName1, A07.OTransactionID, A07.ReSPVoucherID, A07.ReSPTransactionID, A07.ETransactionID, A07.MTransactionID,
			A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, Sum(A07.ConvertedQuantity) AS ConvertedQuantity, A07.ConvertedPrice, A07.ConvertedUnitID, A07.MOrderID as MOrderID_AT2007,
			A07.SOrderID, A07.STransactionID, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID, sum(A07.MarkQuantity) AS MarkQuantity, A07.OExpenseConvertedAmount, 
			A07.WVoucherID
			, (SELECT TOP 1 Notes01 FROM #TAM order by Notes01 DESC) AS Notes01
			, (SELECT TOP 1 Notes02 FROM #TAM order by Notes02 DESC) AS Notes02
			, (SELECT TOP 1 Notes03 FROM #TAM order by Notes03 DESC) AS Notes03
			, (SELECT TOP 1 Notes04 FROM #TAM order by Notes04 DESC) AS Notes04
			, (SELECT TOP 1 Notes05 FROM #TAM order by Notes05 DESC) AS Notes05
			, (SELECT TOP 1 Notes06 FROM #TAM order by Notes06 DESC) AS Notes06
			, (SELECT TOP 1 Notes07 FROM #TAM order by Notes07 DESC) AS Notes07
			, (SELECT TOP 1 Notes08 FROM #TAM order by Notes08 DESC) AS Notes08
			, (SELECT TOP 1 Notes09 FROM #TAM order by Notes09 DESC) AS Notes09
			, (SELECT TOP 1 Notes10 FROM #TAM order by Notes10 DESC) AS Notes10
			, (SELECT TOP 1 Notes11 FROM #TAM order by Notes11 DESC) AS Notes11
			, (SELECT TOP 1 Notes12 FROM #TAM order by Notes12 DESC) AS Notes12
			, (SELECT TOP 1 Notes13 FROM #TAM order by Notes13 DESC) AS Notes13
			, (SELECT TOP 1 Notes14 FROM #TAM order by Notes14 DESC) AS Notes14
			, (SELECT TOP 1 Notes15 FROM #TAM order by Notes15 DESC) AS Notes15
			,
			A07.RefInfor, A07.StandardPrice, A07.StandardAmount, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID, A07.TVoucherID, A07.SOrderIDRecognition,
			A16.BankAccountNo, A16.BankName, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson
			FROM AT2006 A06 WITH (NOLOCK) INNER JOIN AT2007 A07 WITH (NOLOCK) ON A06.VoucherID = A07.VoucherID
			LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectID = A02.ObjectID
			LEFT JOIN AT1202 A02_2 WITH (NOLOCK) ON A02_2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectShipID = A02_2.ObjectID
			LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID = A03.WarehouseID
			LEFT JOIN AT1303 A03_2 WITH (NOLOCK) ON A03_2.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID2 = A03_2.WarehouseID
			LEFT JOIN AT1302 A04 WITH (NOLOCK) ON A07.InventoryID = A04.InventoryID
			LEFT JOIN AT1304 A05 WITH (NOLOCK) ON A07.UnitID = A05.UnitID
			LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A07.Ana01ID = A1.AnaID
			LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A07.Ana02ID = A2.AnaID
			LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A07.Ana03ID = A3.AnaID
			LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A07.Ana04ID = A4.AnaID
			LEFT JOIN AT1011 A5 WITH (NOLOCK) ON A07.Ana05ID = A5.AnaID
			LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A07.Ana06ID = A6.AnaID
			LEFT JOIN AT1011 A7 WITH (NOLOCK) ON A07.Ana07ID = A7.AnaID
			LEFT JOIN AT1011 A8 WITH (NOLOCK) ON A07.Ana08ID = A8.AnaID
			LEFT JOIN AT1011 A9 WITH (NOLOCK) ON A07.Ana09ID = A9.AnaID
			LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A07.Ana10ID = A10.AnaID
			LEFT JOIN AT1101 A11 WITH (NOLOCK) ON A06.DivisionID = A11.DivisionID
			LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A11.BankAccountID = A16.BankAccountID
			WHERE A06.DivisionID = '''+@DivisionID+''' AND A06.VoucherID = '''+@VoucherID+''''
		SET @sSQL2 	='
			GROUP BY 
			A06.DivisionID,
			A02_2.ObjectName, A11.DivisionName, A03_2.Address, A06.VoucherDate, A11.VATNo,  A06.VoucherDate, A03.Address, A07.CurrencyID
			, A06.WarehouseID
			, A03.WarehouseName
			, A06.VoucherDate
			, A04.InventoryName
			, A07.InventoryID, A05.UnitName, A07.Unitprice,
			A06.VoucherID, A06.TranMonth, A06.TranYear, A06.VoucherTypeID, A06.VoucherNo, A06.VoucherDate, A06.ObjectID, A02.ObjectName, A06.WarehouseID, A03.WarehouseName,
			A06.WarehouseID2, A03_2.WarehouseName, A06.ProjectID, A06.OrderID, A06.BatchID, A06.ReDeTypeID, A06.KindVoucherID, A06.Status, A06.EmployeeID, A06.Description,
			A06.CreateDate, A06.CreateUserID, A06.LastModifyUserID, A06.LastModifyDate, A06.RefNo01, A06.RefNo02, A06.RDAddress, A06.ContactPerson, A06.VATObjectName, A06.InventoryTypeID, 
			A06.IsGoodsFirstVoucher, A06.MOrderID, A06.ApportionID, A06.EVoucherID, A06.IsGoodsRecycled, A06.IsVoucher, A06.ImVoucherID, A06.ReVoucherID,
			A06.SParameter01, A06.SParameter02, A06.SParameter03, A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, A06.SParameter08, A06.SParameter09, A06.SParameter10, 
			A06.SParameter11, A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15, A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, A06.SParameter20, 
			A06.RouteID, A06.InTime, A06.OutTime, A06.DeliveryEmployeeID, A06.DeliveryStatus, A06.IsWeb, A06.CashierID, A06.CashierTime, A06.IsDeposit, A06.ObjectShipID, 
			A06.IsReturn, 
			A07.InventoryID, A04.InventoryName, A07.UnitID, A05.UnitName, A07.Unitprice, A07.OriginalAmount, A07.ConvertedAmount, A07.CurrencyID, A07.ExchangeRate, A07.SaleUnitPrice,
			A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.DebitAccountID, A07.CreditAccountID, A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.ConversionFactor, A07.ReTransactionID,
			A07.ReVoucherID, A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID,A07.Ana08ID , A07.Ana09ID, A07.Ana10ID,
			--A1.AnaName , A2.AnaName , A3.AnaName , A4.AnaName, A5.AnaName,
			--A6.AnaName , A7.AnaName , A8.AnaName , A9.AnaName, A10.AnaName,  
			A07.PeriodID, A07.ProductID, A07.OrderID , A07.InventoryName1, 
			A07.OTransactionID, A07.ReSPVoucherID, A07.ReSPTransactionID, A07.ETransactionID, A07.MTransactionID,
			A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedPrice, A07.ConvertedUnitID, A07.MOrderID ,
			A07.SOrderID, A07.STransactionID, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID, A07.OExpenseConvertedAmount
			, A07.WVoucherID
			, A07.RefInfor, A07.StandardPrice, A07.StandardAmount, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID , A07.TVoucherID, A07.SOrderIDRecognition,
			A16.BankAccountNo, A16.BankName, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson,A07.VoucherID
			) A
			
		'
		IF EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE VoucherID = @VoucherID ORDER BY NOTES06 DESC)
		BEGIN
		SET @sSQL3 ='
		UNION ALL 
		SELECT DISTINCT NULL AS Remark, 99999 AS Orders, 
			-- CÁC CỘT THEO MẪU TEMPLATE XML HDDT
			'''' AS CusCode, A11.DivisionName AS CusName, '''' AS Buyer, A03_2.Address as CusAddress, Format(A06.VoucherDate,''dd/MM/yyyy'') as CusPhone, (ISNULL(A11.VATNo,'''') + '';''+ ISNULL(A07.Notes10,'''')) as CusTaxCode, 
			'''' + '' - '' + '''' AS PaymentMethod, '''' AS CusBankNo,'''' AS CusBankName, NULL AS Warehouse, NULL AS ShippingNo, A06.VoucherDate AS ShippingDate, ISnull(A03.Address,'''') + '';''+  ISnull(A02_2.ObjectName,'''') AS Extra, A07.CurrencyID AS Extra1, NULL AS SoXe, NULL AS HopDongSo,
			NULL AS SoVT, A06.WarehouseID AS ImWarehouseID, '''' AS ImWarehouseName
			, (CASE WHEN A06.KindVoucherID = 3 THEN A06.WarehouseID2 ELSE '''' END) AS ExWarehouseID  
			, (CASE WHEN A06.KindVoucherID = 3 THEN '''' ELSE A06.RDAddress END) AS ExWarehouseName
			, A06.VoucherDate AS ContractDate,
			A06.VoucherDate AS ImportDate, NULL AS Total, NULL AS VATRate, 0 AS VATAmount,
			NULL AS Amount, NULL AS ArisingDate, A07.NOTES06 AS ProdName, 
			'''' AS ProdID, NULL AS ProdUnit, NULL AS ProdQuantity, NULL AS ProdPrice,
			NULL AS AfterAmount,
			-- CÁC CỘT TỪ BẢNG AT2006 VÀ AT2007
			A06.VoucherID, A06.TranMonth, A06.TranYear, A06.VoucherTypeID, A06.VoucherNo, A06.VoucherDate, A06.ObjectID, '''', A06.WarehouseID, '''',
			A06.WarehouseID2, '''' AS WarehouseName2, A06.ProjectID, A06.OrderID, A06.BatchID, A06.ReDeTypeID, A06.KindVoucherID, A06.Status, A06.EmployeeID, A06.Description,
			A06.CreateDate, A06.CreateUserID, A06.LastModifyUserID, A06.LastModifyDate, A06.RefNo01, A06.RefNo02, A06.RDAddress, A06.ContactPerson, A06.VATObjectName, A06.InventoryTypeID, 
			A06.IsGoodsFirstVoucher, A06.MOrderID, A06.ApportionID, A06.EVoucherID, A06.IsGoodsRecycled, A06.IsVoucher, A06.ImVoucherID, A06.ReVoucherID,
			A06.SParameter01, A06.SParameter02, A06.SParameter03, A06.SParameter04, A06.SParameter05, A06.SParameter06, A06.SParameter07, A06.SParameter08, A06.SParameter09, A06.SParameter10, 
			A06.SParameter11, A06.SParameter12, A06.SParameter13, A06.SParameter14, A06.SParameter15, A06.SParameter16, A06.SParameter17, A06.SParameter18, A06.SParameter19, A06.SParameter20, 
			A06.RouteID, A06.InTime, A06.OutTime, A06.DeliveryEmployeeID, A06.DeliveryStatus, A06.IsWeb, A06.CashierID, A06.CashierTime, A06.IsDeposit, A06.ObjectShipID, 
			A06.IsReturn, '
		SET @sSQL4 ='
			A07.InventoryID, '''' as InventoryName, A07.UnitID, '''' as UnitName, A07.ActualQuantity, A07.Unitprice, A07.OriginalAmount, A07.ConvertedAmount, A07.Notes, A07.CurrencyID, A07.ExchangeRate, A07.SaleUnitPrice,
			A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.DebitAccountID, A07.CreditAccountID, A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.ConversionFactor, A07.ReTransactionID,
			A07.ReVoucherID AS ReVoucherID_AT2007, A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID,(SELECT REPLACE (A07.Ana08ID,''-'+@DivisionID+''','''' )) as Ana08ID, A07.Ana09ID, A07.Ana10ID,
			--'''' as Ana01Name, '''' as Ana02Name, '''' as Ana03Name, '''' as Ana04Name, '''' as Ana05Name,
			--'''' as Ana06Name, '''' as Ana07Name, '''' as Ana08Name, '''' as Ana09Name, '''' as Ana10Name,  
			A07.PeriodID, A07.ProductID, A07.OrderID AS OrderID_AT2007, A07.InventoryName1, 
			A07.OTransactionID, A07.ReSPVoucherID, A07.ReSPTransactionID, A07.ETransactionID, A07.MTransactionID,
			A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedQuantity, A07.ConvertedPrice, A07.ConvertedUnitID, A07.MOrderID as MOrderID_AT2007,
			A07.SOrderID, A07.STransactionID, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID, A07.MarkQuantity, A07.OExpenseConvertedAmount, 
			A07.WVoucherID, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08, A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15,
			A07.RefInfor, A07.StandardPrice, A07.StandardAmount, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID, A07.TVoucherID, A07.SOrderIDRecognition,
			'''' as BankAccountNo, '''' as BankName, '''' as DivisionNameE, '''' as AddressE, '''' as District, '''' as DContactPerson
			FROM AT2006 A06 WITH (NOLOCK) INNER JOIN AT2007 A07 WITH (NOLOCK) ON A06.VoucherID = A07.VoucherID	
			LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectID = A02.ObjectID
			LEFT JOIN AT1202 A02_2 WITH (NOLOCK) ON A02_2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A06.ObjectShipID = A02_2.ObjectID
			LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID = A03.WarehouseID
			LEFT JOIN AT1303 A03_2 WITH (NOLOCK) ON A03_2.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A06.WarehouseID2 = A03_2.WarehouseID
			LEFT JOIN AT1302 A04 WITH (NOLOCK) ON A07.InventoryID = A04.InventoryID
			LEFT JOIN AT1304 A05 WITH (NOLOCK) ON A07.UnitID = A05.UnitID
			LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A07.Ana01ID = A1.AnaID
			LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A07.Ana02ID = A2.AnaID
			LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A07.Ana03ID = A3.AnaID
			LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A07.Ana04ID = A4.AnaID
			LEFT JOIN AT1011 A5 WITH (NOLOCK) ON A07.Ana05ID = A5.AnaID
			LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A07.Ana06ID = A6.AnaID
			LEFT JOIN AT1011 A7 WITH (NOLOCK) ON A07.Ana07ID = A7.AnaID
			LEFT JOIN AT1011 A8 WITH (NOLOCK) ON A07.Ana08ID = A8.AnaID
			LEFT JOIN AT1011 A9 WITH (NOLOCK) ON A07.Ana09ID = A9.AnaID
			LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A07.Ana10ID = A10.AnaID
			LEFT JOIN AT1101 A11 WITH (NOLOCK) ON A06.DivisionID = A11.DivisionID
			LEFT JOIN AT1016 A16 WITH (NOLOCK) ON A11.BankAccountID = A16.BankAccountID
			WHERE A06.DivisionID = '''+@DivisionID+''' AND A06.VoucherID = '''+@VoucherID+''' AND A07.NOTES06 IS NOT NULL
			
		'
		END
		EXEC ( @SSQLTAM + 'SELECT * From ('+@sSQL + @sSQL1 + @sSQL2 + @sSQL3+  @sSQL4+') A ORDER BY Orders')
		Print @sSQL
		print @sSQL1
		print @sSQL2
		print @sSQL3
		print @sSQL4
	END
	ELSE 
	BEGIN
		SELECT TOP 1 @VoucherTypeID = VoucherTypeID	FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
		SET @Uni = '
		UNION ALL'
	
		-- Lấy hàng không khuyến mại
		SET @sSQL1 = N'     
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, SUM(AT9000.Quantity) AS ProdQuantity, 
		AT9000.ConvertedPrice AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 0
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, 
		AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'			
	
		-- Lấy dòng "Hàng khuyến mãi không thu tiền"
		SET @sSQL2 = N'
		SELECT 100 AS Orders, NULL AS TransactionID, 0 AS IsProInventoryID, MAX(ISNULL(IsProInventoryID,0)) AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, 
		AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, N''Hàng khuyến mãi không thu tiền:'' ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, NULL AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'
	
		-- Lấy hàng khuyến mại
		SET @sSQL3 = N'
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, SUM(AT9000.Quantity) AS ProdQuantity, 
		AT9000.ConvertedPrice AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 1
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'			
	
		-- Lấy dòng chiết khấu doanh số
		SET @sSQL4 = N'
		SELECT 100 AS Orders, NULL AS TransactionID, 1 AS IsProInventoryID, CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND AT90.DiscountSalesAmount > 0) THEN 1 ELSE 0 END AS Visible, 
		ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.Parameter01 AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, ISNULL(DiscountSalesAmount, 0) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.Parameter01, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Lấy dòng chiết khấu hóa đơn 1 mức chiếc khấu
		SET @sSQL5 = N'
		SELECT 101 AS Orders, NULL AS TransactionID, 1 AS IsProInventoryID,
		CASE WHEN ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) > 0 THEN 1 ELSE 0 END AS Visible, 
		ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, N''Chiết khấu '' + CONVERT(NVARCHAR(10), CONVERT(INT,MAX(ISNULL(AT9000.DiscountRate,0)))) + ''%'' AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, 
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.Parameter01, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'
	
		-- Lấy dòng chiết khấu hóa đơn nhiều mức chiếc khấu
		SET @sSQL6 = N'
		SELECT 101 AS Orders, NULL AS TransactionID, 1 AS IsProInventoryID, CASE WHEN ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) > 0 THEN 1 ELSE 0 END AS Visible, 
		ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, N''Chiết khấu'' AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, 
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.Parameter01, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'
	
		-- Lấy dòng tài trợ không thu tiền
		SET @sSQL7 = N'				
		SELECT 0 AS Orders, NULL AS TransactionID, 0 AS IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, N''Tài trợ không thu tiền:'' ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, NULL AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'		
	
		-- Lấy tất cả mặt hàng
		SET @sSQL8 = N'					
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, SUM(AT9000.Quantity) AS ProdQuantity, 
		AT9000.ConvertedPrice AS ProdPrice, SUM(AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Lấy tất cả mặt hàng (không lấy số lượng, đơn giá)
		SET @sSQL9 = N'				
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter02, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Lấy dòng tham số 3
		SET @sSQL10 = N'				
		SELECT 0 AS Orders, NULL AS TransactionID, 0 AS IsProInventoryID, 
		CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.Parameter03, '''') <> '''') THEN 1 ELSE 0 END AS Visible, 
		ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.Parameter03 AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, NULL AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.Parameter03, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'		
	
		-- Lấy tất cả mặt hàng (không đơn giá thành tiền)
		SET @sSQL11 = N'				
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, SUM(AT9000.Quantity) AS ProdQuantity, 
		AT9000.ConvertedPrice AS ProdPrice, SUM(AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'		
	
		-- Lấy hàng không khuyến mại (không lấy số lượng, đơn giá)
		SET @sSQL12 = N'     
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 0
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Group theo DParameter01 (hàng không khuyến mãi không lấy số lượng, đơn giá)
		SET @sSQL18 = N'
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter01 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 0
		AND ISNULL(AT9000.DParameter01, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter01, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Lấy hàng khuyến mại (không lấy số lượng, đơn giá)
		SET @sSQL13 = N'
		SELECT MAX(Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 1
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Group theo DParameter01 (hàng khuyến mãi không lấy số lượng, đơn giá)
		SET @sSQL19 = N'
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter01 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 1
		AND ISNULL(AT9000.DParameter01, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter01, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Group theo DParameter01 (hàng không khuyến mãi)
		SET @sSQL14 = N'	
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter01 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		SUM(AT9000.Quantity) AS ProdQuantity, 
		(SELECT TOP 1 AT90.ConvertedPrice FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 0
		AND ISNULL(AT9000.DParameter01, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter01, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Group theo DParameter01 (hàng khuyến mãi)
		SET @sSQL15 = N'
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter01 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		SUM(AT9000.Quantity) AS ProdQuantity, 
		(SELECT TOP 1 AT90.ConvertedPrice FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) AS ProdPrice, 
		SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.IsProInventoryID, 0) = 1
		AND ISNULL(AT9000.DParameter01, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter01, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'
	
		-- Group theo DParameter01 (tất cả mặt hàng)
		SET @sSQL16 = N'
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter01 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		SUM(AT9000.Quantity) AS ProdQuantity, 
		(SELECT TOP 1 AT90.ConvertedPrice FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) AS ProdPrice, 
		SUM(AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.DParameter01, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter01, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'	
	
		-- Group theo DParameter02 (tất cả mặt hàng không lấy số lượng, đơn giá)
		SET @sSQL17 = N'
		SELECT MAX(AT9000.Orders) AS Orders, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.DParameter02 AS ProdName, 
		AT1304.UnitName AS ProdUnit, 
		NULL AS ProdQuantity, 
		NULL AS ProdPrice, 
		--SUM(CASE WHEN AT9000.ConvertedPrice = 0 THEN AT9000.ConvertedAmount ELSE AT9000.Quantity*AT9000.ConvertedPrice*ExchangeRate END) AS Amount,
		SUM(AT9000.ConvertedAmount) AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = (SELECT TOP 1 AT90.UnitID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND AT90.TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.IsProInventoryID, 0) = ISNULL(AT9000.IsProInventoryID, 0) AND AT90.DParameter01 = AT9000.DParameter01 ORDER BY Orders) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		AND ISNULL(AT9000.DParameter02, '''') <> ''''	
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT9000.DParameter02, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress,
		AT1202.Tel, AT9000.VATNo, AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, AT1304.UnitName, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'
	
		-- Lấy dòng tham số 7
		SET @sSQL20 = N'				
		SELECT 0 AS Orders, NULL AS TransactionID, 0 AS IsProInventoryID, CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND ISNULL(AT90.Parameter07, '''') <> '''') THEN 1 ELSE 0 END AS Visible, 
		ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
		ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
		AT1010.VATRate AS VATRate, AT9000.Parameter07 AS ProdName, NULL AS ProdUnit, NULL AS ProdQuantity,  NULL AS ProdPrice, NULL AS Amount,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.Parameter07, AT9000.DiscountSalesAmount, AT9000.ObjectID, AT1202.EInvoiceObjectID, AT1202.ObjectName, 
		AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, AT9000.VATGroupID, AT1010.VATRate, AT9000.Parameter02, AT9000.Parameter04, AT1202.Contactor,
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID'								
	
		-- Hóa đơn hàng biếu tặng, lấy đơn giá và thành tiền từ phiếu xuất
		SET @sSQL21 = '     
			SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
			AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
			AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,

			(SELECT SUM(ISNULL(A1.ConvertedAmount,0)) FROM AT2007 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.WOrderID 
				AND A1.TransactionID IN (SELECT A2.WTransactionID FROM AT9000 A2 WITH (NOLOCK) WHERE A2.VoucherID = AT9000.VoucherID)) AS Total,

			ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(AT9000.DiscountSalesAmount, 0) AS DiscountAmount,
		
			(SELECT SUM(ISNULL(A1.ConvertedAmount,0)) FROM AT2007 A1 WITH (NOLOCK) WHERE A1.VoucherID = AT9000.WOrderID 
				AND A1.TransactionID IN (SELECT A2.WTransactionID FROM AT9000 A2 WITH (NOLOCK) WHERE A2.VoucherID = AT9000.VoucherID)) * AT1010.VATRate AS VATAmount,
		
			0 AS AfterAmount,
			AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
			AT2007.UnitPrice AS ProdPrice,
			AT2007.ConvertedAmount AS Amount,
			AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
			--INTO #TEMP
			FROM AT9000 WITH (NOLOCK)
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
			LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
			LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
			LEFT JOIN AT2007 WITH (NOLOCK) ON AT9000.WOrderID = AT2007.VoucherID AND AT9000.WTransactionID = AT2007.TransactionID
			WHERE AT9000.DivisionID = ''' + @DivisionID + '''
			AND AT9000.VoucherID = ''' + @VoucherID + ''' 
			AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		'
		IF @VoucherTypeID IN ('HD1','TL') -- Mẫu AR3014F
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL10 + @Uni + @sSQL1 + @Uni + @sSQL14 + @Uni + @sSQL2 + @Uni + @sSQL15 + @Uni + @sSQL3 + @Uni + @sSQL4 + @Uni + @sSQL5 + ') TB
			
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID as currencyunit
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID
			WHERE Visible = 1
			ORDER BY IsProInventoryID, Orders'
		
			--PRINT @sSQL10
			--PRINT @Uni		
			--PRINT @sSQL1
			--PRINT @Uni
			--PRINT @sSQL14
			--PRINT @Uni		
			--PRINT @sSQL2
			--PRINT @Uni		
			--PRINT @sSQL15
			--PRINT @Uni		
			--PRINT @sSQL3
			--PRINT @Uni		
			--PRINT @sSQL4
			--PRINT @Uni		
			--PRINT @sSQL5
		END 	
		ELSE
		IF @VoucherTypeID = 'HD3' -- Mẫu AR3014I
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL10 + @Uni + @sSQL1 + @Uni + @sSQL14 + @Uni + @sSQL2 + @Uni + @sSQL15 + @Uni + @sSQL3 + @Uni + @sSQL4 + @Uni + @sSQL6 + ') TB
				
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID		
			WHERE Visible = 1
			ORDER BY IsProInventoryID, Orders'
		
			--PRINT @sSQL10
			--PRINT @Uni			
			--PRINT @sSQL1
			--PRINT @Uni		
			--PRINT @sSQL2
			--PRINT @Uni		
			--PRINT @sSQL3
			--PRINT @Uni		
			--PRINT @sSQL4
			--PRINT @Uni		
			--PRINT @sSQL6		
		END 	
		ELSE	
		IF @VoucherTypeID in ( 'HD4','TL1') -- Mẫu AR3014B
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL20 + @Uni + @sSQL10 + @Uni + @sSQL8 + @Uni + @sSQL16 + ') TB		
		
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0  THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID			
			WHERE Visible = 1
			ORDER BY Orders'	
		
			--PRINT @sSQL20		
			--PRINT @sSQL10
			--PRINT @Uni		
			--PRINT @sSQL8
			--PRINT @Uni			
			--PRINT @sSQL16		
		END	
		ELSE	
		IF @VoucherTypeID in ('HD5','HG1') -- Mẫu AR3014G
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL10 + @Uni + @sSQL9 + @Uni + @sSQL17 + ') TB	
				
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID			
			WHERE Visible = 1
			ORDER BY Orders'
		
			--PRINT @sSQL10
			--PRINT @Uni			
			--PRINT @sSQL9
			--PRINT @Uni		
			--PRINT @sSQL17					
		END	
		ELSE	
		IF @VoucherTypeID = 'HD6' -- Mẫu AR3014H
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL10 + @Uni + @sSQL11 + @Uni + @sSQL16 + @Uni + @sSQL4 + @Uni + @sSQL5 + ') TB			
		
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID				
			WHERE Visible = 1
			ORDER BY Orders'	
		
			--PRINT @sSQL10
			--PRINT @sSQL11		
			--PRINT @sSQL16
			--PRINT @sSQL4
			--PRINT @sSQL5		
		END	
		ELSE	
		IF @VoucherTypeID = 'HG' -- Mẫu AR3014J
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL10 + @Uni + @sSQL12 + @Uni + @sSQL18 + @Uni + @sSQL2 + @Uni + @sSQL13 + @Uni + @sSQL19 + @Uni + @sSQL4 + @Uni + @sSQL6 + ') TB				
		
			SELECT Remark, PaymentMethod, Buyer, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP TB
			LEFT JOIN 
			(
				SELECT ROW_NUMBER() OVER(ORDER BY IsProInventoryID, Orders) AS Remark, TransactionID
				FROM #TEMP TB
				WHERE Visible = 1
				AND Orders NOT IN (0,100,101)
			) RN ON RN.TransactionID = TB.TransactionID			
			WHERE Visible = 1
			ORDER BY IsProInventoryID, Orders'
		
			--PRINT @sSQL10		
			--PRINT @sSQL12
			--PRINT @sSQL18		
			--PRINT @sSQL2
			--PRINT @sSQL13
			--PRINT @sSQL19
			--PRINT @sSQL4
			--PRINT @sSQL6		
		END 
		ELSE 
		IF @VoucherTypeID = 'HD8' -- Mẫu AR3014J
		BEGIN
			SET @sSQL = '
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL21 + ') TB				
		
			SELECT	Remark, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Buyer, PaymentMethod, 
					Total, DiscountAmount, Total+ CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END  AS AfterAmount,
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
					ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP
			ORDER BY Remark
			'
		END
		ELSE
		BEGIN
			SET @sSQL = '     
			SELECT ROW_NUMBER() OVER(ORDER BY Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
			AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
			AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
			ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
			ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
			ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
			ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
			AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
			AT9000.ConvertedPrice AS ProdPrice, AT9000.ConvertedAmount AS Amount,
			AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
			INTO #TEMP
			FROM AT9000 WITH (NOLOCK)
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
			LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
			LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
			WHERE AT9000.DivisionID = ''' + @DivisionID + '''
			AND VoucherID = ''' + @VoucherID + ''' 
			AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
			ORDER BY AT9000.Orders

			SELECT	Remark, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Buyer, PaymentMethod, 
					Total, DiscountAmount, AfterAmount,
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
					ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID
			FROM #TEMP
			ORDER BY Remark
			'
		END			
		
		IF @VouchertypeID = 'HD2' OR @VouchertypeID = 'TL3' -- Xuất hóa đơn điện tử GTGT xuất khẩu Or Hàng trả lại dành cho hàng mua nước ngoài
		BEGIN
		SET @sSQL22 = N'					
		SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, NEWID() AS TransactionID, AT9000.IsProInventoryID, 1 AS Visible, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
		AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
		AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
		ISNULL((SELECT Round(SUM(ABS(OriginalAmount)),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
		- ISNULL((SELECT Round(SUM(ABS(OriginalAmount)),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,
		ISNULL((SELECT Round(SUM(DiscountAmount),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
		ISNULL((SELECT Round(SUM(OriginalAmount),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
		ISNULL((SELECT Round(SUM(ABS(OriginalAmount)),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
		- ISNULL((SELECT Round(SUM(ABS(OriginalAmount)),2) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,
		AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, SUM(AT9000.Quantity) AS ProdQuantity, 
		AT9000.ConvertedPrice AS ProdPrice, SUM(AT9000.Quantity*AT9000.ConvertedPrice) AS Amount,'
		+  CASE WHEN (SELECT TOP 1 ExchangeRate FROM AT9000 WHERE VoucherID=@VoucherID) = 1 THEN '1' ELSE '((REPLACE(CONVERT(NVARCHAR(50),FORMAT(AT9000.ExchangeRate,''#,#'')), '','', ''.''))+'' ''+' END + '
		'+ CASE WHEN (SELECT TOP 1 CurrencyID FROM AT9000 WHERE VoucherID=@VoucherID) ='VND' THEN '' ELSE '+''VND/''+'+'AT9000.CurrencyID)' END +' as Extra1,' +'
		
		AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust , AT9000.ExchangeRate as Extra,AT9000.CurrencyID
		FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
		LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
		WHERE AT9000.DivisionID = ''' + @DivisionID + '''
		AND VoucherID = ''' + @VoucherID + '''
		AND ISNULL(AT9000.DParameter01, '''') = ''''
		AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
		GROUP BY AT9000.Orders,AT9000.DivisionID, AT9000.VoucherID, AT9000.IsProInventoryID, AT1202.EInvoiceObjectID, AT9000.ObjectID, AT1202.ObjectName, AT9000.VATObjectAddress, AT1202.Tel, AT9000.VATNo, 
		AT9000.Parameter02, AT1202.Contactor, AT9000.Parameter04,
		AT1010.VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName), AT1304.UnitName, AT9000.ConvertedPrice, DiscountSalesAmount, AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust,
		AT9000.ExchangeRate,AT9000.CurrencyID'

		create  table #TEMP1(
				    Remark  int, CusCode  nvarchar(250), CusName nvarchar(250), CusAddress nvarchar(250), CusPhone nvarchar(250), CusTaxCode nvarchar(250)
					, KindOfService  nvarchar(250), Buyer nvarchar(250), PaymentMethod nvarchar(250), 
					Total  Decimal(28,8), DiscountAmount Decimal(28,8), AfterAmount Decimal(28,8),
					VATAmount Decimal(28,8), 
					VATRate Decimal(28,8), 
					ProdName nvarchar(250), ProdUnit nvarchar(250), ProdQuantity Decimal(28,8), ProdPrice Decimal(28,8), Amount Decimal(28,8),Extra1 nvarchar(250)
					, InheritFkey nvarchar(250), EInvoiceType int, TypeOfAdjust int, CurrencyID nvarchar(50), Extra nvarchar(50)
		)	
		SET @sSQL = N'
			SELECT *
			INTO #TEMP
			FROM ('+ @sSQL22 + ') TB
			INSERT INTO #TEMP1
			
			'+CASE WHEN  (SELECT TOP 1 ExchangeRate FROM AT9000 WHERE VoucherID=@VoucherID AND InvoiceSign ='01GTKT0/001') <> 1  THEN
			'
			SELECT	Top 1 '''' AS Remark, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Buyer, PaymentMethod, 
					Total, 0 DiscountAmount, AfterAmount,
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN 0 ELSE VATAmount END AS VATAmount, 
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN 0 ELSE VATRate END AS VATRate, 
					EXTRA1 AS ProdName,'''' ProdUnit, 0 ProdQuantity, 0 ProdPrice, 0 Amount,Extra1, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID, REPLACE(CONVERT(NVARCHAR(50),FORMAT(Extra,''#,#'')), '','', ''.'') As Extra
			FROM #TEMP
			UNION ALL
			' 
			ELSE '' END+'
			SELECT	Remark, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Buyer, PaymentMethod, 
					Total, DiscountAmount, AfterAmount,
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN 0 ELSE VATAmount END AS VATAmount, 
					CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN 0 ELSE VATRate END AS VATRate, 
					ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount,Extra1, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID, REPLACE(CONVERT(NVARCHAR(50),FORMAT(Extra,''#,#'')), '','', ''.'') As Extra
			 FROM #TEMP
			'
			SET @sSQL = @sSQL+N'update #TEMP1 set ProdName = N''Tỷ giá (ExchangeRate): '' + Extra1, Remark = null where Remark = 0
								select * From #TEMP1 order by Remark'
				
		END
      --  select (@sSQL)
        EXEC (@sSQL)
	END


END
ELSE
BEGIN
	SET @sSQL = '     
	SELECT ROW_NUMBER() OVER(ORDER BY Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, AT1202.ObjectName AS CusName, 
	AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone, AT9000.VATNo AS CusTaxCode,
	AT9000.CurrencyID AS KindOfService, ISNULL(AT9000.Parameter02, AT1202.Contactor) AS Buyer, AT9000.Parameter04 AS PaymentMethod,
	ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) AS Total,
	ISNULL((SELECT SUM(DiscountAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(DiscountSalesAmount, 0) AS DiscountAmount,
	ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,
	ISNULL((SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) AS AfterAmount,
	AT1010.VATRate AS VATRate, ISNULL(AT9000.InventoryName1, AT1302.InventoryName) AS ProdName, AT1304.UnitName AS ProdUnit, AT9000.Quantity AS ProdQuantity, 
	AT9000.ConvertedPrice AS ProdPrice, AT9000.ConvertedAmount AS Amount,
	AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, AT9000.CurrencyID
	INTO #TEMP
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT9000.InventoryID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID	
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	WHERE AT9000.DivisionID = ''' + @DivisionID + '''
	AND VoucherID = ''' + @VoucherID + ''' 
	AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'')
	ORDER BY AT9000.Orders
	
	SELECT	Remark, CusCode, CusName, CusAddress, CusPhone, CusTaxCode, KindOfService, Buyer, PaymentMethod, 
			Total, DiscountAmount, AfterAmount,
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, CurrencyID, Extra
	FROM #TEMP
	ORDER BY Remark
	'	
	PRINT @sSQL
	EXEC (@sSQL)
		
END	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
