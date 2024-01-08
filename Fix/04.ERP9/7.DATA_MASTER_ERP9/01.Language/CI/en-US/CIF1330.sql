DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1330'
---------------------------------------------------------------

SET @LanguageValue  = N'Automatic object ID'
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create automatic object ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsAutomatic',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classifyi 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify name 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify name 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify name 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Outpout order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Separator ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsSeparator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is last key';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsLastKey',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Length',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.LastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Example';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TypeID',  @FormID, @LanguageValue, @Language;


