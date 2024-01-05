DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1020'
---------------------------------------------------------------

SET @LanguageValue  = N'Indicator dictionary'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets dictionary ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets dictionary name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formulas';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.FrequencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Categorize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information indicator dictionary';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.ThongTinTuDienChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Percentage.CB',  @FormID, @LanguageValue, @Language;


