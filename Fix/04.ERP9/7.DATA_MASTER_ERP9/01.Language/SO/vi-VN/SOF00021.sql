DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF00021'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn loại CT đơn hàng gia công'
EXEC ERP9AddLanguage @ModuleID, 'SOF00021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF00021.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại'
EXEC ERP9AddLanguage @ModuleID, 'SOF00021.ClassifyName',  @FormID, @LanguageValue, @Language;