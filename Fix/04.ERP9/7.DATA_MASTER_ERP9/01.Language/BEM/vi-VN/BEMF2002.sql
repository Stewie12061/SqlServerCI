-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2002 - BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2002';

SET @LanguageValue = N'Số tiền tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKDInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKMaster';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKMInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovedLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApprovedLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApproveLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovingLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chủ tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn cuối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn ứng dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritType';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritVoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Ringi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết phiếu DNTT/DNTTTU/DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinChiTietDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu DNTT/DNTTTU/DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.ThongTinDNTT_DNTTTU_DNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết phiếu DNTT/DNTTTU/DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2002.TypeName', @FormID, @LanguageValue, @Language;
