DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF9001'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose indicator dictionary'
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets dictionary ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets dictionary name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9001.TargetsGroupID',  @FormID, @LanguageValue, @Language;


