DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1210'
---------------------------------------------------------------

SET @LanguageValue  = N'Category country'
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.CountryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1210.Disabled',  @FormID, @LanguageValue, @Language;



