                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0057 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:33:04 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0057' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0057' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0057.Description', N'POSF0057', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.UnitName', N'POSF0057', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.WarehouseID', N'POSF0057', N'Warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.InventoryID', N'POSF0057', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.Title', N'POSF0057', N'Enter the details of the inventory balance', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.Quantity', N'POSF0057', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0057.InventoryName', N'POSF0057', N'Inventory name', N'en-US', NULL

