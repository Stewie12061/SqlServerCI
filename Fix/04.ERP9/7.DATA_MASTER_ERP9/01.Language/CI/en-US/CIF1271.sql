DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1271'
---------------------------------------------------------------

SET @LanguageValue  = N'Update object type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.ObjectTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1271.Disabled',  @FormID, @LanguageValue, @Language;



