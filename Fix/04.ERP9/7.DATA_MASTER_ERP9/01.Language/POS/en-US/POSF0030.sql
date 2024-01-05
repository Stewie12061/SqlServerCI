                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0030 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:22:11 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0030' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0030' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0030.Title', N'POSF0030', N'Update goods at the store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.Selected', N'POSF0030', N'Select', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.CurrentShopLabel', N'POSF0030', N'Choose merchandise for the store', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.ShopIDFilter', N'POSF0030', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.InventoryFilter', N'POSF0030', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.InventoryID', N'POSF0030', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.Barcode', N'POSF0030', N'Barcode', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.ShopNameFilter', N'POSF0030', N'Shop name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.CurrentShop', N'POSF0030', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0030.InventoryName', N'POSF0030', N'Inventory name', N'en-US', NULL

