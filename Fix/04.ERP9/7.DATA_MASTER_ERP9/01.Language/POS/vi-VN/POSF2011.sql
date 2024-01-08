
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF2011';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Cập nhật phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng/event';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberNameOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.SaleManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã lập phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.BookingAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gói sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%CK';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DiscountRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền CK';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.TaxAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryAmount' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PTTT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên PTTT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.APKMaster.POS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao hàng cho khách';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DeliveryToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách đến nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberToTake' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán 1';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName01.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán 2';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName02.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.WareHouseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.ViewWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng cộng:';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.SubTotal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ {0} đã tồn tại. Hệ thống đã cập nhật số chứng từ mới {1}';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherNoUpdated' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberID' , @FormID, @LanguageValue, @Language;