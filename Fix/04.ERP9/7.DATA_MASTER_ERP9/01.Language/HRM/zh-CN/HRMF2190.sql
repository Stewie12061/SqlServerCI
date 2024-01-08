-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2190- HRM
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
SET @FormID = 'HRMF2190';

SET @LanguageValue = N'保險檔案清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'单据ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.InsurFileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'班組代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團體';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職位代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社會保險書號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.SNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社會保險費繳納日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.SBeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康保險書號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'體檢單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'有效日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'看治病的醫院代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KCB醫院';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'基礎工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Basesalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社會保險工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.InsuranceSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工資01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工資02';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工資03';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計算社會保險';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計算健康保險';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計算工會會費';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsT', @FormID, @LanguageValue, @Language;

