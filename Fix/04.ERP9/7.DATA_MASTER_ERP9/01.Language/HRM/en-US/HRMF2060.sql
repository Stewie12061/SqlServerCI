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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2060';

SET @LanguageValue  = N'List of training budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarterly/Yearly Budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Precious';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarterly/Yearly Budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of money';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget accordingly';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2060.DepartmentName.CB',  @FormID, @LanguageValue, @Language;
