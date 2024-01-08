-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1072- KPI
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
SET @FormID = 'KPIF1072';

SET @LanguageValue = N'Setting up KPI evaluation View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Division.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TitleID.CB',  @FormID, @LanguageValue, @Language;
	
SET @LanguageValue  = N'Title name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Percentage.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal Limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Typing';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TypingID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Setting up KPI evaluation of each position details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ChiTietThietLapBangDanhGiaTungViTri',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Setting up KPI evaluation of each position Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ThongTinThietLapBangDanhGiaTungViTri',  @FormID, @LanguageValue, @Language;