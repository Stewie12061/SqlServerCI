DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3011'
---------------------------------------------------------------

SET @LanguageValue  = N'Inventory price summary report'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.DivisionID',  @FormID, @LanguageValue, @Language;


