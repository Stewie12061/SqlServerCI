-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2002- KPI
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
SET @FormID = 'KPIF2002';

SET @LanguageValue = N'Personal self-assessment view';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.StrengthPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weak point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.WeakPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee comments';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommendations after evaluation';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeProposes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmDutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmTitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comments of assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmComments', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance valuation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Performance re-evaluation classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationReevaluatedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unified  classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationUnifiedPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bench mark';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Perform point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reevaluated point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sum point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LanguageTD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LanguageXL',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal self-assessment information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ThongTinCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal self-assessment details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ChiTietCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.StatusID',  @FormID, @LanguageValue, @Language;