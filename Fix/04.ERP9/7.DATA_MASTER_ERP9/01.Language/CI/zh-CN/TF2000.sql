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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'TF2000';

SET @LanguageValue = N'預算清單';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算類型';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'设立預算時期';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門/學校';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'设立預算日期';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批准日期';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算類型';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收入/支出預算';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收入/支出預算';
EXEC ERP9AddLanguage @ModuleID, 'TF2000.BudgetKindName', @FormID, @LanguageValue, @Language;

