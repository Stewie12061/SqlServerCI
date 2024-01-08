                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0002 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 1:24:03 PM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF0002' and Module = N'S'
-- SELECT * FROM A00001 WHERE FormID = 'SF0002' and Module = N'S' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'S', N'SF0002.AdminUserID', N'SF0002', N'User', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.Grid1Title', N'SF0002', N'Current user list', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.Grid2Title', N'SF0002', N'List of users viewed', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.Notes', N'SF0002', N'Note', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.Title', N'SF0002', N'Update permissions to view other people data', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.UserID', N'SF0002', N'User code', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0002.UserName', N'SF0002', N'User name', N'en-US', NULL

