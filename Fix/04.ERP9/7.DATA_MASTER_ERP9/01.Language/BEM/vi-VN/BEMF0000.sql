-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF0000 - BEM
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
SET @FormID = 'BEMF0000';

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripReportVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripTimeVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DNTU/DNTT/DNTTTU';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.ProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.SubsectionAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập chung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch nội dung chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TranslateDocVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thanh toán phí đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TravelExpensesVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.ReportCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaName.CB', @FormID, @LanguageValue, @Language;
