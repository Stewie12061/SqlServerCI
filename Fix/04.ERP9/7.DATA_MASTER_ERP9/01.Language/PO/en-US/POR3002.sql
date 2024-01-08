DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POR3002'
---------------------------------------------------------------

SET @LanguageValue  = N'Report purchase order details'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency type'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group ID'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From the supplier'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To the supplier'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.ToObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.OrderStatus',  @FormID, @LanguageValue, @Language;