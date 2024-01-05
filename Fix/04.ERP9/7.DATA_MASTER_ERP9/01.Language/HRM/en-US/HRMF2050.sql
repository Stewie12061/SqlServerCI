-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2050- HRM
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
SET @FormID = 'HRMF2050';

SET @LanguageValue = N'Job offer decision';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecDecisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision No';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of decision';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decision ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.ToDate',  @FormID, @LanguageValue, @Language;




