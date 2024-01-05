DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2030'
---------------------------------------------------------------

SET @LanguageValue  = N'Request for invoice issuance'
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Invoice';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bill of sale';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.InvoiceVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sum amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'POS sales slip';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2030.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;


