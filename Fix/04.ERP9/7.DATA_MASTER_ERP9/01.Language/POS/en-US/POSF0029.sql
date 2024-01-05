                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0029 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:21:43 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0029' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0029' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0029.Title', N'POSF0029', N'Update item details', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.DescriptionD', N'POSF0029', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.UnitID', N'POSF0029', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.SalePrice', N'POSF0029', N'Export price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.InventoryID', N'POSF0029', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.ShipQuantity', N'POSF0029', N'Ship quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.InventoryName', N'POSF0029', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.SerialNo', N'POSF0029', N'Serial no', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0029.WarrantyCard', N'POSF0029', N'Warranty card', N'en-US', NULL

