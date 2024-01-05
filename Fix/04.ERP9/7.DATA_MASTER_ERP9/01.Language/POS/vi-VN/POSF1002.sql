------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1002 - POS
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
SET @FormID = 'POSF1002';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem chi tiết event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ShopName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DisabledEvent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EventBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.GeneralInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CommodityInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên thuộc event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeesOfEventTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.BillingInformation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo cột giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PriceColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cột giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.IsColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PackagePriceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.IsPackage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán hàng theo bảng giá khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PromotePriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi theo hàng tặng hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PromoteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kho chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ComWarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Selected' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ (thuế)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TaxDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có (thuế)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TaxCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ (trả hàng)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PayDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có (trả hàng)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PayCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ (hóa đơn)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có (hóa đơn)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ (chi phí)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CostDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có (chi phí)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CostCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhập';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu hàng bán trả lại';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu kiểm kê kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhật ký';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị xuất trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu chệnh lệch';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị vận chuyển nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu vận chuyển nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu số dư hàng tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType13' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType14' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị chi';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType16' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType17' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType18' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType19' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bút toán tổng hợp';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType20' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.LastModifyUserID' , @FormID, @LanguageValue, @Language;
