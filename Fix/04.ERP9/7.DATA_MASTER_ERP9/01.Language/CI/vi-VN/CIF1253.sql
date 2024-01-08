DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1253'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết bảng giá bán (Sell In)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.FirmID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.ProductTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.ModelName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.RetailPrice',  @FormID, @LanguageValue, @Language;