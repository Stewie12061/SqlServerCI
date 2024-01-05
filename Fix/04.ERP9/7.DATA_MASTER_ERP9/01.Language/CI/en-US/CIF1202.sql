DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1202'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail VAT Group'
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information VAT group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.ThongTinNhomThue',  @FormID, @LanguageValue, @Language;


