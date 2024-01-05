-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2000- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'TF2000';

SET @LanguageValue = N'Danh mục ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ lập ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban/Trường';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban/trường';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân sách Thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân sách Thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindName', @FormID, @LanguageValue, @Language;