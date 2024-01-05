                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0056 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:32:40 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0056' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0056' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0056.Detail', N'POSF0056', N'Detail', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.LastModifyDate', N'POSF0056', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.Description', N'POSF0056', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.UnitPrice', N'POSF0056', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.DivisionID', N'POSF0056', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.UnitName', N'POSF0056', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.WarehouseID', N'POSF0056', N'Warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.VoucherTypeID', N'POSF0056', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.ShopID', N'POSF0056', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.InventoryID', N'POSF0056', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.EmployeeID', N'POSF0056', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.TranYear', N'POSF0056', N'Year', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.VoucherDate', N'POSF0056', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.CreateDate', N'POSF0056', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.LastModifyUserID', N'POSF0056', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.CreateUserID', N'POSF0056', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.VoucherNo', N'POSF0056', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.Quantity', N'POSF0056', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.InventoryName', N'POSF0056', N'Inventory nae', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.EmployeeName', N'POSF0056', N'Creater name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.VoucherInfo', N'POSF0056', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.UserInfo', N'POSF0056', N'User info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.Title', N'POSF0056', N'View balance details', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0056.StatusInventory', N'POSF0056', N'Status inventory', N'en-US', NULL


