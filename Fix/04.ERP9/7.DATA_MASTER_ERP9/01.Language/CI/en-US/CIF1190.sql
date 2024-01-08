DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1190'
---------------------------------------------------------------

SET @LanguageValue  = N'Categories type currencies'
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.ExchangeRateDecimal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Decimal name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.DecimalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1190.Method',  @FormID, @LanguageValue, @Language;


