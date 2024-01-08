DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1501'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mã phân tích đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mã phân tích (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1501.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;