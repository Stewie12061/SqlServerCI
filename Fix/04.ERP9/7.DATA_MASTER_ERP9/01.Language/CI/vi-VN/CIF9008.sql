DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF9008'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại MH';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Specification', @FormID, @LanguageValue, @Language;
