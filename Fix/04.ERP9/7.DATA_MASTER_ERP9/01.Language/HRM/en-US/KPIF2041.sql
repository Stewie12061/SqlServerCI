-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2041- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2041';

SET @LanguageValue = N'Calculation of effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.ActualEffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CheckListPeriodControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee  ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.FixedSalary1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sum salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.SumSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Income';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.TotalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deductions';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.Deductions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue proJect: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.RevenueProJect', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus sale project: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.BonusSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is violated: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Organizational development';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.OrganizationalDevelopment', @FormID, @LanguageValue, @Language;