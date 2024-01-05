DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3003'
---------------------------------------------------------------

SET @LanguageValue  = N'Report on supplier historical quotations'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.FromInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.ToInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.DivisionID',  @FormID, @LanguageValue, @Language;

