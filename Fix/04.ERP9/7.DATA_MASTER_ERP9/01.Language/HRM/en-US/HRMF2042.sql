-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2042- HRM
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
SET @FormID = 'HRMF2042';

SET @LanguageValue = N'Interview result view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Negotiated salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trial period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Round 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Round 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Round 4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Round 5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound5',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';;
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabCRMT00003',  @FormID, @LanguageValue, @Language;