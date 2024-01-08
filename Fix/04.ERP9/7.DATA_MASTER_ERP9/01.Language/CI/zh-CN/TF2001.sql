-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2001- CI
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
SET @FormID = 'TF2001';

SET @LanguageValue = N'預算之更新';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算類型';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算時期';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門/學校';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'设立預算日期';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批准日期';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收入/支出預算';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收入/支出預算';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindName', @FormID, @LanguageValue, @Language;

