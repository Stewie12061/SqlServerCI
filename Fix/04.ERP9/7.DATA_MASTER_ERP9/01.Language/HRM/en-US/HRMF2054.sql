-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2054- HRM
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
SET @FormID = 'HRMF2054';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision No';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RequireSalary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deal salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'StartDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrailTime';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrialFromDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrialToDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentName.CB',  @FormID, @LanguageValue, @Language;