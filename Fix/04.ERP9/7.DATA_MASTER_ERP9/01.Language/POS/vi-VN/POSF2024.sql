DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2024'
---------------------------------------------------------------

SET @LanguageValue  = N'Trang thái'
EXEC ERP9AddLanguage @ModuleID, 'POSF2024.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2024.Notes',  @FormID, @LanguageValue, @Language;


