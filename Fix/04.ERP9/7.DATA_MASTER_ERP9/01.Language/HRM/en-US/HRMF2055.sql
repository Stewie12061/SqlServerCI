-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2055- HRM
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
SET @FormID = 'HRMF2055';

SET @LanguageValue = N'Android Package Kit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommended salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salary negotiable';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to start accepting jobs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Probationary period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.APKCandidateID', @FormID, @LanguageValue, @Language;

