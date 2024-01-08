DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1521'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật khuyến mãi theo điều kiện'
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Description',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ConditionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ConditionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToolID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.DiscountUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PayMentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng xác định khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectCustomID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã neo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.AnChorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.OID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.OID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.O01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không dùng ví chiết khấu tích lũy';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsDiscountWallet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToolID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToolName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectCustomID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectCustomName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.AnchorID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.AnchorName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trang thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.StatusSS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phép tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.MathID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phép tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.MathName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phép tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.MathID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chính sách tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.SpendingTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế thừa CTKM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết thúc chương trình';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsEnd',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ObjectName',  @FormID, @LanguageValue, @Language;