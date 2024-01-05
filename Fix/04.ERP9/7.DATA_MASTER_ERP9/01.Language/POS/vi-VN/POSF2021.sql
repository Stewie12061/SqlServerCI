DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2021'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật phiếu đề nghị chi'
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiền trả cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType0',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiền trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiền đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.IsConfirmName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InMemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InMemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.MemberNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.MemberIDOKIA',  @FormID, @LanguageValue, @Language;



