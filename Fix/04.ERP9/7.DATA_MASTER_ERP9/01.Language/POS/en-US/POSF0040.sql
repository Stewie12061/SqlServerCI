                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0040 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:27:00 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0040' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0040' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0040.DiscountPercent', N'POSF0040', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.DiscountRate', N'POSF0040', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.VATPercent', N'POSF0040', N'% VAT', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TableLabel', N'POSF0040', N'Table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TotalDiscountAmount', N'POSF0040', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.ChooseTable', N'POSF0040', N'Select table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.ChooseDish', N'POSF0040', N'Order', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Gifts', N'POSF0040', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Promotion', N'POSF0040', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.AccruedScore', N'POSF0040', N'Accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.LastAccruedScore', N'POSF0040', N'Last accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.AmountOfPoint', N'POSF0040', N'Amount of point', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PayScore', N'POSF0040', N'Pay score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.ChangeInventory', N'POSF0040', N'Exchange', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentObjectID', N'POSF0040', N'Object', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentObjectID01', N'POSF0040', N'Object', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentObjectID02', N'POSF0040', N'Object 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.UnitPrice', N'POSF0040', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.UnitID', N'POSF0040', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.MergeSplitTable', N'POSF0040', N'Folding / separating the table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.MergeSplitBill', N'POSF0040', N'Folding / separating the bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Title', N'POSF0040', N'RETAIL SYSTEMS', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Imei01', N'POSF0040', N'Imei 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Imei02', N'POSF0040', N'Imei 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PrintProcessedDish', N'POSF0040', N'Print processing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PrintBill', N'POSF0040', N'Print invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.FinishShift', N'POSF0040', N'Finish shift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Cash', N'POSF0040', N'Cash', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.AreaLabel', N'POSF0040', N'Area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Delete', N'POSF0040', N'Refresh', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.CurrencyID', N'POSF0040', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Save', N'POSF0040', N'Save', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Accept', N'POSF0040', N'Save bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.InventoryID', N'POSF0040', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.CboInventoryID', N'POSF0040', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Extension', N'POSF0040', N'Extension', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.VoucherDate', N'POSF0040', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.SearchMemberID', N'POSF0040', N'Scan card code / Enter member code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.SearchInventoryID', N'POSF0040', N'Barcode scan / Enter commodity code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.ActualQuantity', N'POSF0040', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.VoucherNo', N'POSF0040', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.ReVoucherNo', N'POSF0040', N'Return voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.InventoryName', N'POSF0040', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.CboInventoryName', N'POSF0040', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.MemberName', N'POSF0040', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Amount', N'POSF0040', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.InventoryAmount', N'POSF0040', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.APKPaymentID', N'POSF0040', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentObjectAmount01', N'POSF0040', N'Payment 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentObjectAmount02', N'POSF0040', N'Payment 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PromotionByDiscountPercent', N'POSF0040', N'By percent', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PromotionBDiscountAmount', N'POSF0040', N'By amount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.VoucherTitle', N'POSF0040', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.PaymentTitle', N'POSF0040', N'Payment info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.DiscountAmount', N'POSF0040', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TotalRedureRate', N'POSF0040', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TotalAmount', N'POSF0040', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Change', N'POSF0040', N'Excess money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TaxAmount', N'POSF0040', N'Tax money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TotalTaxAmount', N'POSF0040', N'Tax money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.AccountNumber01', N'POSF0040', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.AccountNumber02', N'POSF0040', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.TotalInventoryAmount', N'POSF0040', N'Total money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.Return', N'POSF0040', N'Return', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0040.CancelledDish', N'POSF0040', N'View cancelled dish', N'en-US', NULL

