                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0039 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:26:26 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0039' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0039' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0039.PercentDiscount', N'POSF0039', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.TableIDFilter', N'POSF0039', N'Table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.Title', N'POSF0039', N'Sales slip category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ToPeriod', N'POSF0039', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ToDate', N'POSF0039', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.Cost', N'POSF0039', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.DivisionID', N'POSF0039', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.AreaIDFilter', N'POSF0039', N'Area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.VoucherTypeID', N'POSF0039', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.CurrencyName', N'POSF0039', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ShopID', N'POSF0039', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.InventoryID', N'POSF0039', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.MemberID', N'POSF0039', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.VoucherDate', N'POSF0039', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ActualQuantity', N'POSF0039', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.VoucherNo', N'POSF0039', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.EVoucherNo', N'POSF0039', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.EVoucherNoFilter', N'POSF0039', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.IMEI1', N'POSF0039', N'IMEI1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.IMEI2', N'POSF0039', N'IMEI 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.InventoryName', N'POSF0039', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.MemberName', N'POSF0039', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.Total', N'POSF0039', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.PaymentName', N'POSF0039', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ChangeInventory', N'POSF0039', N'Change inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.ReturnInventory', N'POSF0039', N'Return inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.TotalDiscountAmount', N'POSF0039', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.MoneyDiscount', N'POSF0039', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.TotalRedureAmount', N'POSF0039', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.TotalAmount', N'POSF0039', N'Total money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.FromPeriod', N'POSF0039', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0039.FromDate', N'POSF0039', N'From date', N'en-US', NULL

