                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0031 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:22:38 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0031' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0031' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0031.DiscountRate', N'POSF0031', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.VATPercent', N'POSF0031', N'% VAT', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.CurrentTable', N'POSF0031', N'Table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.UnitPrice', N'POSF0031', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.UnitName', N'POSF0031', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.CurrentZone', N'POSF0031', N'Area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.InventoryID', N'POSF0031', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.Quantity', N'POSF0031', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.Title', N'POSF0031', N'Split / Tail table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.InventoryName', N'POSF0031', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.InventoryAmount', N'POSF0031', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.DiscountAmount', N'POSF0031', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0031.TaxAmount', N'POSF0031', N'VAT money', N'en-US', NULL

