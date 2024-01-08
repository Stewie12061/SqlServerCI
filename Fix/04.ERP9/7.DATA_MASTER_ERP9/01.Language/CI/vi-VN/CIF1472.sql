DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1472'

---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết bảng giá mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.PriceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InventoryTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.ThongTinBangGiaBan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'TabOT1302',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.WholesalePriceCIF1252',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffPercent01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffPercent02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffPercent03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffPercent04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffPercent05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.SaleOffAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InheritName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.TabOT1302',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.FirmID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.ProductTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.ModelName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.OName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InventoryTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.FirmName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập tỉ lệ huê hồng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.IsSetBonus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.Detail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán sỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.WholesalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1472.IsPurchasePrice',  @FormID, @LanguageValue, @Language;