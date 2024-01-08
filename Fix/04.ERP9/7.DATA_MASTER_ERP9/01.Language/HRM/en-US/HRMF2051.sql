-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2051- HRM
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
SET @FormID = 'HRMF2051';

SET @LanguageValue = N'Update job offer decision';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecDecisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruit period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';;
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Require salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Deal salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.WorkTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.GenderName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.MaterialStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decision date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inheritance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.btnInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.ApprovePerson',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID_Master',  @FormID, @LanguageValue, @Language;

