DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2031'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật phiếu đề nghị xuất hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ công ty';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.BtnInheritDeposit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryContact',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Họ và tên người nhận';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryReceiver',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.MemberName',  @FormID, @LanguageValue, @Language;

