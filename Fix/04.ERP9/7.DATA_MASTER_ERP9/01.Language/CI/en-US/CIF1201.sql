DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1201'
---------------------------------------------------------------

SET @LanguageValue  = N'Update VAT Group'
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.Disabled',  @FormID, @LanguageValue, @Language;

