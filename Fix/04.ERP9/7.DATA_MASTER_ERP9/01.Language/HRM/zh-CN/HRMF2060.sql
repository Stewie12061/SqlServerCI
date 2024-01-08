-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2060- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2060';

SET @LanguageValue = N'培訓預算清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'季度/年度預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寶貴的';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'季度/年度預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'剩余金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算編制按照';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.APK', @FormID, @LanguageValue, @Language;

