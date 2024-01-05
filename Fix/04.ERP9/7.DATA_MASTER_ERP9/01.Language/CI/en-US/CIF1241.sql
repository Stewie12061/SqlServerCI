                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1241 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:18:47 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1241' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1241' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1241.Title', N'CIF1241', N'Update inventory sale off by ', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.ToDate', N'CIF1241', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.Description', N'CIF1241', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.DivisionID', N'CIF1241', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.IsCommon', N'CIF1241', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.Disabled', N'CIF1241', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.InventoryTypeID', N'CIF1241', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.AnaID.CB', N'CIF1241', N'Code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.PromoteID', N'CIF1241', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.InventoryTypeID.CB', N'CIF1241', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.OID', N'CIF1241', N'Analys code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.LastModifyDate', N'CIF1241', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.CreateDate', N'CIF1241', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.LastModifyUserID', N'CIF1241', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.CreateUserID', N'CIF1241', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.AnaName.CB', N'CIF1241', N'Name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.InventoryTypeName.CB', N'CIF1241', N'Inventory type name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1241.FromDate', N'CIF1241', N'From date', N'en-US', NULL

