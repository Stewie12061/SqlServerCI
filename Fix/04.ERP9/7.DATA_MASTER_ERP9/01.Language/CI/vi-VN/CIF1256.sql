DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1256'
---------------------------------------------------------------

SET @LanguageValue  = N'Lọc chi tiết bảng giá'
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ProductTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ProductTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ProductTypeNameCIFT12562',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ModelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ModelName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá (USD)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.UnitPriceCIFT12562',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffPercent01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffPercent02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffPercent03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffPercent04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffPercent05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SaleOffAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.NotesCIFT12562',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá (VND)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ConvertedUnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thuế NK (%)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.TaxRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế NK';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí nhập hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.FeeAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá vốn (NVD)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.CostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Margin (%)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.MarginRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price after margin';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.PriceAfterMargin',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền công';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.LaborAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá vốn (LK + TC)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.TotalCostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá dịch vụ sữa chữa (LK + TC)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ServiceAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ProfitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.ProfitRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% điều chỉnh giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.AdjustRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.AdjustAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá dịch vụ sữa chữa sau điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.AdjustServiceAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lợi nhuận sau điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.TotalProfitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% lợi nhuận sau điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.AdjustProfitRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán (VND)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1256.CurrentPrice',  @FormID, @LanguageValue, @Language;




