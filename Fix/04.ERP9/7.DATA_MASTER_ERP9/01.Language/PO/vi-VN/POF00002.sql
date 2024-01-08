DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF00002'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn loại CT đơn hàng gia công'
EXEC ERP9AddLanguage @ModuleID, 'POF00002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'POF00002.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'POF00002.ClassifyName',  @FormID, @LanguageValue, @Language;