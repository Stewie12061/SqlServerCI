                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1260 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:21:08 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1260' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1260' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'CIF1260.Title', N'CIF1260', N'Discount category by bill', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.ToDate', N'CIF1260', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.Description', N'CIF1260', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.DivisionID', N'CIF1260', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.IsCommon', N'CIF1260', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.Disabled', N'CIF1260', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.PromoteID', N'CIF1260', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.LastModifyDate', N'CIF1260', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.CreateDate', N'CIF1260', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.LastModifyUserID', N'CIF1260', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.CreateUserID', N'CIF1260', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.PromoteName', N'CIF1260', N'Promotion name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1260.FromDate', N'CIF1260', N'From date', N'en-US', NULL

