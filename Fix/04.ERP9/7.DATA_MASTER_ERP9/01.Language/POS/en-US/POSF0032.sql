                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0032 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:23:10 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0032' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0032' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0032.DiscountRate', N'POSF0032', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.VATPercent', N'POSF0032', N'% VAT', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.Title2', N'POSF0032', N'Category of goods to print', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.UnitPrice', N'POSF0032', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.UnitName', N'POSF0032', N'Unit', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.InventoryID', N'POSF0032', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.Title1', N'POSF0032', N'The coupon needs to extract Bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.ActualQuantity', N'POSF0032', N'Quantity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.Title', N'POSF0032', N'Split / Tail bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.InventoryName', N'POSF0032', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.InventoryAmount', N'POSF0032', N'Money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.DiscountAmount', N'POSF0032', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.TaxAmount', N'POSF0032', N'VAT money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0032.CountTotalAmount', N'POSF0032', N'Total amount', N'en-US', NULL

