-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2041- HRM
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
SET @FormID = 'HRMF2041';

SET @LanguageValue = N'Update interview result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Negotiated salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trial period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Recrui	tPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateName.CB',  @FormID, @LanguageValue, @Language;
