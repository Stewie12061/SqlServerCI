DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1500'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục mã phân tích đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1500.OrdersArea',  @FormID, @LanguageValue, @Language;