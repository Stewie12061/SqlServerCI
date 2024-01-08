IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0146_KHV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0146_KHV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- AP0146_KHV
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
---- Modified by Kim Thư on 05/09/2018: Lấy TDescription cho khách hàng không phải Angel
---- Modified by Kim Thư on 06/09/2018: Sửa nếu VATAmount và VATRate =0 thì vẫn để 0, ko chuyển thành -1 cho khách hàng không phải angel
---- Modified by Kim Thư on 10/09/2018: Lấy thêm các cột từ Ana02ID đến VATAmount10 cho khách hàng ko phải angel
---- Modified by Kim Thư on 12/09/2018: Thể hiện nhóm diễn giải TDescription cho CustomerName=83 - PANAL
---- Modified by Kim Thư on 18/9/2018: Customize cho PANAL(83) và Tiến Hưng(90) lấy cột Extra
---- Modified by Kim Thư on 25/9/2018: Sửa lấy total và Amount cho Tiến Hưng.
---- Modified by Kim Thư on 03/10/2018: Customize cột CusbankName cho Panal
---- Modified by Kim Thư on 04/10/2018: Bổ sung hàm trị tuyệt đối cho các cột tính số tiền (khách hàng ko phải angel)
---- Modified by Kim Thư on 26/10/2018: Bổ sung tất cả cột của AT9000 (khách hàng ko phải angel)
---- Modified by Kim Thư on 06/11/2018: Bổ sung TaxRateID
---- Modified by Kim Thư on 09/11/2018: Bổ sung DiscountedUnitPrice và ConvertedDiscountedUnitPrice
---- Modified by Kim Thư on 19/11/2018: Bổ sung 10 cột AnaName, sắp xếp cho Panal thể hiện remark asc
---- Modified by Kim Thư on 21/11/2018: Sửa cách lấy CusbankNo cho Panal
---- Modified by Kim Thư on 10/12/2018: Bổ sung phát hành hóa đơn điện tử từ phiếu VCNB (Customize cho Siêu Thanh - 16)
---- Modified by Kim Thư on 15/01/2019: Bổ sung số và tên tài khoản ngân hàng của đơn vị
---- Modified by Kim Thư on 18/01/2019: Bổ sung phát hành nhóm theo TDesscription đối với Siêu thanh (Customize cho Siêu Thanh - 16, VoucherTypeID='HDBK')
---- Modified by Kim Thư on 28/01/2019: Sửa mã Ana08ID của khách Siêu Thanh , bỏ đuôi chi nhánh '-DivisionID' 
---- Modified by Kim Thư on 15/02/2019: Bổ sung ContactPerson từ phiếu xuất cho hóa đơn có xuất kho
---- Modified by Kim Thư on 19/02/2019: Tách VATAMount cho từng mặt hàng
---- Modified by Kim Thư on 21/2/2019: Cho phát hành hóa đơn chiết khấu T64
---- Modified by Kim Thư on 22/2/2019: Tách store cho Siêu Thanh
---- Modified by Kim Thư on 11/03/2019: Bổ sung ConvertedUnitName
---- Modified by Kim Thư on 22/03/2019: Sửa hiển thị ProdName (CustomizeIndex = 67 - KHV)
---- Modified by Kim Thư on 05/04/2019: Bổ sung PaymentName
---- Modified by Kim Thư on 12/04/2019: Bổ sung IsDiscount và các cột thông tin Division
---- Modified by Kim Thư on 18/04/2019: Bổ sung customize cho seabornes giống panal, thêm cột OriginalAfterVATAmount và ConvertedAfterVATAmount (thành tiền từng dòng sau thuế)
---- Modified by Kim Thư on 17/05/2019: Bổ sung store riêng cho VIMEC
---- Modified by Kim Thư on 21/05/2019: Gán cột VAT_Rate = -1 nếu hóa đơn thuộc nhóm ko chịu thuế
---- Modified by Kim Thư on 28/05/2019: Bổ sung LimitDate và SourceNo của phiếu xuất kho bán hàng
---- Modified by Kim Thư on 17/6/2019: Bổ sung I04ID (yêu cầu của Savi)
---- Modified by Kim Thư on 26/06/2019: Sửa cách lấy cột PayMethodID bổ sung trường hợp = 3
---- Modified by Kim Thư on 02/07/2019: Bổ sung cột ItemTypeID hiển thị loại dòng cho khách hàng dùng EInvoice của BKAV (0: dòng mặt hàng bình thường / 4: Dòng diễn giải hóa đơn (lấy Parameter10))
---- Modified by Kim Thư on 05/07/2019: Tách store cho riêng Panal, Tiến Hưng, Seabornes. Bỏ phần customize cho Angel do Angel đã có fix riêng.
---- Modified by Hoàng Trúc on 01/08/2019: bổ sung BankAccountNo lấy từ AT1202 (DM đối tượng)
---- Modified by Hoàng Trúc on 02/08/2019: Tách store riêng cho SAVI 
---- Modified by Khánh Đoan on 15/08/2019: Bổ sung TransactionTypeID = 64
---- Modified by Hoàng Trúc on 26/08/2019: Thêm dòng diễn giải cho hóa đơn điện tử lấy từ Parameter10
---- Modified by Hoàng Trúc on 26/08/2019: Thêm dòng diễn giải cho hóa đơn điện tử lấy từ Parameter09
---- Modified by Hoàng Trúc on 28/08/2019: Sửa hiển thị CusName (CustomizeIndex = 46 - Huyndae), bỏ thêm dòng diễn giải lấy từ Parameter10 và Parameter09
---- Modified by Hoàng Trúc on 29/08/2019: Tách store riêng cho Huyndae
---- Modified by Văn Tài	on 02/10/2019: Sửa lỗi vấn đề select vào X thì khối dữ liệu không thống nhất ORDER BY Remark bên trong
---- Modified by Mỹ Tuyền	on 22/11/2019: Customize [SEAHORSE] sử dụng AP0146_SB
---- Modified by Mỹ Tuyền	on 18/12/2019: Customize [SONGBINH] sử dụng AP0146_SONGBINH
---- Modified by Văn Tài	on 20/12/2019: Customize [THTP] sử dụng AP0146_THTP
---- Modified by Huỳnh Thử	on 14/03/2020: Customize [Liên Quân] sử dụng AP0146_LQ -- Liên quân
---- Modified by Văn Minh	on 21/04/2020: Customize [FUYER] Bổ sung trường ArisingDate
---- Modified by Huỳnh Thử	on 09/07/2020: Nếu VATObjectName <> thì lấy VATObjectName ngược lại láy ObjectName
---- Modified by Đức Thông	on 26/08/2020: Sửa lại customer index của LIEN BANG thành 124
---- Modified by Đức Thông	on 27/08/2020: Thêm custom cho QTC (41)
---- Modified by Đức Thông	on 04/09/2020: Sửa lại rẽ nhánh bị sai
---- Modified by Đức Thông	on 04/09/2020: Bổ sung trường CusBankName, CusEmailCC
---- Modified by Đức Thông	on 11/09/2020: Thêm customer index cho khách hàng GODREJ (74)
---- Modified by Đức Thông	on 14/09/2020: Bổ sung trường CusBankName, CusEmailCC
---- Modified by Huỳnh Thử	on 17/09/2020: Bổ sung trường ParentInvoiceSign và ParentSerial của hóa đơn gốc
---- Modified by Đức Thông	on 22/09/2020: Thêm dòng chú thích lấy Parameter01 customize TOHO
---- Modified by Đức Thông	on 25/09/2020: Bỏ order by bị sai cú pháp
---- Modified by Huỳnh Thử	on 25/09/2020: Tách store KoYo
---- Modified by Huỳnh Thử	on 06/10/2020: Tách store Hưng Thịnh 
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông on 03/11/2020: Bổ sung customize index cho TECHNNO (127)
---- Modified by Đức Thông on 09/11/2020: Bổ sung customize index cho HOASANG (60): HDDT sử dụng đv tiền VND
---- Modified by Đức Thông on 11/11/2020: Bổ sung customize index cho Hưng Phát (54): Cus thuế VAT, tổng tiền ngoại tệ lấy nguyên tệ làm tròn 2 chữ số thập phân
---- Modified by Huỳnh Thử on 20/11/2020: Select dữ liệu VCNB
---- Modified by Huỳnh Thử on 07/12/2020: Bổ sung những cột còn thiếu phát hành VCNB
---- Modified by Hoài Phong on 08/12/2020: Bổ sung  lấy PayMethodID trong Funtion GetPayMethodID
---- Modified by Huỳnh Thử  on 10/12/2020: Bổ sung những trường còn thiếu phát hành VCNB
---- Modified by Huỳnh Thử  on 17/12/2020: Custome KHV: Notes03 = CÔNG TY TNHH SX - TM KIM HOÀN VŨ
---- Modified by Đức Thông  on 29/12/2020: [Tiên Tiến] 2020/12/IS/0554: Lấy thêm parameter01 thành 1 dòng ghi chú
---- Modified by Đức Thông  on 08/01/2021: [NKTTN] 2021/01/IS/0101: Sửa lỗi lấy dữ liệu ở phiếu xuất, VCNB + Lấy đơn vị tiền theo thiết lập
---- Modified by Đức Thông  on 08/01/2021: [NKTTN] 2021/01/IS/0101: Truyền tỉ giá (extra) = 1 ở phiếu xuất, VCNB vì không xài ngoại tệ
---- Modified by Đức Thông  on 11/01/2021: [SIÊU THANH] 2020/12/IS/0473 Phát hành phiếu xuất kho, VCNB thiếu 1 số trường
---- Modified by Huỳnh Thử  on 11/01/2021: Custome KHV: Bổ sung trường còn thiếu -> Phát hành VCNB
---- Modified by Đức Thông  on 11/01/2021: [KRUGER] 2020/12/IS/0255: Bổ sung rẽ nhánh cho KRUGER (133)
---- Modified by Đức Thông  on 12/01/2021: [NKTTN] 2021/01/IS/0101: Sửa lại định dạng ShippingDate lấy theo yyyy-mm-dd để phát hành được
---- Modified by Huỳnh Thử  on 12/01/2021: Bổ sung điều kiện Left Join Mã phân tích (ANa)
---- Modified by Huỳnh Thử  on 15/01/2021: VCNB -- Thành tiền, đơn giá = 0
---- Modified by Huỳnh Thử  on 19/01/2021: Custome KHV: VCNB -- Thành tiền, đơn giá = 0, Tạo View select lấy tên Cty Kim Hoàng Vũ
---- Modified by Hoài Phong on 21/01/2021: Fix lỗi Order.remark thứ tự sắp xếp thứ tự hóa đơn. 
---- Modified by Huỳnh Thử  on 01/02/2021: Tách store TELLBE
---- Modified by Đức Thông on 11/03/2021: [SONG BÌNH] 2021/03/IS/0085: Sửa ghi chú từ TDescription thành VDescription và đẩy dòng ghi chú lên đầu
---- Modified by Huỳnh Thử on 22/04/2021: Bỏ tách Store KHV
---- Modified by Huỳnh Thử on 08/07/2021: Fix Parameter10 union All
---- Modified by Huỳnh Thử on /07/2021: [TienTien] -- Select Top 1 
---- Modified by Nhựt Trường on 28/07/2021: Điều chỉnh điều kiện join với bảng AT9000 (AT9000.ObjectID thành AT9000.VATObjectID).
---- Modified by Lê Hoàng on 28/09/2021: Customize [NGOCHONG] AT1202.BankAccountNo, AT1202.BankName cho CusBankNo, CusBankName
---- Modified by Lê Hoàng on 28/09/2021: Customize [NGOCHONG] EX/21E thì trả OriginalAmount
---- Modified by Nhật Thanh on 13/10/2021: customize cho PL, nếu mã hàng là BK001 thì lấy TDescription là ProdName.
---- Modified by Nhựt Trường on 31/10/2021: Tách store cho khách hàng Phúc Long (store AP0146_PL).
---- Modified by Nhựt Trường on 21/12/2021: Tách lại store riêng cho khách hàng Kim Hoàn Vũ (store AP0146_KHV).
---- Modified by Nhật Thanh on 25/05/2022: Người mua hàng lấy theo diễn giải chứng từ
---- Modified by Nhật Thanh on 03/06/2022: Ngày lệnh lấy theo trường Notes02 dưới detail. Trường KindOfService lấy theo Notes04 dưới detail
---- Modified by Nhật Thanh on 26/10/2022: Customize lấy đơn vị tiền tệ, đơn giá, thành tiền theo DParameter trên phiếu
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- EXEC AP0146_KHV @DivisionID = 'ANG',@UserID='ASOFTADMIN',@VoucherID='AV561ee05d-44de-4d71-8e4c-4927876f60df'

