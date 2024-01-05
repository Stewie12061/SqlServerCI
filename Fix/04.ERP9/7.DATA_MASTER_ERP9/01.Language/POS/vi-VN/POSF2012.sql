
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
SET @FormID = 'POSF2012';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Xem chi tiết phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng/event';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.SaleManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã lập phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.BookingAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gói sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.PackageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%CK';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DiscountRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền CK';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TaxAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Note' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabThongTinPhieuChungTu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.LastModifyDate' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao hàng cho khách';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DeliveryToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách đến nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberToTake' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberName' , @FormID, @LanguageValue, @Language;