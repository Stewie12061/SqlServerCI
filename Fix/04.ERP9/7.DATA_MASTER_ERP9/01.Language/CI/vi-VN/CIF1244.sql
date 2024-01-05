DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1244'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết hàng khuyến mãi cho mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.FromQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.ToQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng khuyễn mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromotePercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteInventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng khuyễn mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteInventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khuyến mãi theo combo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.IsCombo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khuyến mãi hàng tặng hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.DiscountInventory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khuyến mãi hàng tặng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.DiscountMoney',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromotionPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.Text',  @FormID, @LanguageValue, @Language;