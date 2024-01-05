-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2020- KPI
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
SET @FormID = 'KPIF2020';

SET @LanguageValue = N'List of standard table (UpDown)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Red Limit(%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Limit (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table of soft salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.FromToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.ManagementStaff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TargetSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.BonusSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.PercentKPIManager', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Violation of working hour table';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableViolatedID', @FormID, @LanguageValue, @Language;

