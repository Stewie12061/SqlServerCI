-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2001- T
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
SET @FormID = 'TF2001';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget period';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department/School';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget day';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval date';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindName', @FormID, @LanguageValue, @Language;

