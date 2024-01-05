DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3005'
---------------------------------------------------------------

SET @LanguageValue  = N'By-project purchase order view report'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Project'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.DivisionID',  @FormID, @LanguageValue, @Language;