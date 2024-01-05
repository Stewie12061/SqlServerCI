DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1291'
---------------------------------------------------------------

SET @LanguageValue  = N'Update unit'
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1291.Disabled',  @FormID, @LanguageValue, @Language;

