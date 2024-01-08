-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2032- HRM
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
SET @FormID = 'HRMF2032';

SET @LanguageValue = N'Interview schedule view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.AssignedToUserName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit period name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabThongTinLichPhongVan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule details';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabChiTietLichPhongVan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview Confirm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.ConfirmID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.StatusID' , @FormID, @LanguageValue, @Language;