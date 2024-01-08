                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0042 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:28:15 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0042' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0042' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0042.PercentDiscount', N'POSF0042', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.Description', N'POSF0042', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.UnitPrice', N'POSF0042', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.UnitID', N'POSF0042', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.InventoryID', N'POSF0042', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.Quantity', N'POSF0042', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.InventoryName', N'POSF0042', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.Total', N'POSF0042', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.Amount', N'POSF0042', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.MoneyDiscount', N'POSF0042', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0042.Title', N'POSF0042', N'View cancelled dish', N'en-US', NULL

