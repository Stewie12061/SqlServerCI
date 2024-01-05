DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'S';
SET @FormID = 'SF2123'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn email template'
EXEC ERP9AddLanguage @ModuleID, 'SF2123.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã template';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.TemplateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên template';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.TemplateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.EmailTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm email';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.EmailGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SF2123.IsCommonName',  @FormID, @LanguageValue, @Language;


