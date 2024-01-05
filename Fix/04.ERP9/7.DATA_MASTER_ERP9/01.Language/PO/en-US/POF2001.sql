DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF2001'
---------------------------------------------------------------

SET @LanguageValue  = N'Update purchase order'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Received address';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Transport';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT no';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract no';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase man';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase pice';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT percent';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due day';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DueDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Picking';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsPicking' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ware house';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertedAmount' , @FormID, @LanguageValue, @Language;