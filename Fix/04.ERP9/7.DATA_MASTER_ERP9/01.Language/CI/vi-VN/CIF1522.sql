DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1522'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết thiết lập khuyến mãi theo điều kiện'
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'TabAT1328',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin thiết lập khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ThongTinKhuyenMaiTheoDieuKien',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết điều kiện khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ChiTietDieuKienKhuyenMai',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ConditionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ConditionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chương  trình';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công cụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ToolID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.PayMentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng customize';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ObjectCustomID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã neo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.AnChorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không dùng ví chiết khấu khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.IsDiscountWallet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công cụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolID',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentID',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Đối tượng customize';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ObjectCustomID',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Mã neo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AnchorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trang thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.StatusSS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế thừa CTKM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.DinhKem',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1522.ObjectName',  @FormID, @LanguageValue, @Language;