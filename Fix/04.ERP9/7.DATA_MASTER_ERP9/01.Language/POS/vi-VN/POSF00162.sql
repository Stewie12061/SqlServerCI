DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF00162'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa đơn hàng trên APP'
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.SaleManName',  @FormID, @LanguageValue, @Language;





