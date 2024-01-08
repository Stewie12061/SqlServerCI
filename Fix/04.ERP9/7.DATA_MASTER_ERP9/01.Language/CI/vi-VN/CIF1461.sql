DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1461'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật bảng giá bán (Sell Out)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập tỉ lệ hoa hồng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsSetBonus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsPlanPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1461.IsPurchasePrice',  @FormID, @LanguageValue, @Language;