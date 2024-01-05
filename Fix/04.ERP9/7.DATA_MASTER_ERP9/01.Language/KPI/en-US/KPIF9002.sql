DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF9002'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose Targets'
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Target department / company';
EXEC ERP9AddLanguage @ModuleID, 'KPIF9002.MainTargetID',  @FormID, @LanguageValue, @Language;


