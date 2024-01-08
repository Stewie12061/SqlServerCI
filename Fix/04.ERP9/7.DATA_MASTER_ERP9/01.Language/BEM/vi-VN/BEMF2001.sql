-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2001 - BEM
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
SET @FormID = 'BEMF2001';

SET @LanguageValue = N'APKMaster';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKMInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovedLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovedLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApproveLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovingLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chủ tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankAccountNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chủ tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.BankName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CostAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn cuối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản trung gian';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MediumAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phương thức';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phương thức';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã điều khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên điều khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PaymentTermName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Ringi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phiếu DNTT/DNTTTU/DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKDInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn ứng dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.Inherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa DNCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritDNCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritDNTU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritType';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritVoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceCurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceCurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FormationID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FormationName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn hình thành';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.FormationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.ApplicantName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2001.AdvanceUserName.CB', @FormID, @LanguageValue, @Language;