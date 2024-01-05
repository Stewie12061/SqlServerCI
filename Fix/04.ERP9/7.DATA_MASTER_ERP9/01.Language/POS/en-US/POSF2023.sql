DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2023'
---------------------------------------------------------------

SET @LanguageValue  = N'Inheritance receipts'
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sum amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2023.SumAmount',  @FormID, @LanguageValue, @Language;


