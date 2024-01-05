DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1520'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập chương trình khuyến mãi theo theo điều kiện'
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chương trình';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.PromoteID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không dùng ví chiết khấu tích lũy';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.IsDiscountWallet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.Description',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tất cả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.All',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chương trình';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.PromoteName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.OID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khuyến mãi theo điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIR12401.Report',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trang thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.StatusSS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1520.ObjectName',  @FormID, @LanguageValue, @Language;

