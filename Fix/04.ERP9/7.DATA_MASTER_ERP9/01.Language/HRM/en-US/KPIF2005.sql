-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2005- KPI
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
SET @FormID = 'KPIF2005';

SET @LanguageValue = N'KPI results view';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total perform point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total performance percent (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.UnitKpiName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsGroupPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula describe';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Benchmark';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.Benchmark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform total';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform point total';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformPointTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Perform percent (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.PerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information master';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabInformationMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabInformationDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2005.StatusID', @FormID, @LanguageValue, @Language;