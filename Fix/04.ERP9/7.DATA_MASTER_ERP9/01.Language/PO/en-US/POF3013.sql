DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3013'
---------------------------------------------------------------

SET @LanguageValue  = N'Receipt summary report'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Include the orders that have been booked prior to the above deadline'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.IsFilter1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.DivisionID',  @FormID, @LanguageValue, @Language;