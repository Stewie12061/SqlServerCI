DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3008'
---------------------------------------------------------------

SET @LanguageValue  = N'Order status report (by PO)'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Include the orders that have been booked prior to the above deadline'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsFilter1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsGroup1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsGroup2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.GroupPOR3008',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.DivisionID',  @FormID, @LanguageValue, @Language;
