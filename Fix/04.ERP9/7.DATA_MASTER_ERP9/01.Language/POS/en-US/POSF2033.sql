DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2033'
---------------------------------------------------------------

SET @LanguageValue  = N'Inheritance of the coupon'
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SaleManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Actual quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tax amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Member';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Saleman';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SaleManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer code';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2033.MemberNameOKIA',  @FormID, @LanguageValue, @Language;



