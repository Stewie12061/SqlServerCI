-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2022- KPI
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
SET @FormID = 'KPIF2022';

SET @LanguageValue = N'Standard table (UpDown) View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targe Rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Red Limit (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warning Limit (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table of soft salary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.FromToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.ManagementStaff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales bonus milestone';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TargetSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales bonus';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.BonusSalesKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manager bonus';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.PercentKPIManager', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Violation of working hour table';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard table (UpDown) details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.ChiTietBangQuyChuanDanhGiaKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2022.DinhKem', @FormID, @LanguageValue, @Language;