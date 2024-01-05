DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3006'
---------------------------------------------------------------

SET @LanguageValue  = N'By-supplier purchase order view reportp'
EXEC ERP9AddLanguage @ModuleID, 'POF3006.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object'
EXEC ERP9AddLanguage @ModuleID, 'POF3006.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory'
EXEC ERP9AddLanguage @ModuleID, 'POF3006.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3006.DivisionID',  @FormID, @LanguageValue, @Language;