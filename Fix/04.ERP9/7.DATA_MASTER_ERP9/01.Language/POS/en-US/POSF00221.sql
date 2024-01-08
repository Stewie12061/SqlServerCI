DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF00221'
---------------------------------------------------------------

SET @LanguageValue  = N'Inherit import bills'
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory code';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Actual quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF00221.UnitPrice',  @FormID, @LanguageValue, @Language;

