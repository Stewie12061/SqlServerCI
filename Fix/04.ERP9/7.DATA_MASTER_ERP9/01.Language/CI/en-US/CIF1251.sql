                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1251 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:20:11 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1251' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1251' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1251.Title', N'CIF1251', N'Update price list table sell', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.ToDate', N'CIF1251', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.DivisionID', N'CIF1251', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.Disabled', N'CIF1251', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.InventoryTypeID', N'CIF1251', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.CurrencyID', N'CIF1251', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.ID', N'CIF1251', N'Price list table code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.InventoryTypeID.CB', N'CIF1251', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.AnaID.CB', N'CIF1251', N'Analys code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.OID', N'CIF1251', N'Customer Group', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.LastModifyDate', N'CIF1251', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.CreateDate', N'CIF1251', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.LastModifyUserID', N'CIF1251', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.CreateUserID', N'CIF1251', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.Description', N'CIF1251', N'Price list table name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.InventoryTypeName.CB', N'CIF1251', N'Inventory type name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.CurrencyID.CB', N'CIF1251', N'Currency name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.CurrencyName.CB', N'CIF1251', N'Currency name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.AnaName.CB', N'CIF1251', N'Analys name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.IsConvertedPrice', N'CIF1251', N'Calculate the price according to money rules', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1251.FromDate', N'CIF1251', N'From date', N'en-US', NULL

