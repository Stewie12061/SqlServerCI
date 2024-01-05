                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0065 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:34:38 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0065' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0065' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0065.Selected', N'POSF0065', N'Select', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.UnitPrice', N'POSF0065', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.DivisionID', N'POSF0065', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.InventoryID', N'POSF0065', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.OriginInventory', N'POSF0065', N'Origin inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.InventoryName', N'POSF0065', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0065.Title', N'POSF0065', N'Member filter', N'en-US', NULL

