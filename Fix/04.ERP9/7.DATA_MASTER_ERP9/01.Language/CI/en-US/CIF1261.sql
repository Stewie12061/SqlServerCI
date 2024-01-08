                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1261 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:21:28 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1261' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1261' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1261.Title', N'CIF1261', N'Update discount by bill', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.ToDate', N'CIF1261', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.Description', N'CIF1261', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.DivisionID', N'CIF1261', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.IsCommon', N'CIF1261', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.Disabled', N'CIF1261', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.PromoteID', N'CIF1261', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.LastModifyDate', N'CIF1261', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.CreateDate', N'CIF1261', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.LastModifyUserID', N'CIF1261', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.CreateUserID', N'CIF1261', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.PromoteName', N'CIF1261', N'Promotion name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1261.FromDate', N'CIF1261', N'From date', N'en-US', NULL

