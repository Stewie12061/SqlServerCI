DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2020'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục phiếu đề nghị chi'
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.SuggestType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberIDOKIA',  @FormID, @LanguageValue, @Language;
