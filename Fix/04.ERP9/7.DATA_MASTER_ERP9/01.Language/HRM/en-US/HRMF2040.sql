-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2040- HRM
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
SET @Language = 'en-US ' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2040';

SET @LanguageValue = N'Interview Result tracing';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Negotiated salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job acceptance date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trial period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nominee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nominee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewDate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewDate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewDate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewDate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewDate05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewAddress01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewAddress02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewAddress03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewAddress04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewAddress05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview contents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewTypeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewStatus01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewStatus02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewStatus03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewStatus04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.InterviewStatus05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Comment01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Comment02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Comment03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Comment04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Comment05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Description.CB',  @FormID, @LanguageValue, @Language;