CREATE PROCEDURE [dbo].[AP0146_KHV]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS

DECLARE @sSQL AS NVARCHAR(MAX) = '',
		@sSQL1A AS NVARCHAR(MAX) = '',
		@sSQL1A1 AS NVARCHAR(MAX) = '',
		@sSQL2A AS NVARCHAR(MAX) = '',
		@sSQLA AS NVARCHAR(MAX) = '',
		@sSQLB AS NVARCHAR(MAX) = '',
		@sSQL3 AS NVARCHAR(MAX) = '',	
		@sSQL3_A AS NVARCHAR(MAX) = '',	
		@sSQL4 AS NVARCHAR(MAX) = '',
		@sSQL5 	AS NVARCHAR(MAX) = '',
		@sSQL6 AS NVARCHAR(MAX) = '',							
		@CustomerName INT,
		@KindVoucherID AS TINYINT = 0

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 	


SET @KindVoucherID = (SELECT KindVoucherID FROM AT2006 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID)
IF @KindVoucherID = 3 or @KindVoucherID = 2 -- Phiếu VCNB, xuất kho
BEGIN
SET @sSQL = '  
SELECT ROW_NUMBER() OVER(ORDER BY A07.Orders) AS Remark, 
-- CÁC CỘT THEO MẪU TEMPLATE XML HDDT
A02.ObjectID AS CusCode, A02.ObjectName AS Buyer, 
NULL AS PaymentMethod, A03_2.WareHouseName as CusAddress, A02.ObjectName AS CusName, A02.Email AS CusEmail
, NULL AS Warehouse, NULL AS ShippingNo, A07.Notes02 AS ShippingDate, NULL AS SoXe, NULL AS HopDongSo,
NULL AS SoVT, A06.WarehouseID AS ImWarehouseID, A03.WarehouseName AS ImWarehouseName
, (CASE WHEN A06.KindVoucherID = 3 THEN A06.WarehouseID2 ELSE '''' END) AS ExWarehouseID  
, (CASE WHEN A06.KindVoucherID = 3 THEN A03_2.WarehouseName ELSE A06.RDAddress END) AS ExWarehouseName
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
A07.ReVoucherID AS ReVoucherID_AT2007, A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID,(SELECT REPLACE (A07.Ana08ID,''-'+@DivisionID+''','''' )) as Ana08ID, A07.Ana09ID, A07.Ana10ID,
A1.AnaName as Ana01Name, A2.AnaName as Ana02Name, A3.AnaName as Ana03Name, A4.AnaName as Ana04Name, A5.AnaName as Ana05Name,
A6.AnaName as Ana06Name, A7.AnaName as Ana07Name, A8.AnaName as Ana08Name, A9.AnaName as Ana09Name, A10.AnaName as Ana10Name,  
A07.PeriodID, A07.ProductID, A07.OrderID AS OrderID_AT2007, A07.InventoryName1, 
'
SET @sSQL1A=N'
A07.OTransactionID, A07.ReSPVoucherID, A07.ReSPTransactionID, A07.ETransactionID, A07.MTransactionID,
A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A07.ConvertedQuantity, A07.ConvertedPrice, A07.ConvertedUnitID, A07.MOrderID as MOrderID_AT2007,
A07.SOrderID, A07.STransactionID, A07.LocationCode, A07.Location01ID, A07.Location02ID, A07.Location03ID, A07.Location04ID, A07.Location05ID, A07.MarkQuantity, A07.OExpenseConvertedAmount, 
A07.WVoucherID, A07.Notes01, A07.Notes02, '+CASE WHEN @CustomerName = 67 THEN N'(select Name From KHV)' ELSE 'A07.Notes03' END +' AS Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08, A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15,
A07.RefInfor, A07.StandardPrice, A07.StandardAmount, A07.InheritTableID, A07.InheritVoucherID, A07.InheritTransactionID, A07.KITID, A07.KITQuantity, A07.TVoucherID, A07.SOrderIDRecognition,
A07.SerialNo, A07.WarrantyCard, A16.BankAccountNo, A16.BankName, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson, 0 AS ItemTypeID, 5 AS InvoiceTypeID
,(SELECT InvoiceSign FROM WT0000) AS ParentInvoiceSign, (SELECT Serial FROM WT0000) AS ParentSerial, 1 AS PayMethodID, (SELECT Serial FROM WT0000) AS Serial,(SELECT InvoiceSign FROM WT0000) AS InvoiceSign,
A06.VoucherDate AS InvoiceDate, 0 AS VAT_Rate, 1 AS Extra, A02.TradeName AS CusBankName, A07.Notes04 AS KindOfService, '''' AS CusTaxCode, NULL AS Extra1,
'+CASE WHEN @CustomerName = 67 THEN 'A03.WareHouseName +''|''+ A06.VoucherID' ELSE '''''' END +' AS ExtraKHV
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
--ORDER BY A07.Orders
'

--print @sSQL
--print @sSQL1A


EXEC (@sSQL + @sSQL1A)


END
ELSE -- HDDT
BEGIN
SET @sSQL = '     
SELECT ROW_NUMBER() OVER(ORDER BY AT9000.Orders) AS Remark, ISNULL(AT1202.EInvoiceObjectID, AT9000.ObjectID) AS CusCode, 
CASE WHEN ISNULL(AT9000.VATObjectName,'''') <> '''' THEN AT9000.VATObjectName ELSE AT1202.ObjectName END AS CusName, 
AT9000.VATObjectAddress AS CusAddress, AT1202.Tel AS CusPhone,  AT1202.Email AS CusEmail, '''' AS CusEmailCC, AT9000.VATNo AS CusTaxCode,
AT9000.VDescription AS Buyer, ' + 
CASE WHEN @CustomerName = 2 THEN 'AT1202.BankAccountNo AS CusbankNo, AT1202.BankName AS CusBankName,'
							ELSE 'AT1202.TradeName AS CusbankNo, AT1202.TradeName AS CusBankName,' END + '
ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0)
- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS Total,

