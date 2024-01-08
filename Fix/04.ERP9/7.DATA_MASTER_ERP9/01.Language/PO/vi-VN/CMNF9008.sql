DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'CMNF9008'
---------------------------------------------------------------
SET @LanguageValue  = N'Chọn mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9008.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9008.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9008.Notes',  @FormID, @LanguageValue, @Language;
