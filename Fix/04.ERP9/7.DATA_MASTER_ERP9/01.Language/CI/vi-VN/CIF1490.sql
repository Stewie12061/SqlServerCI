DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1490'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục mã phân tích đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.OrdersArea',  @FormID, @LanguageValue, @Language;