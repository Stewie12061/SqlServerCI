-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2040- KPI
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
SET @FormID = 'KPIF2040';

SET @LanguageValue = N'List of incurred salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected effective salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Effective Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.ActualEffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.CheckListPeriodControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.FixedSalary1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sum salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.SumSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Income';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TotalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deductions';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.Deductions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2040.Period', @FormID, @LanguageValue, @Language;

