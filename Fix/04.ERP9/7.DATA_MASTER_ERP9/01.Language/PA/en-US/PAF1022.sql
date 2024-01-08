-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF1022- PA
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
SET @FormID = 'PAF1022';

SET @LanguageValue = N'Setting up competency assessment View';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationKitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationKitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group goal';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalGroupGoal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level critical';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note the standard level of competence';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Setting up competency assessment Information';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ThietLapBangDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DSetting up competency assessment details';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ChiTietThietLapBangDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ToDate',  @FormID, @LanguageValue, @Language;
