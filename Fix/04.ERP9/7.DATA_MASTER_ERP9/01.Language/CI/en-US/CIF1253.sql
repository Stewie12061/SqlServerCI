                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1253 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:20:45 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1253' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1253' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1253.DiscountPercent', N'CIF1253', N'% Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffPercent01', N'CIF1253', N'% Discount 1', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffPercent02', N'CIF1253', N'% Discount 2', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffPercent03', N'CIF1253', N'% Discount 3', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffPercent04', N'CIF1253', N'% Discount 4', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffPercent05', N'CIF1253', N'% Discount 5', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.Title', N'CIF1253', N'Update details price list table sell', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.DiscountAmount', N'CIF1253', N'Discount', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.UnitPrice', N'CIF1253', N'Unit price', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.UnitID', N'CIF1253', N'Đơn vị tính', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.Notes', N'CIF1253', N'Description 1', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.Notes01', N'CIF1253', N'Description 2', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.Notes02', N'CIF1253', N'Description 3', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.MaxPrice', N'CIF1253', N'Max price', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.MinPrice', N'CIF1253', N'Min price', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffAmount01', N'CIF1253', N'Discount 1', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffAmount02', N'CIF1253', N'Discount 2', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffAmount03', N'CIF1253', N'Discount 3', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffAmount04', N'CIF1253', N'Discount 4', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.SaleOffAmount05', N'CIF1253', N'Discount 5', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.ID', N'CIF1253', N'Price list table code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.InventoryID', N'CIF1253', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.InventoryID.Auto', N'CIF1253', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.InventoryName', N'CIF1253', N'Inventory name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1253.InventoryName.Auto', N'CIF1253', N'Inventory name', N'en-US', NULL

