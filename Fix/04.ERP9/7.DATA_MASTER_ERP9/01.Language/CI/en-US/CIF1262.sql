                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1262 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:21:43 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1262' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1262' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'TabAT0109', N'CIF1262', N'Details', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.ToDate', N'CIF1262', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.Description', N'CIF1262', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.DivisionID', N'CIF1262', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.IsCommon', N'CIF1262', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.Disabled', N'CIF1262', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.PromoteID', N'CIF1262', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.LastModifyDate', N'CIF1262', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.CreateDate', N'CIF1262', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.LastModifyUserID', N'CIF1262', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.CreateUserID', N'CIF1262', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.PromoteName', N'CIF1262', N'Promotion name', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.ThongTinKhuyenMaiTheoDonHang', N'CIF1262', N'Promotional information by order', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.FromDate', N'CIF1262', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1262.Title', N'CIF1262', N'View promotion by bill', N'en-US', NULL

