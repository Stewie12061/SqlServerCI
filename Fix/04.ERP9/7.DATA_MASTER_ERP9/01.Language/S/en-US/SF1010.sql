                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1010 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:23:40 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF1010' and Module = N'S'
-- SELECT * FROM A00001 WHERE FormID = 'SF1010' and Module = N'S' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'S', N'SF1010.Title', N'SF1010', N'Group user category', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1010.DivisionIDFilter', N'SF1010', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1010.DisabledFilter', N'SF1010', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1010.GroupIDFilter', N'SF1010', N'Group user ID', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF1010.GroupNameFilter', N'SF1010', N'Group user name', N'en-US', NULL

