DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF2002'
---------------------------------------------------------------

SET @LanguageValue  = N'Details purchase order'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Received address';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Transport';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT no';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract no';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase man';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase pice';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT percent';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT orginal amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT convert amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order information';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinDonHangMua' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order details';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabOT3002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabCRMT00003' , @FormID, @LanguageValue, @Language;

