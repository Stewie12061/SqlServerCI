-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2061- HRM
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
SET @FormID = 'HRMF2061';

SET @LanguageValue = N'更新培訓預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'季度/年度預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寶貴的';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'季度/年度預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'剩余金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算編制按照';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.APK', @FormID, @LanguageValue, @Language;