ISNULL((SELECT SUM(ABS(DiscountAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'')), 0) + ISNULL(ABS(DiscountSalesAmount), 0) AS DiscountAmount,
ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T14'',''T34'',''T35'')), 0) AS VATAmount,

ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T14'',''T24'',''T34'',''T25'',''T35'')), 0) 
- ISNULL((SELECT SUM(ABS(ConvertedAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T64'')),0) AS AfterAmount,
	
ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T00''), 0) AS VATAmount0,
ISNULL((SELECT SUM(ABS(OriginalAmount)) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.DivisionID = AT9000.DivisionID AND AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN (''T04'',''T24'',''T25'') AND VATGroupID = ''T10''), 0) AS VATAmount10,
'
SET @sSQL1A=N'
CASE WHEN AT9000.VATGroupID=''TS0'' THEN 0 ELSE AT1010.VATRate END AS VAT_Rate, AT9000.InventoryID AS ProdID, 
	
'+ CASE  @CustomerName 
WHEN 67 THEN ' CASE WHEN ISNULL(A05.AnaName,'''')<>'''' THEN ISNULL(AT9000.InventoryName1,AT1302.InventoryName) + ''-'' + A05.AnaName ELSE ISNULL(AT9000.InventoryName1,AT1302.InventoryName) END ' 
WHEN 32 THEN ' CASE WHEN AT9000.InventoryID = ''BK001'' THEN AT9000.TDescription ELSE ISNULL(AT9000.InventoryName1,AT1302.InventoryName) END'
ELSE 'ISNULL(AT9000.InventoryName1,AT1302.InventoryName)' END +' AS ProdName, 

