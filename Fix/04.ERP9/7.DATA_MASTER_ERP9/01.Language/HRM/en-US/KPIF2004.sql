-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2004- KPI
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
SET @FormID = 'KPIF2004';

SET @LanguageValue = N'Update KPI performance results';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total perform point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total perform percent (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.UnitKpiName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsGroupPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula describe';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Benchmark';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.Benchmark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform total';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform point total';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformPointTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform percent (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.PerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationSetName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EvaluationPhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2004.EmployeeName.CB', @FormID, @LanguageValue, @Language;
