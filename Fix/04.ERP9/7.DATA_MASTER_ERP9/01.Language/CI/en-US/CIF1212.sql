DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1212'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail country'
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CountryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information country';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.ThongTinQuocGia',  @FormID, @LanguageValue, @Language;


