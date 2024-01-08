-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2002- T
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
SET @FormID = 'TF2002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget day';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File attach';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval date';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue/Expenditure Budget';
EXEC ERP9AddLanguage @ModuleID, 'TF2002.BudgetKindName', @FormID, @LanguageValue, @Language;

