-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2053- HRM
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
SET @FormID = 'HRMF2053';

SET @LanguageValue = N'Candidate code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RequireSalary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Negotiated salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form of work';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.WorkTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.GenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BirthDay';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.BirthDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2053.MaterialStatus', @FormID, @LanguageValue, @Language;

