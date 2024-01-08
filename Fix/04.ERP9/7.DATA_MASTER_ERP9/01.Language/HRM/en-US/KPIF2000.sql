-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2000- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2000';

SET @LanguageValue = N'Personal self-assessment list';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.StrengthPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weak point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.WeakPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee comments';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommendations after evaluation';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeProposes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmDutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmTitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance valuation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified  classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title Id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentName.CB',  @FormID, @LanguageValue, @Language;



