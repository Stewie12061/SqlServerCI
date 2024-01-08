DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3004'
---------------------------------------------------------------

SET @LanguageValue  = N'Monthly report of purchase orders'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.FromInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.ToInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Project'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.DivisionID',  @FormID, @LanguageValue, @Language;