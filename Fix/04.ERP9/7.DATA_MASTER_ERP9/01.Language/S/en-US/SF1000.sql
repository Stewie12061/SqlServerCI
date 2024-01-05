                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1000 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:23:02 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF1000' and Module = N'S'
-- SELECT * FROM A00001 WHERE FormID = 'SF1000' and Module = N'S' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'S', N'SF1000.Title', N'SF1000', N'User category', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.Address', N'SF1000', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.IsCommon', N'SF1000', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.Email', N'SF1000', N'Email', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.IsLock', N'SF1000', N'Locked', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.Disabled', N'SF1000', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.DivisionID', N'SF1000', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.EmployeeID', N'SF1000', N'User ID', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.DepartmentID', N'SF1000', N'Department', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.Tel', N'SF1000', N'Mobile fone', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.Fax', N'SF1000', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1000.FullName', N'SF1000', N'User name', N'en-US', NULL

