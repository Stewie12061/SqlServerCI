DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1183'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết bộ định mức kít'
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.Quantity',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1183.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

