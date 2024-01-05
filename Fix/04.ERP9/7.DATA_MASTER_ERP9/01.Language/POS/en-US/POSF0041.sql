                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0041 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:27:44 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0041' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0041' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0041.Description', N'POSF0041', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.UnitName', N'POSF0041', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.MarkInventoryID', N'POSF0041', N'Food ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.InventoryID', N'POSF0041', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.Title', N'POSF0041', N'Export-Level Inventory Export-Processing Bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.MarkQuantity', N'POSF0041', N'Inventory quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.ShipQuantity', N'POSF0041', N'Ship quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.InventoryName', N'POSF0041', N'Receiver name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0041.ExportRate', N'POSF0041', N'Quota rate', N'en-US', NULL

