                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0028 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:20:50 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0028' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0028' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0028.Detail', N'POSF0028', N'Detail', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.LastModifyDate', N'POSF0028', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.EvoucherNo', N'POSF0028', N'Inheritance reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.DescriptionD', N'POSF0028', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.DescriptionM', N'POSF0028', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.SalePrice', N'POSF0028', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.UnitName', N'POSF0028', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.WareHouseID', N'POSF0028', N'Export warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.VoucherTypeID', N'POSF0028', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.InventoryID', N'POSF0028', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.EmployeeID', N'POSF0028', N'Create User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.VoucherDate', N'POSF0028', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.CreateDate', N'POSF0028', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.EmployeeName', N'POSF0028', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.LastModifyUserID', N'POSF0028', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.CreateUserID', N'POSF0028', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.RefVoucherNo', N'POSF0028', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.VoucherNo', N'POSF0028', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.ShipQuantity', N'POSF0028', N'Ship quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.InventoryName', N'POSF0028', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.Title', N'POSF0028', N'Delivery slip info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.VoucherInfo', N'POSF0028', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.UserInfo', N'POSF0028', N'User info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.WarrantyCard', N'POSF0028', N'Warranty card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0028.SerialNo', N'POSF0028', N'Serial no', N'en-US', NULL
