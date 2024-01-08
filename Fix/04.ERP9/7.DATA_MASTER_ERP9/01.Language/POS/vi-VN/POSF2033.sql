DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2033'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hội vên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hội vên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SaleManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SaleManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberNameOKIA',  @FormID, @LanguageValue, @Language;


