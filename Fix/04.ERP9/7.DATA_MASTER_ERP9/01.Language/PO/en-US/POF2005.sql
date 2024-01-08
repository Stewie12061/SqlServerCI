-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
--------------------------------------------------------
DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF2005'
---------------------------------------------------------------
SET @LanguageValue  = N'Inheritance purchase requirements'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher No'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order Date'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ship Date'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Priority Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InventoryID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order Quantity'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Original Amount'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Converted Amount'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'PriorityID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaName.CB',  @FormID, @LanguageValue, @Language;

