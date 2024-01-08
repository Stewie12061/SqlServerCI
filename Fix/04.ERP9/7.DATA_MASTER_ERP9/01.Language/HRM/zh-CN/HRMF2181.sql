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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2181';

SET @LanguageValue = N'更新勞動合同';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽署日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同類型';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要做的工作';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Works', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'基礎工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.BaseSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發放工具';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.IssueTool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'車輛';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Conveyance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工資支付形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休息模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.RestRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼包括';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Allowance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付每月工資的日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'獎金';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Bonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'加薪模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配備職業事故防護裝備包括';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SafetyEquiment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社會保險和健康保險';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓模式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TrainingRegulation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他協議';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.OtherAgreement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他違法行為的賠償';
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

SET @LanguageValue = N'合同狀態';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼6';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼7';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼8';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼9';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'津貼10';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'試用期工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ProbationSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同附錄';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SubContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽名人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽名人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignPersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同狀態';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeName2', @FormID, @LanguageValue, @Language;

