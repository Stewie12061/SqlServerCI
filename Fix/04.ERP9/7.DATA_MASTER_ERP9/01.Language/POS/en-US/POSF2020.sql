DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2020'
---------------------------------------------------------------

SET @LanguageValue  = N'Request for payment'
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.SuggestType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee recommended';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.MemberNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Confirm user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.ConfirmUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2020.EmployeeName.CB',  @FormID, @LanguageValue, @Language;
