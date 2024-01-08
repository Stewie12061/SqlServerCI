DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF0083'
---------------------------------------------------------------

SET @LanguageValue  = N'Inherit sales orders'
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.MemberIDSearch',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount of money';
EXEC ERP9AddLanguage @ModuleID, 'POSF0083.SumAmount',  @FormID, @LanguageValue, @Language;


