                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSP0026 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:38:45 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSP0026' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSP0026' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSP0026.DisparityQuantity', N'POSP0026', N'Difference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.UnitID', N'POSP0026', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.UnitName', N'POSP0026', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.InventoryID', N'POSP0026', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana01ID', N'POSP0026', N'Analysis 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana10ID', N'POSP0026', N'Analysis 10', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana02ID', N'POSP0026', N'Analysis 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana03ID', N'POSP0026', N'Analysis 3', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana04ID', N'POSP0026', N'Analysis 4', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana05ID', N'POSP0026', N'Analysis 5', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana06ID', N'POSP0026', N'Analysis 6', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana07ID', N'POSP0026', N'Analysis 7', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana08ID', N'POSP0026', N'Analysis 8', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Ana09ID', N'POSP0026', N'Analysis 9', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.MarkQuantity', N'POSP0026', N'Stock quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.ActualQuantity', N'POSP0026', N'Actual quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.InventoryName', N'POSP0026', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSP0026.Title', N'POSP0026', N'Table info', N'en-US', NULL

