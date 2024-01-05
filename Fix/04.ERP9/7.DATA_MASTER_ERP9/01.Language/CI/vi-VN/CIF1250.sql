DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1250'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục bảng giá bán (Sell In)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đỗi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.LastModifyUserID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Print1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Print2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Print3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.StatusSS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ApprovalNotes', @FormID, @LanguageValue, @Language;