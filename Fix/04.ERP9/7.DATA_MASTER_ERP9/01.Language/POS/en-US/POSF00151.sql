                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00151 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:11:20 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00151' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00151' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00151.Title', N'POSF00151', N'{0} import bills', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.ChooseVoucher', N'POSF00151', N'Choose coupon', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.EVoucherNo', N'POSF00151', N'Inheritance voucher', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.ToPeriod', N'POSF00151', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.ToDate', N'POSF00151', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.Description', N'POSF00151', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.UnitPrice', N'POSF00151', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.DivisionID', N'POSF00151', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.UnitID', N'POSF00151', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.Status', N'POSF00151', N'Complete / Not completed', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.InventoryID', N'POSF00151', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.EmployeeID', N'POSF00151', N'Receiver ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.VoucherDate', N'POSF00151', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.MarkQuantity', N'POSF00151', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.ActualQuantity', N'POSF00151', N'Received Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.VoucherNo', N'POSF00151', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.InventoryName', N'POSF00151', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.DelivererName', N'POSF00151', N'Diliverer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.EmployeeName', N'POSF00151', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.FromPeriod', N'POSF00151', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.FromDate', N'POSF00151', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00151.StatusInventory', N'POSF0023', N'Status', N'en-US', NULL

