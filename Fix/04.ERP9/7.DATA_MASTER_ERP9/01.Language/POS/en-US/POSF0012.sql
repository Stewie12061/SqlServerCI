                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0012 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:08:38 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0012' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0012' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0012.Title', N'POSF0012', N'Catalog of goods at the shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.DivisionID', N'POSF0012', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.UnitID', N'POSF0012', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.UnitPrice', N'POSF0012', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.POSF00121Title', N'POSF0012', N'Promotion inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.Gifts', N'POSF0012', N'Promotion / Gift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.ShopID', N'POSF0012', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.InventoryID', N'POSF0012', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.Barcode', N'POSF0012', N'Barcode', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.InventoryName', N'POSF0012', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0012.InventoryFilter', N'POSF0012', N'Inventory ID filter', N'en-US', NULL

