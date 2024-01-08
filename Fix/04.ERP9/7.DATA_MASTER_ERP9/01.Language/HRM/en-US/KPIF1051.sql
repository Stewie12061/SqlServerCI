-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1051- KPI
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
SET @FormID = 'KPIF1051';

SET @LanguageValue = N'Targets Update';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formulas';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FrequencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.GoalLimit',  @FormID, @LanguageValue, @Language;