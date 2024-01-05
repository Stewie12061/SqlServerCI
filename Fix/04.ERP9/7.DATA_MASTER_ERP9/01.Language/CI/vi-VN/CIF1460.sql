DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1460'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục bảng giá bán (Sale out)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.InventoryTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1460.PurchasePrice',  @FormID, @LanguageValue, @Language;