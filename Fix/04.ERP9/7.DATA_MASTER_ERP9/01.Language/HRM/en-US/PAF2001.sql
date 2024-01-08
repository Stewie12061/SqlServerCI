-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF2001- PA
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
SET @FormID = 'PAF2001';

SET @LanguageValue = N'Update performance evaluation';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance revaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total unified point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level critical'
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Benchmark';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Performance revaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evidence note';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvidenceNote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;

