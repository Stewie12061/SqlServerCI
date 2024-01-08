DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF90011'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật nội dung'
EXEC ERP9AddLanguage @ModuleID, 'CIF90011.Title',  @FormID, @LanguageValue, @Language;
