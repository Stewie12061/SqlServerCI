
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
SET @FormID = 'POSF2012';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'View deposit voucher details';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop/event';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale man';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.SaleManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Has made a coupon';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deposit amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.BookingAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.PackageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DiscountRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.InventoryAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%VAT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TaxAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.Notes' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher information';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabThongTinPhieuChungTu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.LastModifyDate' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery to guests';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.DeliveryToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customers come to receive goods';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberToTake' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Member name';
EXEC ERP9AddLanguage @ModuleID, 'POSF2012.MemberName' , @FormID, @LanguageValue, @Language;