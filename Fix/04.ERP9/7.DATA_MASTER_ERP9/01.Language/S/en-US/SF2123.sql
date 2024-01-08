DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'S';
SET @FormID = 'SF2123'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose email template'
EXEC ERP9AddLanguage @ModuleID, 'SF2123.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Template ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.TemplateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Template name';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.TemplateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.EmailTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email group name';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.EmailGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.IsCommonName',  @FormID, @LanguageValue, @Language;