ISNULL(AT9000.DParameter01,AT1304.UnitName) AS ProdUnit, ISNULL(AT9000.DParameter02,AT9000.Quantity) AS ProdQuantity, 
ISNULL(AT9000.DParameter03,ABS(AT9000.UnitPrice)) AS ProdPrice, ' + 
CASE WHEN @CustomerName = 2 THEN 'CASE WHEN AT9000.Serial = ''EX/21E'' THEN ABS(AT9000.OriginalAmount) ELSE ABS(AT9000.ConvertedAmount) END AS Amount,'
							ELSE 'ISNULL(AT9000.DParameter04,ABS(AT9000.ConvertedAmount)) AS Amount,' END + '
AT9000.InheritFkey, AT9000.EInvoiceType, AT9000.TypeOfAdjust, ISNULL(AT9000.TDescription,'''') AS TDescription, A02.AnaName as Ana02Name,
AT9000.PaymentID AS PaymentMethod,
AT9000.BDescription as DonDatHangSo, ABS(AT9000.OriginalAmount) AS OriginalAmount, ISNULL(A02.AnaName+''/''+AT9000.VDescription,AT9000.VDescription) AS KindOfService, 
AT9000.CurrencyID as Extra1, AT9000.ExchangeRate AS Extra,
AT9000.InvoiceDate, AT9000.CurrencyID, AT9000.PaymentID, AT9000.VoucherNo,
AT9000.VoucherID, AT9000.BatchID, AT9000.TransactionID, AT9000.TableID, AT9000.TranMonth, AT9000.TranYear, AT9000.TransactionTypeID, AT9000.ObjectID, AT9000.CreditObjectID, AT9000.VATNo,
AT9000.VATObjectID, AT9000.VATObjectName, AT9000.VATObjectAddress, AT9000.DebitAccountID, AT9000.CreditAccountID, AT9000.ExchangeRate, AT9000.UnitPrice, AT9000.OriginalAmount as OriginalAmountAT9000,
AT9000.ConvertedAmount, AT9000.ImTaxOriginalAmount, AT9000.ImTaxConvertedAmount, AT9000.ExpenseOriginalAmount, AT9000.ExpenseConvertedAmount, AT9000.IsStock, AT9000.VoucherDate,
AT9000.VoucherTypeID, AT9000.VATGroupID, AT9000.Serial, AT9000.InvoiceNo, AT9000.Orders, AT9000.EmployeeID, AT9000.SenderReceiver, AT9000.SRDivisionName, AT9000.SRAddress,
AT9000.RefNo01, AT9000.RefNo02, AT9000.VDescription, AT9000.BDescription, AT9000.Quantity, AT9000.InventoryID, ISNULL(AT9000.DParameter01,AT9000.UnitID) UnitID, AT9000.Status, AT9000.IsAudit, AT9000.IsCost, 
AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, AT9000.PeriodID,
AT9000.ExpenseID, AT9000.MaterialTypeID, AT9000.ProductID, AT9000.CreateDate, AT9000.CreateUserID, AT9000.LastModifyUserID, AT9000.LastModifyDate, AT9000.OriginalAmountCN,
AT9000.ExchangeRateCN, AT9000.CurrencyIDCN, AT9000.DueDays, AT9000.DueDate, AT9000.DiscountRate, AT9000.OrderID, AT9000.CreditBankAccountID, AT9000.DebitBankAccountID,
AT9000.CommissionPercent, AT9000.InventoryName1, AT9000.PaymentTermID,
'
SET @sSQL1A1=N' AT9000.DiscountAmount as DiscountAmountAT9000, AT9000.OTransactionID, AT9000.IsMultiTax, 
ABS(AT9000.VATOriginalAmount) AS VATOriginalAmount, ' + 
CASE WHEN @CustomerName = 2 THEN 'CASE WHEN AT9000.Serial = ''EX/21E'' THEN ABS(AT9000.VATOriginalAmount)
										ELSE ABS(AT9000.VATConvertedAmount) END AS VATConvertedAmount,'
							ELSE 'ABS(AT9000.VATConvertedAmount) AS VATConvertedAmount,' END + '
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
A07.AnaName as Ana07Name, A08.AnaName as Ana08Name, A09.AnaName as Ana09Name, A10.AnaName as Ana10Name,


AT9000.ABParameter01,AT9000.ABParameter02,AT9000.ABParameter03,AT9000.ABParameter04,AT9000.ABParameter05,AT9000.ABParameter06,
AT9000.ABParameter07,AT9000.ABParameter08,AT9000.ABParameter09,AT9000.ABParameter10,AT9000.SOAna01ID,AT9000.SOAna02ID,AT9000.SOAna03ID,AT9000.SOAna04ID,AT9000.SOAna05ID,
AT9000.IsVATWithhodingTax,AT9000.VATWithhodingRate,AT9000.IsEInvoice,AT9000.EInvoiceStatus,AT9000.IsAdvancePayment,AT9000.Fkey,AT9000.IsInheritInvoicePOS,
AT9000.InheritInvoicePOS,AT9000.IsInheritPayPOS,AT9000.InheritPayPOS,AT9000.IsInvoiceSuggest,AT9000.RefVoucherDate,AT9000.IsDeposit,AT9000.ReTransactionTypeID,'
SET @sSQL2A=' AT9000.ImVoucherID,AT9000.ImTransactionID,AT9000.SourceNo,AT9000.LimitDate,AT9000.IsPromotionItem,AT9000.ObjectName1,
CASE AT9000.VATGroupID WHEN ''T00'' THEN 1 WHEN ''T05'' THEN 2 WHEN ''T10'' THEN 3 WHEN ''TS0'' THEN 4 WHEN ''TZ0'' THEN 5 ELSE NULL END AS TaxRateID,
(dbo.GetPayMethodID(AT9000.PaymentID,'''',0)) as PayMethodID, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice, AT9000.IsReceived,
A16.BankAccountNo, A16.BankName, A26.ContactPerson, 
ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as DVATOriginalAmount, ' + 
CASE WHEN @CustomerName = 2 THEN 'CASE WHEN AT9000.Serial = ''EX/21E'' THEN ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0)
										ELSE ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) END AS DVATConvertedAmount,'
							ELSE 'ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) AS DVATConvertedAmount,' END + '
