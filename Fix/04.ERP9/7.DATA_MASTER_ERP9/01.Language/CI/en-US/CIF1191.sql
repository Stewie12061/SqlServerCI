DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1191'
---------------------------------------------------------------

SET @LanguageValue  = N'Update type currencies'
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.ExchangeRateDecimal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.DecimalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Method',  @FormID, @LanguageValue, @Language;


