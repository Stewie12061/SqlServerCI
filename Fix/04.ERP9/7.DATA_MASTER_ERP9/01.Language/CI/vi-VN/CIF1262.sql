DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1262'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết khuyến mãi theo hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khuyến mãi theo hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ThongTinKhuyenMaiTheoHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết khuyến mãi theo hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ChiTietKhuyenMaiTheoHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.FromValues',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ToValues',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.TabCRMT10101',  @FormID, @LanguageValue, @Language;