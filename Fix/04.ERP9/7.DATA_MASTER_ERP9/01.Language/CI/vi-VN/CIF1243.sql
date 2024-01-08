DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1243'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết hàng khuyến mãi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.FromQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.ToQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.PromoteTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1243.PromoteTypeName',  @FormID, @LanguageValue, @Language;


