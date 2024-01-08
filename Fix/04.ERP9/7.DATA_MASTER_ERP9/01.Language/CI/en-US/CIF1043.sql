DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1043'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose email template'
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Template ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Template name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.IsCommonName',  @FormID, @LanguageValue, @Language;


