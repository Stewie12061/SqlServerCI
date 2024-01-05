DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1350'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục bảng giá mua'
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đỗi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.FirmID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.FirmName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.OID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.OName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.Disabled.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.DisabledName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1350.FirmID',  @FormID, @LanguageValue, @Language;



