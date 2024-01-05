DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1270'
---------------------------------------------------------------

SET @LanguageValue  = N'Category object type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.ObjectTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1270.Disabled',  @FormID, @LanguageValue, @Language;



