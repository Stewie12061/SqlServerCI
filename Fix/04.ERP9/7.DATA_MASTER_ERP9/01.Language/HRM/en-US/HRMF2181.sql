-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2181- HRM
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
SET @FormID = 'HRMF2181';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Groups';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sign day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working from day one';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work to do';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Works', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Basic salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.BaseSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work location';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allocation tool';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.IssueTool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vehicles';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Conveyance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pay forms';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resting mode';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.RestRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance include';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Allowance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paid monthly and daily';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Bonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salary increase regime';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipped with occupational accident protection including:';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SafetyEquiment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Social insurance and health insurance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training mode';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TrainingRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other agreements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.OtherAgreement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Compensation for other violations';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Compensation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.IsAppendix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.IsSLSendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 6';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 7';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 8';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 9';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowance 10';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Probationary salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ProbationSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract appendix';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SubContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract type name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Signer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Signer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignPersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeName2', @FormID, @LanguageValue, @Language;

