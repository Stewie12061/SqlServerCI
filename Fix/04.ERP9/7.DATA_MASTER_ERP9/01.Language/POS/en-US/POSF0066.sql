                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0066 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:35:01 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0066' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0066' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0066.DiscountPercent', N'POSF0066', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.DiscountRate', N'POSF0066', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.VATPercent', N'POSF0066', N'% VAT', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TableLabel', N'POSF0066', N'Table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ChangeAmount', N'POSF0066', N'Exchange difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TotalDiscountAmount', N'POSF0066', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ChooseTable', N'POSF0066', N'Select table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ChooseDish', N'POSF0066', N'Order', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Gifts', N'POSF0066', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Promotion', N'POSF0066', N'Promotion program', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.AccruedScore', N'POSF0066', N'Accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.LastAccruedScore', N'POSF0066', N'Last accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.AmountOfPoint', N'POSF0066', N'Amount of point', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PayScore', N'POSF0066', N'Pay score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ChangeInventory', N'POSF0066', N'Exchange', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentObjectID', N'POSF0066', N'Object', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentObjectID01', N'POSF0066', N'Object 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentObjectID02', N'POSF0066', N'Object 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.UnitPrice', N'POSF0066', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.UnitID', N'POSF0066', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.MergeSplitTable', N'POSF0066', N'Folding / separating the table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.MergeSplitBill', N'POSF0066', N'Folding / separating the bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Title', N'POSF0066', N'RETAIL SYSTEMS', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Imei01', N'POSF0066', N'Imei 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Imei02', N'POSF0066', N'Imei 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PrintProcessedDish', N'POSF0066', N'Print processing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PrintBill', N'POSF0066', N'Print invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.FinishShift', N'POSF0066', N'Finish shift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Cash', N'POSF0066', N'Cash', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.AreaLabel', N'POSF0066', N'Area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Delete', N'POSF0066', N'Refresh', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.CurrencyID', N'POSF0066', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Save', N'POSF0066', N'Save', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Accept', N'POSF0066', N'Save bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.InventoryID', N'POSF0066', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.CboInventoryID', N'POSF0066', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Extension', N'POSF0066', N'Extension', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.VoucherDate', N'POSF0066', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.SearchMemberID', N'POSF0066', N'Scan card code / Enter member code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.SearchInventoryID', N'POSF0066', N'Barcode scan / Enter commodity code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ActualQuantity', N'POSF0066', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.VoucherNo', N'POSF0066', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.CVoucherNo', N'POSF0066', N'Exchange NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.ReVoucherNo', N'POSF0066', N'Return voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.InventoryName', N'POSF0066', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.CboInventoryName', N'POSF0066', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.MemberName', N'POSF0066', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.InventoryAmount', N'POSF0066', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Amount', N'POSF0066', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.APKPaymentID', N'POSF0066', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentObjectAmount01', N'POSF0066', N'Payment 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentObjectAmount02', N'POSF0066', N'Payment 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.VoucherTitle', N'POSF0066', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.PaymentTitle', N'POSF0066', N'Payment info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.DiscountAmount', N'POSF0066', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TotalRedureRate', N'POSF0066', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TotalAmount', N'POSF0066', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Change', N'POSF0066', N'Excess money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TaxAmount', N'POSF0066', N'Tax money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TotalTaxAmount', N'POSF0066', N'Tax money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.AccountNumber01', N'POSF0066', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.AccountNumber02', N'POSF0066', N'Bank account', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.TotalInventoryAmount', N'POSF0066', N'Total money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.Return', N'POSF0066', N'Return', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0066.CancelledDish', N'POSF0066', N'View cancelled dish', N'en-US', NULL

