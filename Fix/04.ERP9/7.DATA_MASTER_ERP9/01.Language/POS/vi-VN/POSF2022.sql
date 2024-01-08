DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2022'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết phiếu đề nghị chi'
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ConfirmDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.SuggestTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.IsConfirmName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InMemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin phiếu đề nghị chi';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ThongTinPhieuDeNghiChi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết phiếu đề nghị chi';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.ChiTietPhieuDeNghiChi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.InMemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2022.MemberNameOKIA',  @FormID, @LanguageValue, @Language;