A13.UnitName AS ConvertedUnitName, A12.PaymentName, CASE WHEN TransactionTypeID = ''T64'' THEN 1 ELSE 0 END AS IsDiscount, A11.DivisionNameE, A11.AddressE, A11.District, A11.ContactPerson as DContactPerson,
ISNULL(AT9000.OriginalAmount,0) + ISNULL(AT1010.VATRate*AT9000.OriginalAmount/100,0) as OriginalAfterVATAmount, 
ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT1010.VATRate*AT9000.ConvertedAmount/100,0) AS ConvertedAfterVATAmount,
A27.SourceNo as WSourceNo, CONVERT(NVARCHAR(10),A27.LimitDate,103) as WLimitDate, AT1302.I04ID, AT1015.AnaName as I04Name,
(SELECT TOP 1 InvoiceSign  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentInvoiceSign,
(SELECT TOP 1 Serial  FROM AT9000 A90 WITH (NOLOCK) WHERE A90.VoucherID = AT9000.InheritFkey) AS ParentSerial,
AT1202.BankAccountNo as CusBankAccountNo'+@sSQL6+' 

INTO #TEMP
FROM AT9000 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT9000.UnitID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.VATObjectID	
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
LEFT JOIN AT2006 A26 WITH (NOLOCK) ON AT9000.VoucherID = A26.VoucherID AND A26.KindVoucherID=4
LEFT JOIN AT1304 A13 WITH (NOLOCK) ON A13.UnitID = AT9000.ConvertedUnitID
LEFT JOIN AT1205 A12 WITH (NOLOCK) ON A12.PaymentID = AT9000.PaymentID
LEFT JOIN AT2007 A27 WITH (NOLOCK) ON A27.VoucherID = A26.VoucherID AND A27.TransactionID = AT9000.TransactionID
LEFT JOIN AT1015 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1015.DivisionID,''@@@'') AND AT1015.AnaTypeID = ''I04'' and AT1015.AnaID=AT1302.I04ID
WHERE AT9000.DivisionID = ''' + @DivisionID + '''
AND AT9000.VoucherID = ''' + @VoucherID + ''' 
AND AT9000.TransactionTypeID IN (''T04'',''T25'',''T24'',''T64'')
ORDER BY AT9000.Orders
'

IF @CustomerName = 61 -- FUYUER
BEGIN
	SET @sSQL6 = ',ArisingDate'
END
 
SET @sSQLA = '
	SELECT * FROM (
		SELECT	TOP 100 PERCENT Remark, CusCode, CusName, CusAddress, CusPhone, CusEmail,CusEmailCC, CusTaxCode, Buyer, CusbankNo,CusBankName, PaymentMethod, 
			Total, DiscountAmount, AfterAmount, VATAmount, CASE VAT_Rate
														                 WHEN 3.5 THEN 5
																		 WHEN 7  THEN 10
														   ELSE VAT_Rate END AS VAT_Rate,
			--CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATAmount END AS VATAmount, 
			--CASE WHEN ISNULL(VATAmount, 0) = 0 AND ISNULL(VATRate, 0) = 0 THEN -1 ELSE VATRate END AS VATRate, 
			ProdID, ProdName, ProdUnit, ProdQuantity, ProdPrice, Amount, InheritFkey, EInvoiceType, TypeOfAdjust, TDescription, Ana02ID, Ana02Name,
			DonDatHangSo, OriginalAmount, CASE WHEN VAT_Rate IN (3.5,7) THEN ''70'' ELSE KindOfService END AS KindOfService, Extra1, VATAmount0, VATAmount10, Extra, InvoiceDate, CurrencyID, PaymentID, VoucherNo,
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
			 '
			 SET @sSQLB ='VirtualPrice, VirtualAmount, ReTableID, DParameter01, DParameter02, DParameter03, DParameter04, DParameter05, DParameter06,
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
			 OriginalAfterVATAmount, ConvertedAfterVATAmount, WSourceNo, WLimitDate, I04ID, I04Name, 0 as ItemTypeID,
			 ParentInvoiceSign, ParentSerial,
			 CusBankAccountNo'+@sSQL6+'
		FROM #TEMP
		ORDER BY Remark
	) X
