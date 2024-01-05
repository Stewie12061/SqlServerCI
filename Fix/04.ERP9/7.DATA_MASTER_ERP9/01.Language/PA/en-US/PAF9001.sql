DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PA';
SET @FormID = 'PAF9001'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose the ability dictionary'
EXEC ERP9AddLanguage @ModuleID, 'PAF9001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal dictionary code';
EXEC ERP9AddLanguage @ModuleID, 'PAF9001.AppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal dictionary name';
EXEC ERP9AddLanguage @ModuleID, 'PAF9001.AppraisalDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level critical';
EXEC ERP9AddLanguage @ModuleID, 'PAF9001.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Appraisal group name';
EXEC ERP9AddLanguage @ModuleID, 'PAF9001.AppraisalGroupName',  @FormID, @LanguageValue, @Language;


