                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1252 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:20:28 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1252' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1252' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'TabOT1302', N'CIF1252', N'Details', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.ToDate', N'CIF1252', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.DivisionID', N'CIF1252', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.Disabled', N'CIF1252', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.InventoryTypeID', N'CIF1252', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.CurrencyID', N'CIF1252', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.ID', N'CIF1252', N'Price list table code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.OID', N'CIF1252', N'Branch', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.LastModifyDate', N'CIF1252', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.CreateDate', N'CIF1252', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.LastModifyUserID', N'CIF1252', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.CreateUserID', N'CIF1252', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.Description', N'CIF1252', N'Price list table name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.ThongTinBangGiaBan', N'CIF1252', N'Price list table info', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.IsConvertedPrice', N'CIF1252', N'Calculate the price according to money rules', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.FromDate', N'CIF1252', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.Title', N'CIF1252', N'View price list table sell', N'en-US', NULL

