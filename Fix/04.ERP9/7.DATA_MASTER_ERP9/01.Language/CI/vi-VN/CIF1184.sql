DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1184'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật định mức cho bộ mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng thành phần';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng thành phần';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng thành phần';
EXEC ERP9AddLanguage @ModuleID, 'CI1184.ItemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1184.ItemID.Auto',  @FormID, @LanguageValue, @Language;



