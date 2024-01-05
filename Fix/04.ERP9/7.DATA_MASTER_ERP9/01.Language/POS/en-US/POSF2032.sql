DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2032'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail request for invoice issuance'
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Invoice';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bill of sale';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InvoiceVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sum amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'POS sales slip';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Suggest user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inheritance of the coupon';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.BtnInheritDeposit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information request for invoice issuance';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ThongTinPhieuDeNghiXuatHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Detail request for invoice issuance';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ChiTietPhieuDeNghiXuatHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT percent';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tax amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TaxAmount',  @FormID, @LanguageValue, @Language;

