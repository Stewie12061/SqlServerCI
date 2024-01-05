-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2052- HRM
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
SET @FormID = 'HRMF2052';

SET @LanguageValue = N'Job offer decision view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RecDecisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision No';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of decision';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruit period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decision date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruiting decision';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabThongTinQuyetDinhTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruit deatails';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabThongTinChiTiet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Candidate name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CandidateName',  @FormID, @LanguageValue, @Language;

