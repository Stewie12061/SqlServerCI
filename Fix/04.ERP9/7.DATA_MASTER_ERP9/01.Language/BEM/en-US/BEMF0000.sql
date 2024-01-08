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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF0000';

SET @LanguageValue = N'Last modify userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.ProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.SubsectionAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General settings';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Translate document voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TranslateDocVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travel expenses voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TravelExpensesVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BS Trip proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BS trip report voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripReportVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BS trip time voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripTimeVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaName.CB', @FormID, @LanguageValue, @Language;
