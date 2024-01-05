DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1251'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật bảng giá bán (Sell In)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đỗi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.FirmID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.FirmName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.FirmID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsPriceList1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá bán đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsPriceList2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tất cả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.All',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập tỉ lệ huê hồng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsSetBonus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.IsPurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.StatusSS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1251.ApprovalNotes',  @FormID, @LanguageValue, @Language;