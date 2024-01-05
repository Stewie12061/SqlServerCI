DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1241'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật khuyến mãi theo mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ChooseInventoryList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ObjectTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1241.ObjectID',  @FormID, @LanguageValue, @Language;