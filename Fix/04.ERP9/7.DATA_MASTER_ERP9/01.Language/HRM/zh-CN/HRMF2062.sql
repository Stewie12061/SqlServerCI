-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2062- HRM
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
SET @FormID = 'HRMF2062';

SET @LanguageValue = N'查看培訓預算的明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算根據';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寶貴的';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司全體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'季度/年度預算';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'剩余金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預算編制按照';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.APK', @FormID, @LanguageValue, @Language;

