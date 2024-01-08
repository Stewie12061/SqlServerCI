-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF1021- PA
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
SET @FormID = 'PAF1021';

SET @LanguageValue = N'Setting up competency assessment Update';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Division.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationKitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationKitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group goal';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalGroupGoal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level critical';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note the standard level of competence';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardName',  @FormID, @LanguageValue, @Language;