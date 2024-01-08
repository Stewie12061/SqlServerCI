-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2031- HRM
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
SET @FormID = 'HRMF2031';

SET @LanguageValue = N'Update interview schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit period name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Attach' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview confirm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.ConfirmID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewAddress' , @FormID, @LanguageValue, @Language;
