-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2001- KPI
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
SET @FormID = 'KPIF2001';

SET @LanguageValue = N'Update personal self-assessment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.StrengthPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weak point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.WeakPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee comments';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommendations after evaluation';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeProposes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmDutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmTitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance valuation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified  classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bench mark';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sum point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LanguageTD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LanguageXL',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentName.CB',  @FormID, @LanguageValue, @Language;