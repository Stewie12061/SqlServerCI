
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF2011';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Update deposit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID / Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberNameOKIA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale man ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.SaleManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Has made a coupon';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The deposit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.BookingAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DiscountRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.TaxAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PackageName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName.CB' , @FormID, @LanguageValue, @Language;
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.APKMaster.POS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery to guests';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.DeliveryToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customers come to receive goods';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.MemberToTake' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment 01';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName01.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment 02';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.PaymentName02.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Total:';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.SubTotal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no {0} is existed. System updated new voucher no {1}';
EXEC ERP9AddLanguage @ModuleID, 'POSF2011.VoucherNoUpdated' , @FormID, @LanguageValue, @Language;