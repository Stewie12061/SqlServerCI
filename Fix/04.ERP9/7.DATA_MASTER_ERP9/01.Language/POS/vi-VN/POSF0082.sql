
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
SET @FormID = 'POSF0082';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Xem chi tiết phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nộp tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CashierID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherNoInherited' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabThongTinPhieuThu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bán/đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.VoucherNoInherited' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết phiếu thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.TabPOST00802' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền phải thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberIDOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.MemberNameOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đặt cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.DepositVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0082.ServiceRequestVoucherNo' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;