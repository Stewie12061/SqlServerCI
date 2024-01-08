-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2191- HRM
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
SET @FormID = 'HRMF2191';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InsurFileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Groups';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Social insurance book number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.SNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Social insurance payment date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.SBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health insurance book number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Medical examination form';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Valid from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hospital code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KCB Hospital';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Basic salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Basesalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Social insurance salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InsuranceSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salary allowance 01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salary allowance 02';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salary allowance 03';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate social insurance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate health insurance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate KPCĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsT', @FormID, @LanguageValue, @Language;

