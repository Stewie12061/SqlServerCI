DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2030'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục phiếu đề nghị xuất hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hóa đơn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.InvoiceVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu bán hàng POS';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.MemberName',  @FormID, @LanguageValue, @Language;