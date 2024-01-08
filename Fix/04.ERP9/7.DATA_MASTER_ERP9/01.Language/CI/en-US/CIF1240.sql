                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1240 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:18:23 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1240' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1240' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1240.Title', N'CIF1240', N'Discount inventory category', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.ToDate', N'CIF1240', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.Description', N'CIF1240', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.DivisionID', N'CIF1240', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.IsCommon', N'CIF1240', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.Disabled', N'CIF1240', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.InventoryTypeID', N'CIF1240', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.PromoteID', N'CIF1240', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.OID', N'CIF1240', N'Analys code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.LastModifyDate', N'CIF1240', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.CreateDate', N'CIF1240', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.LastModifyUserID', N'CIF1240', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.CreateUserID', N'CIF1240', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1240.FromDate', N'CIF1240', N'From date', N'en-US', NULL

