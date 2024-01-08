DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF2000'
---------------------------------------------------------------

SET @LanguageValue  = N'Purchase order'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Received address';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ObjectName';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Transport';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT no';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract no';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase man';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase pice';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT percent';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

