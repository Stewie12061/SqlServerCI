DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POR3001'
---------------------------------------------------------------

SET @LanguageValue  = N'Report purchase order details'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From supplier'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To supplier'
EXEC ERP9AddLanguage @ModuleID, 'POR3001.ToObjectName',  @FormID, @LanguageValue, @Language;