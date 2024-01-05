DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1491'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mã phân tích đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;