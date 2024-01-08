                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1250 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:19:57 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1250' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1250' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1250.Print1', N'CIF1250', N'Price list table 1', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.Print2', N'CIF1250', N'Price list table 2', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.Title', N'CIF1250', N'Price list sell category', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.ToDate', N'CIF1250', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.DivisionID', N'CIF1250', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.Disabled', N'CIF1250', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.Print3', N'CIF1250', N'Price list table history', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.InventoryTypeID', N'CIF1250', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.CurrencyID', N'CIF1250', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.AnaID.CB', N'CIF1250', N'Code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.ID', N'CIF1250', N'Price list table code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.InventoryTypeID.CB', N'CIF1250', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.OID', N'CIF1250', N'Branch', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.LastModifyDate', N'CIF1250', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.CreateDate', N'CIF1250', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.LastModifyUserID', N'CIF1250', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.CreateUserID', N'CIF1250', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.AnaName.CB', N'CIF1250', N'Name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.Description', N'CIF1250', N'Price list table name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.InventoryTypeName.CB', N'CIF1250', N'Inventory type name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.CurrencyID.CB', N'CIF1250', N'Currency name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.CurrencyName.CB', N'CIF1250', N'Currency name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.IsConvertedPrice', N'CIF1250', N'Calculate the price according to money rules', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1250.FromDate', N'CIF1250', N'From date', N'en-US', NULL

