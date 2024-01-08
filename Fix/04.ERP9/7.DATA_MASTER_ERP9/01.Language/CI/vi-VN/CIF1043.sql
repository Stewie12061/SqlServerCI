DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1043'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn email template'
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã template';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên template';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.TemplateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.EmailGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1043.IsCommonName',  @FormID, @LanguageValue, @Language;


