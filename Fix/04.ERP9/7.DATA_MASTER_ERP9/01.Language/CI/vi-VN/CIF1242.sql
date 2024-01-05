DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1242'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết khuyến mãi theo mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'TabAT1328',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ThongTinKhuyenMaiTheoMatHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ChiTietKhuyenMai',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1242.TabCRMT10101',  @FormID, @LanguageValue, @Language;