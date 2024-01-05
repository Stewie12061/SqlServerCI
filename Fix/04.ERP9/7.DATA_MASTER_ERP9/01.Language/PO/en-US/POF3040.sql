DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3040'
---------------------------------------------------------------

SET @LanguageValue  = N'Supplier comparison report'
EXEC ERP9AddLanguage @ModuleID, 'POF3040.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3040.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier'
EXEC ERP9AddLanguage @ModuleID, 'POF3040.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3040.InventoryID',  @FormID, @LanguageValue, @Language;
