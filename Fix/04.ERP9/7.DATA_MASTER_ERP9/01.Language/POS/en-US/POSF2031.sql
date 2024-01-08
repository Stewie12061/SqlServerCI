DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2031'
---------------------------------------------------------------

SET @LanguageValue  = N'Update request for invoice issuance'
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inheritance of the coupon';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.BtnInheritDeposit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT percent';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tax amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery contact';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryContact',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery receiver';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryReceiver',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery mobile';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2031.DeliveryAddress',  @FormID, @LanguageValue, @Language;


