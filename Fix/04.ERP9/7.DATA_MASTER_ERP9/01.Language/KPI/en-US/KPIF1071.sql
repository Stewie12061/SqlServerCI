-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1071- KPI
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
SET @FormID = 'KPIF1071';

SET @LanguageValue = N'Setting up KPI evaluation Update';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Division.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TitleID.CB',  @FormID, @LanguageValue, @Language;
	
SET @LanguageValue  = N'Title name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Percentage.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal Limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Typing';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1071.TypingID',  @FormID, @LanguageValue, @Language;