DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1480'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập mã phân tích mua và bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1480.IsUsed',  @FormID, @LanguageValue, @Language;