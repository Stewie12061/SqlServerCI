-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2000 - BEM
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
SET @FormID = 'BEMF2000';

SET @LanguageValue = N'Số tiền yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng tạm ứng/thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKDInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKMaster';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APKMInherited';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovedLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApprovedLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApproveLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ApprovingLevel';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chủ tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.BankAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ConvertedRequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ConvertedSpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn cuối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Deadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DeparmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DescriptionMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn ứng dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FCT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritType';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InheritType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritVoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Ringi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ xem';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SearchMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SpendAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách phiếu DNTT/DNTTTU/DNTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn hình thành';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FormationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FormationID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2000.FormationName.CB', @FormID, @LanguageValue, @Language;