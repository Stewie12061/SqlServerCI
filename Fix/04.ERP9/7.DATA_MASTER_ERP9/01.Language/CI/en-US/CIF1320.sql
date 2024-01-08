DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1320'
---------------------------------------------------------------

SET @LanguageValue  = N'List of voucher type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Entry description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DType 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SType 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SType 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Output order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Separated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Set up the code to increase automatically';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Debit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsDefault';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Credit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Invoice description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BDescription',  @FormID, @LanguageValue, @Language;



