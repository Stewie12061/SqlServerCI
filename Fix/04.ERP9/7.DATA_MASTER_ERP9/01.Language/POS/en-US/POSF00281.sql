                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00281 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:21:19 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00281' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00281' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00281.Title', N'POSF00281', N'Update the delivery note', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.Detail', N'POSF00281', N'Detail', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.LastModifyDate', N'POSF00281', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.EvoucherNo', N'POSF00281', N'Inheritance reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.ShopID', N'POSF00281', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.Description', N'POSF00281', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.DescriptionM', N'POSF00281', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.DivisionID', N'POSF00281', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.UnitName', N'POSF00281', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.WareHouseID', N'POSF00281', N'Export warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.VoucherTypeID', N'POSF00281', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.InventoryID', N'POSF00281', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.VoucherDate', N'POSF00281', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.CreateDate', N'POSF00281', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.EmployeeID', N'POSF00281', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.EmployeeName', N'POSF00281', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.LastModifyUserID', N'POSF00281', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.CreateUserID', N'POSF00281', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.VoucherNo', N'POSF00281', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.RefVoucherNo', N'POSF00281', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.ShipQuantity', N'POSF00281', N'Ship quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.InventoryName', N'POSF00281', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.VoucherInfo', N'POSF00281', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.UserInfo', N'POSF00281', N'User info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.SerialNo', N'POSF00281', N'Serial No', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00281.WarrantyCard', N'POSF00281', N'Warranty card', N'en-US', NULL
