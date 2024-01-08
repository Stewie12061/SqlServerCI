-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2000- T
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
SET @Language = 'en-US' 
SET @ModuleID = 'T';
SET @FormID = 'TF2000';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budgeting period';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department/School';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget day';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval date';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindName', @FormID, @LanguageValue, @Language;

