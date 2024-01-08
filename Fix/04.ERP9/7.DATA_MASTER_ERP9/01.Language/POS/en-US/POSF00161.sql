                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00161 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:12:48 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10),
@LanguageValue NVARCHAR(4000),
@Language VARCHAR(10)

SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF00161';
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00161' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00161' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00161.DiscountPercent', N'POSF00161', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.DiscountRate', N'POSF00161', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Table', N'POSF00161', N'Table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChangeAmount', N'POSF00161', N'Exchange difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.TotalDiscountAmount', N'POSF00161', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChooseTable', N'POSF00161', N'Select table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChooseDish', N'POSF00161', N'Order', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Gifts', N'POSF00161', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Promotion', N'POSF00161', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Processed', N'POSF00161', N'Processed', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.BillPrinted', N'POSF00161', N'Bill printed', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.AccruedScore', N'POSF00161', N'Accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.LastAccruedScore', N'POSF00161', N'Last accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PayScore', N'POSF00161', N'Pay score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChangeInventory', N'POSF00161', N'Exchange', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentObjectID', N'POSF00161', N'Object', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentObjectID01', N'POSF00161', N'Object', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentObjectID02', N'POSF00161', N'Object 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.UnitPrice', N'POSF00161', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.UnitID', N'POSF00161', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.MergeSplitTable', N'POSF00161', N'Folding / separating the table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.MergeSplitBill', N'POSF00161', N'Folding / separating the bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Title', N'POSF00161', N'RETAIL SYSTEMS', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Imei01', N'POSF00161', N'Imei 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Imei02', N'POSF00161', N'Imei 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PrintProcessedDish', N'POSF00161', N'Print processing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PrintBill', N'POSF00161', N'Print invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.FinishShift', N'POSF00161', N'Finish shift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Cash', N'POSF00161', N'Cash', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Area', N'POSF00161', N'Area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Delete', N'POSF00161', N'Refresh', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.CurrencyID', N'POSF00161', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Save', N'POSF00161', N'Save', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.InventoryID', N'POSF00161', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.CboInventoryID', N'POSF00161', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.VoucherDate', N'POSF00161', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.SearchMemberID', N'POSF00161', N'Scan card code / Enter member code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.SearchInventoryID', N'POSF00161', N'Barcode scan / Enter commodity code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ActualQuantity', N'POSF00161', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.VoucherNo', N'POSF00161', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.CVoucherNo', N'POSF00161', N'Exchange NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ReVoucherNo', N'POSF00161', N'Return voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PVoucherNo', N'POSF00161', N'Return voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.InventoryName', N'POSF00161', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.CboInventoryName', N'POSF00161', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.MemberName', N'POSF00161', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.MemberID', N'POSF00161', N'Member code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Amount', N'POSF00161', N'Amount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.APKPaymentID', N'POSF00161', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Accept', N'POSF00161', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentObjectAmount01', N'POSF00161', N'Payment 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentObjectAmount02', N'POSF00161', N'Payment 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.VoucherTitle', N'POSF00161', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PaymentTitle', N'POSF00161', N'Payment info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.DiscountAmount', N'POSF00161', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.TotalRedureRate', N'POSF00161', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.TotalAmount', N'POSF00161', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Change', N'POSF00161', N'Excess money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.TotalTaxAmount', N'POSF00161', N'Tax money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.AccountNumber01', N'POSF00161', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.AccountNumber02', N'POSF00161', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.TotalInventoryAmount', N'POSF00161', N'Total money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.Return', N'POSF00161', N'Return', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.CancelledDish', N'POSF00161', N'View cancelled dish', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.IsWarehouseExported', N'POSF00161', N'Print shipping slip (Not selected: Export warehouse, Select: not warehouse)', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.PromoteChangeAmount', N'POSF00161', N'Promotion change amount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChoosePromoted', N'POSF00161', N'Select promotion', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.OptionPromoted', N'POSF00161', N'Propose', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.SalseOrderAPP', N'POSF00161', N'Inherit orders on APP', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.SaleManID', N'POSF00161', N'Sale man', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.ReQuantity', N'POSF00161', N'Quick view inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.IsInstallmentPrice', N'POSF00161', N'Installment price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00161.IsWarehouseGeneral' , N'POSF00161', N'Export at division', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.IsExportNow' , N'POSF00161', N'Export at shop', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.SerialNo' , N'POSF00161', N'Serial No', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.BookingAmount' , N'POSF00161', N'Deposit Amount', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.Booking' , N'POSF00161', N'Inherit Deposit Voucher', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.ReCharge' , N'POSF00161', N'Recharge', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.SearchMemberIDOKIA' , N'POSF00161', N'Scan card code / Enter customer code', N'en-US', NULL;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery contact';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.DeliveryContact' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery mobile';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.DeliveryMobile' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery receiver';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.DeliveryReceiver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Package';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.PackageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipment Details';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.DeliveryTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty card';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'POSF00161.Phone' , @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage N'POS', N'POSF00161.IsDisplay' , N'POSF00161', N'Showing product', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.Notes' , N'POSF00161', N'Notes', N'en-US', NULL;
EXEC ERP9AddLanguage N'POS', N'POSF00161.ChooseInvoicePromoted' , N'POSF00161', N'Reselect promotional items by invoice', N'en-US', NULL;