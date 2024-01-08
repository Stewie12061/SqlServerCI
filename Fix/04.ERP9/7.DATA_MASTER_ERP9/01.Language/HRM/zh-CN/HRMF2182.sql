-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2182- HRM
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
SET @FormID = 'HRMF2182';

SET @LanguageValue = N'勞動合同明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽署日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同類型';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要做的工作';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Works', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'基礎工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.BaseSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發放工具';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.IssueTool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'車輛';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Conveyance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工資支付形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.PayForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休息模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.RestRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼包括';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Allowance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付每月工資的日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.PayDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'獎金';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Bonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'加薪模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SalaryRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'加薪模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SalaryRegulationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配備職業事故防護裝備包括';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SafetyEquiment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社會保險和健康保險';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TrainingRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他協議';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.OtherAgreement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他違法行為的賠償';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Compensation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.IsAppendix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.CContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.IsSLSendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.StatusRecieve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼6';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼7';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼8';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼9';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼10';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'試用期工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ProbationSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同附錄';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SubContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同類型';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SignPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽名人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SignPersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同狀態';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.StatusRecieveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.EmployeeName2', @FormID, @LanguageValue, @Language;

