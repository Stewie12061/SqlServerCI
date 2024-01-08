DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1192'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail currency type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ExchangeRateDecimal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.DecimalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Method',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ThongTinNgoaiTe',  @FormID, @LanguageValue, @Language;

