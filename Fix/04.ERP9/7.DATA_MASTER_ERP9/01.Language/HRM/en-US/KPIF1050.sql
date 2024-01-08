-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1050- KPI
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
SET @FormID = 'KPIF1050';

SET @LanguageValue = N'Targets list';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formulas';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.FrequencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.FrequencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentName.CB',  @FormID, @LanguageValue, @Language;
