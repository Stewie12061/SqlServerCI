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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2061';

SET @LanguageValue  = N'Update training budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarterly/Yearly Budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Precious';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarter';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarterly/Yearly Budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of money';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget accordingly';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.APK', @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2061.DepartmentName.CB',  @FormID, @LanguageValue, @Language;