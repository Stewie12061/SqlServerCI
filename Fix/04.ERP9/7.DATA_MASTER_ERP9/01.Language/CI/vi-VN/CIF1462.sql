DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1462'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết bảng giá bán (Sell Out)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin bảng giá bán (Sale out)'
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.Detail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.PriceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính giá theo tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.IsConvertedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập tỉ lệ hoa hồng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.IsSetBonus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.IsPlanPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá mua';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.IsPurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1462.InventoryTypeName',  @FormID, @LanguageValue, @Language;