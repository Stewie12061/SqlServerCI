DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2021'
---------------------------------------------------------------

SET @LanguageValue  = N'Update request for payment'
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment of deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType0',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment for goods';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Money exchange';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.SuggestType2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.IsConfirmName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InMemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.InMemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2021.MemberNameOKIA',  @FormID, @LanguageValue, @Language;


