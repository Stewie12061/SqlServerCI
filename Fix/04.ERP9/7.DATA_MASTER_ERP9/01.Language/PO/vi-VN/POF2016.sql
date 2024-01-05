DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2016'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn'
EXEC ERP9AddLanguage @ModuleID, 'POF2016.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2016.SelectionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2016.SelectionName',  @FormID, @LanguageValue, @Language;

