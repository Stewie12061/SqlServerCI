DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1470'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục bảng giá mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đỗi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Print1', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Print2', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.Print3', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.SalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.PurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1470.InventoryTypeName', @FormID, @LanguageValue, @Language;