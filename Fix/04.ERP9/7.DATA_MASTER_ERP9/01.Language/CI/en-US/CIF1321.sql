DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1321'
---------------------------------------------------------------

SET @LanguageValue  = N'Update voucher info'
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Entry description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Output order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Separated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'S3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Set up the code to increase automatically';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Default info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Code to increase auto info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Debit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsDefault';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Credit account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Invoice description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Use invoice description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsBDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Use voucher description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsTDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reset index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lenght';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputLength',  @FormID, @LanguageValue, @Language;








