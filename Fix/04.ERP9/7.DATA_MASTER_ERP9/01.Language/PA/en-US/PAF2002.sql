-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF2002- PA
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
SET @ModuleID = 'PA';
SET @FormID = 'PAF2002';

SET @LanguageValue = N'Performance evaluation view';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationKitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationKitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance revaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total unified point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';									
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance evaluation information';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance evaluation details';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ChiTietDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level critical'
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Benchmark';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance revaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evidence note';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvidenceNote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.StatusID',  @FormID, @LanguageValue, @Language;
