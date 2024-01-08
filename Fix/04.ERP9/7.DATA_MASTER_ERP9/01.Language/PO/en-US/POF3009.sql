DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3009'
---------------------------------------------------------------

SET @LanguageValue  = N'Purchase order detailed report'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency type'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.DivisionID',  @FormID, @LanguageValue, @Language;
