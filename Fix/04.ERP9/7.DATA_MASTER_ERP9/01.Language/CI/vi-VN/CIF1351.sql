DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1351'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật bảng giá mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffPercent01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffPercent02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffPercent03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffPercent04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffPercent05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.SaleOffAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bảng giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InheritName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.IsInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.ProductTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.ModelName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.FirmID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.FirmID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.FirmName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.OID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.OName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1351.InventoryName',  @FormID, @LanguageValue, @Language;

