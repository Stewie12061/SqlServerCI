-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2021- KPI
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
SET @FormID = 'KPIF2021';

SET @LanguageValue = N'Standard table (UpDown) Update';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Red Limit(%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Limit (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table of soft salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.FromToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Violation of working hour table';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TableID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TableName';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TableID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TableViolatedID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.ManagementStaff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales bonus milestone';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.TargetSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales bonus';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.BonusSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager bonus';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2021.PercentKPIManager', @FormID, @LanguageValue, @Language;