DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1352'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem thông tin bảng giá mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffPercent01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffPercent02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffPercent03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffPercent04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffPercent05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.SaleOffAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InheritName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.IsInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.ProductTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.ModelName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.ChitietBangGiaMua',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.FirmID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1352.LichSu',  @FormID, @LanguageValue, @Language;
