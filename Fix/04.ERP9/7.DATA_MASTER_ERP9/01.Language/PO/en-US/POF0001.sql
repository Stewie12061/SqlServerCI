DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF0001'
---------------------------------------------------------------

SET @LanguageValue  = N'Set up purchase orders'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Currency'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sort purchase order'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Followers'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment methods'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Item type'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Storehouse'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bank address'	
EXEC ERP9AddLanguage @ModuleID, 'POF0001.DeReAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Electrolyte'	
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type of purchase order document'	
EXEC ERP9AddLanguage @ModuleID, 'POF0001.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Classify ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;