'	
IF EXISTS (SELECT TOP 1 1  FROM AT0000 WHERE DefDivisionID=@DivisionID AND EInvoicePartner='BKAV') AND EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND ISNULL(Parameter10,'') <> '')
	begin
		SET @sSQL3='
		UNION ALL

		SELECT DISTINCT
		999999  AS Remark, CusCode AS CusCode ,   CusName AS CusName,CusAddress AS CusAddress, '''' AS CusPhone,  '''' AS CusEmail, '''' AS CusEmailCC, '''' AS CusTaxCode,
		Buyer AS Buyer, '''' AS CusbankNo,'''' AS CusBankName,  '''' AS PaymentMethod,  0 AS Total,  0 AS DiscountAmount,  0 AS AfterAmount,  0 AS VATAmount ,  0 AS VAT_Rate,
		'''' AS ProdID, Parameter10 AS ProdName,'''' AS ProdUnit, 0 AS ProdQuantity , 0 AS ProdPrice,0 AS Amount , '''' AS InheritFkey , 
		0 AS EInvoiceType,   0 AS TypeOfAdjust, '''' AS TDescription, '''' AS Ana02ID , '''' AS Ana02Name,
		'''' AS DonDatHangSo,  0 AS OriginalAmount, '''' AS KindOfService, CurrencyID AS Extra1 ,  0 AS VATAmount0, 
		0 AS VATAmount10,  1 AS Extra,InvoiceDate , CurrencyID , '''' AS VoucherID , '''' AS PaymentID , '''' AS  VoucherNo ,'''' AS BatchID,  '''' AS TransactionID ,  '''' AS TableID, 0 AS TranMonth , 
		0 AS TranYear,'''' AS TransactionTypeID ,'''' AS ObjectID , '''' AS CreditObjectID , '''' AS VATNo ,'''' AS VATObjectID , 
		'''' AS VATObjectName,'''' AS VATObjectAddress, '''' AS DebitAccountID , '''' AS CreditAccountID , 1 AS  ExchangeRate, 
		0 AS UnitPrice,  0 AS OriginalAmountAT9000,  0 AS ConvertedAmount, 0 AS ImTaxOriginalAmount , 0 AS ImTaxConvertedAmount , 
		0 AS ExpenseOriginalAmount , 0 AS ExpenseConvertedAmount , 0 AS IsStock ,'''' AS VoucherDate , '''' AS VoucherTypeID , 
		'''' AS VATGroupID, '''' AS Serial ,'''' AS InvoiceNo , 0 AS Orders,'''' AS EmployeeID , 
		'''' AS SenderReceiver,'''' AS SRDivisionName,'''' AS SRAddress, '''' AS RefNo01 ,'''' AS RefNo02 , '''' AS VDescription, 
		'''' AS BDescription, 0 AS Quantity ,'''' AS InventoryID ,'''' AS UnitID ,'''' AS Status ,0 AS IsAudit  , 0 AS IsCost , 
		'''' AS Ana01ID , '''' AS Ana03ID ,'''' AS Ana04ID ,'''' AS Ana05ID ,'''' AS Ana06ID , '''' AS Ana07ID ,'''' AS Ana08ID , '''' AS Ana09ID , 
		'''' AS Ana10ID ,'''' AS PeriodID , '''' AS ExpenseID ,'''' AS MaterialTypeID , '''' AS ProductID ,'''' AS CreateDate , 
		'''' AS CreateUserID , '''' AS LastModifyDate ,'''' AS LastModifyUserID ,0 AS OriginalAmountCN ,1 AS ExchangeRateCN ,'''' AS CurrencyIDCN , 
		0 AS DueDays , '''' AS DueDate, 0 AS DiscountRate , '''' AS OrderID , '''' AS CreditBankAccountID ,'''' AS DebitBankAccountID ,
		0 AS CommissionPercent , '''' AS InventoryName1,'''' AS PaymentTermID , 0 AS DiscountAmountAT9000, 
		'''' AS OTransactionID ,0 AS IsMultiTax  , 0 AS VATOriginalAmount, 0 AS VATConvertedAmount , '''' AS ReVoucherID ,'''' AS ReBatchID , 
		'''' AS ReTransactionID , '''' AS Parameter01,'''' AS Parameter02,'''' AS Parameter03, '''' AS Parameter04, '''' AS Parameter05, 
		'''' AS Parameter06, '''' AS Parameter07, '''' AS Parameter08, '''' AS Parameter09, '''' AS Parameter10 ,'''' AS MOrderID , 
		'''' AS SOrderID ,'''' AS MTransactionID ,'''' AS STransactionID ,'''' AS RefVoucherNo , 0 AS IsLateInvoice  ,  0 AS ConvertedQuantity, 
		0 AS ConvertedPrice ,'''' AS ConvertedUnitID ,  0 AS ConversionFactor, 0 AS UParameter01 ,  0 AS UParameter02, 0 AS UParameter03 , 
		0 AS UParameter04 , 0 AS UParameter05 , '''' AS PriceListID ,
		 '''' AS WOrderID , '''' AS WTransactionID , 0 AS MarkQuantity,'''' AS TVoucherID , 0 AS OldCounter , 
		0 AS NewCounter ,  0 AS OtherCounter, '''' AS TBatchID , '''' AS ContractDetailID , '''' AS InvoiceCode , '''' AS InvoiceSign , 
		'''' AS RefInfor,0 AS StandardPrice, 0 AS StandardAmount ,0 AS IsCom  , 0 AS VirtualPrice , 0 AS VirtualAmount , 
		'''' AS ReTableID , '''' AS DParameter01, '''' AS DParameter02, '''' AS DParameter03, '''' AS DParameter04, '''' AS DParameter05, 
		'''' AS DParameter06, '''' AS DParameter07,'''' AS DParameter08, '''' AS DParameter09, '''' AS DParameter10,'''' AS InheritTableID , 
		'''' AS InheritVoucherID , '''' AS InheritTransactionID , '''' AS ETaxVoucherID ,  '''' AS ETaxID,  0 AS ETaxConvertedUnit, 
		0 AS ETaxConvertedAmount , '''' AS ETaxTransactionID ,  0 AS AssignedSET , '''' AS SETID , '''' AS SETUnitID ,0 AS  SETTaxRate , 
		0 AS SETConvertedUnit ,0 AS  SETQuantity ,  0 AS SETOriginalAmount,  0 AS SETConvertedAmount, '''' AS SETConsistID , 
		'''' AS SETTransactionID ,0 AS AssignedNRT  '
		SET @sSQL3_A='
		, 0 AS NRTTaxAmount ,'''' AS NRTClassifyID ,'''' AS  NRTUnitID ,0 AS NRTTaxRate , 
		0 AS NRTConvertedUnit,0 AS NRTQuantity ,0 AS NRTOriginalAmount ,0 AS NRTConvertedAmount , '''' AS NRTConsistID , 
		'''' AS NRTTransactionID , '''' AS CreditObjectName , '''' AS CreditVATNo ,0 AS IsPOCost  , 0 AS TaxBaseAmount, 0 AS WTCExchangeRate , 
		0 AS WTCOperator ,  0 AS IsFACost , 0 AS IsInheritFA  , '''' AS InheritedFAVoucherID , 0 AS AVRExchangeRate ,0 AS PaymentExchangeRate , 
		0 AS IsMultiExR , '''' AS ExchangeRateDate ,0 AS DiscountSalesAmount , 0 AS  IsProInventoryID , 0 AS InheritQuantity,0 AS DiscountPercentSOrder , 
		0 AS DiscountAmountSOrder , 0 AS IsWithhodingTax ,0 AS IsSaleInvoice  ,'''' AS WTTransID ,0 AS DiscountSaleAmountDetail , 
		'''' AS ABParameter01 , '''' AS ABParameter02, '''' AS ABParameter03 , '''' AS ABParameter04, '''' AS ABParameter05, 
		'''' AS ABParameter06, '''' AS ABParameter07, '''' AS ABParameter08, '''' AS ABParameter09, '''' AS ABParameter10, '''' AS SOAna01ID , 
		'''' AS SOAna02ID,'''' AS SOAna03ID, '''' AS SOAna04ID, '''' AS SOAna05ID,0 AS IsVATWithhodingTax  ,0 AS VATWithhodingRate , 
		0 AS IsEInvoice , 0 AS EInvoiceStatus , 0 AS IsAdvancePayment ,'''' AS Fkey ,  0 AS IsInheritInvoicePOS , '''' AS InheritInvoicePOS , 
		0 AS IsInheritPayPOS ,  '''' AS InheritPayPOS, 0 AS IsInvoiceSuggest  , '''' AS RefVoucherDate ,0 AS IsDeposit  ,'''' AS ReTransactionTypeID , 
		'''' AS ImVoucherID ,'''' AS ImTransactionID ,'''' AS SourceNo ,'''' AS LimitDate , 0 AS IsPromotionItem  , '''' AS ObjectName1, '''' AS TaxRateID,  2 AS PayMethodID ,
		0 AS DiscountedUnitPrice, 0 AS ConvertedDiscountedUnitPrice ,0 AS IsReceived  , '''' AS Ana01Name, '''' AS Ana03Name, '''' AS Ana04Name,
		'''' AS Ana05Name, '''' AS Ana06Name, '''' AS Ana07Name,'''' AS Ana08Name, '''' AS Ana09Name, '''' AS Ana10Name,
		'''' AS BankAccountNo , '''' AS BankName ,'''' AS  ContactPerson ,  0 AS DVATOriginalAmount,0 AS DVATConvertedAmount , 
		'''' AS ConvertedUnitName, '''' AS PaymentName , 0 AS IsDiscount , '''' AS DivisionNameE , '''' AS AddressE ,'''' AS District ,'''' AS DContactPerson ,
		0 AS OriginalAfterVATAmount , 0 AS ConvertedAfterVATAmount, '''' AS WSourceNo , '''' AS WLimitDate ,'''' AS I04ID ,'''' AS I04Name,  4 AS ItemTypeID, NULL AS CusBankAccountNo,NULL AS ParentInvoiceSign, NULL AS ParentSerial
	FROM #TEMP

	'
END
-- [Tiên Tiến] Lấy thêm trường parameter01 vào dòng ghi chú
IF @CustomerName = 13
	SET @sSQL4 = '
		UNION ALL

		SELECT top 1
		999999  AS Remark, CusCode AS CusCode ,   CusName AS CusName,CusAddress AS CusAddress, '''' AS CusPhone,  '''' AS CusEmail, '''' AS CusEmailCC, '''' AS CusTaxCode,
		Buyer AS Buyer, '''' AS CusbankNo,'''' AS CusBankName,  '''' AS PaymentMethod,  0 AS Total,  0 AS DiscountAmount,  0 AS AfterAmount,  0 AS VATAmount ,  0 AS VAT_Rate,
		'''' AS ProdID, Parameter01 AS ProdName,'''' AS ProdUnit, 0 AS ProdQuantity , 0 AS ProdPrice,0 AS Amount , '''' AS InheritFkey , 
		0 AS EInvoiceType,   0 AS TypeOfAdjust, '''' AS TDescription, '''' AS Ana02ID , '''' AS Ana02Name,
		'''' AS DonDatHangSo,  0 AS OriginalAmount, '''' AS KindOfService, CurrencyID AS Extra1 ,  0 AS VATAmount0, 
		0 AS VATAmount10,  1 AS Extra,InvoiceDate , CurrencyID , '''' AS VoucherID , '''' AS PaymentID , '''' AS  VoucherNo ,'''' AS BatchID,  '''' AS TransactionID ,  '''' AS TableID, 0 AS TranMonth , 
		0 AS TranYear,'''' AS TransactionTypeID ,'''' AS ObjectID , '''' AS CreditObjectID , '''' AS VATNo ,'''' AS VATObjectID , 
		'''' AS VATObjectName,'''' AS VATObjectAddress, '''' AS DebitAccountID , '''' AS CreditAccountID , 1 AS  ExchangeRate, 
		0 AS UnitPrice,  0 AS OriginalAmountAT9000,  0 AS ConvertedAmount, 0 AS ImTaxOriginalAmount , 0 AS ImTaxConvertedAmount , 
		0 AS ExpenseOriginalAmount , 0 AS ExpenseConvertedAmount , 0 AS IsStock ,'''' AS VoucherDate , '''' AS VoucherTypeID , 
		'''' AS VATGroupID, '''' AS Serial ,'''' AS InvoiceNo , 0 AS Orders,'''' AS EmployeeID , 
		'''' AS SenderReceiver,'''' AS SRDivisionName,'''' AS SRAddress, '''' AS RefNo01 ,'''' AS RefNo02 , '''' AS VDescription, 
		'''' AS BDescription, 0 AS Quantity ,'''' AS InventoryID ,'''' AS UnitID ,'''' AS Status ,0 AS IsAudit  , 0 AS IsCost , 
		'''' AS Ana01ID , '''' AS Ana03ID ,'''' AS Ana04ID ,'''' AS Ana05ID ,'''' AS Ana06ID , '''' AS Ana07ID ,'''' AS Ana08ID , '''' AS Ana09ID , 
		'''' AS Ana10ID ,'''' AS PeriodID , '''' AS ExpenseID ,'''' AS MaterialTypeID , '''' AS ProductID ,'''' AS CreateDate , 
		'''' AS CreateUserID , '''' AS LastModifyDate ,'''' AS LastModifyUserID ,0 AS OriginalAmountCN ,1 AS ExchangeRateCN ,'''' AS CurrencyIDCN , 
		0 AS DueDays , '''' AS DueDate, 0 AS DiscountRate , '''' AS OrderID , '''' AS CreditBankAccountID ,'''' AS DebitBankAccountID ,
		0 AS CommissionPercent , '''' AS InventoryName1,'''' AS PaymentTermID , 0 AS DiscountAmountAT9000, 
		'''' AS OTransactionID ,0 AS IsMultiTax  , 0 AS VATOriginalAmount, 0 AS VATConvertedAmount , '''' AS ReVoucherID ,'''' AS ReBatchID , 
		'''' AS ReTransactionID , '''' AS Parameter01,'''' AS Parameter02,'''' AS Parameter03, '''' AS Parameter04, '''' AS Parameter05, 
		'''' AS Parameter06, '''' AS Parameter07, '''' AS Parameter08, '''' AS Parameter09, '''' AS Parameter10 ,'''' AS MOrderID , 
		'''' AS SOrderID ,'''' AS MTransactionID ,'''' AS STransactionID ,'''' AS RefVoucherNo , 0 AS IsLateInvoice  ,  0 AS ConvertedQuantity, 
		0 AS ConvertedPrice ,'''' AS ConvertedUnitID ,  0 AS ConversionFactor, 0 AS UParameter01 ,  0 AS UParameter02, 0 AS UParameter03 , 
		0 AS UParameter04 , 0 AS UParameter05 , '''' AS PriceListID ,
		 '''' AS WOrderID , '''' AS WTransactionID , 0 AS MarkQuantity,'''' AS TVoucherID , 0 AS OldCounter , 
		0 AS NewCounter ,  0 AS OtherCounter, '''' AS TBatchID , '''' AS ContractDetailID , '''' AS InvoiceCode , '''' AS InvoiceSign , 
		'''' AS RefInfor,0 AS StandardPrice, 0 AS StandardAmount ,0 AS IsCom  , 0 AS VirtualPrice , 0 AS VirtualAmount , 
		'''' AS ReTableID , '''' AS DParameter01, '''' AS DParameter02, '''' AS DParameter03, '''' AS DParameter04, '''' AS DParameter05, 
		'''' AS DParameter06, '''' AS DParameter07,'''' AS DParameter08, '''' AS DParameter09, '''' AS DParameter10,'''' AS InheritTableID , 
		'''' AS InheritVoucherID , '''' AS InheritTransactionID , '''' AS ETaxVoucherID ,  '''' AS ETaxID,  0 AS ETaxConvertedUnit, 
		0 AS ETaxConvertedAmount , '''' AS ETaxTransactionID ,  0 AS AssignedSET , '''' AS SETID , '''' AS SETUnitID ,0 AS  SETTaxRate , 
		0 AS SETConvertedUnit ,0 AS  SETQuantity ,  0 AS SETOriginalAmount,  0 AS SETConvertedAmount, '''' AS SETConsistID , 
		'''' AS SETTransactionID ,0 AS AssignedNRT  , 0 AS NRTTaxAmount ,'''' AS NRTClassifyID ,'''' AS  NRTUnitID ,0 AS NRTTaxRate , 
		0 AS NRTConvertedUnit,0 AS NRTQuantity ,0 AS NRTOriginalAmount ,0 AS NRTConvertedAmount , '''' AS NRTConsistID , 
		'''' AS NRTTransactionID , '''' AS CreditObjectName , '''' AS CreditVATNo ,0 AS IsPOCost  , 0 AS TaxBaseAmount, 0 AS WTCExchangeRate , 
		0 AS WTCOperator ,  0 AS IsFACost , 0 AS IsInheritFA  , '''' AS InheritedFAVoucherID , 0 AS AVRExchangeRate ,0 AS PaymentExchangeRate , 
		0 AS IsMultiExR , '''' AS ExchangeRateDate ,0 AS DiscountSalesAmount , 0 AS  IsProInventoryID , 0 AS InheritQuantity,0 AS DiscountPercentSOrder , 
		0 AS DiscountAmountSOrder , 0 AS IsWithhodingTax ,0 AS IsSaleInvoice  ,'''' AS WTTransID ,0 AS DiscountSaleAmountDetail , 
		'''' AS ABParameter01 , '''' AS ABParameter02, '''' AS ABParameter03 , '''' AS ABParameter04, '''' AS ABParameter05, 
		'''' AS ABParameter06, '''' AS ABParameter07, '''' AS ABParameter08, '''' AS ABParameter09, '''' AS ABParameter10, '''' AS SOAna01ID , 
		'''' AS SOAna02ID,'''' AS SOAna03ID, '''' AS SOAna04ID, '''' AS SOAna05ID,0 AS IsVATWithhodingTax  ,0 AS VATWithhodingRate , 
		0 AS IsEInvoice , 0 AS EInvoiceStatus , 0 AS IsAdvancePayment ,'''' AS Fkey ,  0 AS IsInheritInvoicePOS , '''' AS InheritInvoicePOS , 
		0 AS IsInheritPayPOS ,  '''' AS InheritPayPOS, 0 AS IsInvoiceSuggest  , '''' AS RefVoucherDate ,0 AS IsDeposit  ,'''' AS ReTransactionTypeID , 
		'''' AS ImVoucherID ,'''' AS ImTransactionID ,'''' AS SourceNo ,'''' AS LimitDate , 0 AS IsPromotionItem  , '''' AS ObjectName1, '''' AS TaxRateID,  2 AS PayMethodID ,
		0 AS DiscountedUnitPrice, 0 AS ConvertedDiscountedUnitPrice ,0 AS IsReceived  , '''' AS Ana01Name, '''' AS Ana03Name, '''' AS Ana04Name,
		'''' AS Ana05Name, '''' AS Ana06Name, '''' AS Ana07Name,'''' AS Ana08Name, '''' AS Ana09Name, '''' AS Ana10Name,
		'''' AS BankAccountNo , '''' AS BankName ,'''' AS  ContactPerson ,  0 AS DVATOriginalAmount,0 AS DVATConvertedAmount , 
		'''' AS ConvertedUnitName, '''' AS PaymentName , 0 AS IsDiscount , '''' AS DivisionNameE , '''' AS AddressE ,'''' AS District ,'''' AS DContactPerson ,
		0 AS OriginalAfterVATAmount , 0 AS ConvertedAfterVATAmount, '''' AS WSourceNo , '''' AS WLimitDate ,'''' AS I04ID ,'''' AS I04Name,  4 AS ItemTypeID, NULL AS CusBankAccountNo,NULL AS ParentInvoiceSign, NULL AS ParentSerial
	FROM #TEMP

	'


--print @sSQL
--print @sSQL1A
--print @sSQL1A1
--print @sSQL2A
--print @sSQLA
--print @sSQLB
--print @sSQL3
--print @sSQL3_A
--PRINT @sSQL4
EXEC (@sSQL+@sSQL1A+@sSQL1A1+@sSQL2A+@sSQLA+@sSQLB+@sSQL3+@sSQL3_A+@sSQL4)
END

	



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
