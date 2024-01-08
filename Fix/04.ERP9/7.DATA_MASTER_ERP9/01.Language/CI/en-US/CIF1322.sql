DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1322'
---------------------------------------------------------------

SET @LanguageValue  = N'View detail voucher type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Entry description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Output order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Separated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Set up the code to increase automatically';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Default info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Code to increase auto info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Debit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsDefault';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Credit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Invoice description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputLength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Description',  @FormID, @LanguageValue, @Language;