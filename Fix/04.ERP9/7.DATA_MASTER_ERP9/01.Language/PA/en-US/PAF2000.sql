-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF2000- PA
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
SET @FormID = 'PAF2000';

SET @LanguageValue = N'List of performance evaluation';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance revaluation point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total unified point';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation kit';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;

