DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF00162'
---------------------------------------------------------------

SET @LanguageValue  = N'Inherit orders on APP'
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount of money';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Saleman name';
EXEC ERP9AddLanguage @ModuleID, 'POSF00162.SaleManName',  @FormID, @LanguageValue, @Language;




