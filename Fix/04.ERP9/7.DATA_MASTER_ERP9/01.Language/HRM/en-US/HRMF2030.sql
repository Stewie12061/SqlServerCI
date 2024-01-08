-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2030- HRM
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
SET @FormID = 'HRMF2030';

SET @LanguageValue = N'Interview Schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview round';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit period name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.RecruitPeriodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentName.CB' , @FormID, @LanguageValue, @Language;
