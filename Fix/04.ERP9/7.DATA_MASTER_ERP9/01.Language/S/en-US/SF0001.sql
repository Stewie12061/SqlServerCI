                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0001 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 1:15:46 PM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'SF0001' and Module = N'S'
-- SELECT * FROM A00001 WHERE FormID = 'SF0001' and Module = N'S' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'S', N'SF0001.GroupID', N'SF0001', N'Group user', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsAddNew', N'SF0001', N'Add new', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsDelete', N'SF0001', N'Delete', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsExportExcel', N'SF0001', N'Export excel', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsPrint', N'SF0001', N'Print', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsUpdate', N'SF0001', N'Update', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsView', N'SF0001', N'View', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ModuleID', N'SF0001', N'Module', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.Notification', N'SF0001', N'Note: Setup can only be used after log off and log back in', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenHeader', N'SF0001', N'Screen type', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenID', N'SF0001', N'Screen ID', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenName', N'SF0001', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenNameE', N'SF0001', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName1', N'SF0001', N'1 - Monitor report', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName2', N'SF0001', N'2 - Category screen', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName3', N'SF0001', N'3 - Input screen', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName4', N'SF0001', N'4 - Orther screen', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName5', N'SF0001', N'5 - View details screen', N'en-US', NULL

----------------------------------- Modified by Tấn Thành on 01/09/2020 ------------------------------------------
--EXEC ERP9AddLanguage N'S', N'SF0001.Title', N'SF0001', N'User group permissions', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.Title', N'SF0001', N'Functions Permission', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.ScreenTypeName6', N'SF0001', N'DashBoard', N'en-US', NULL
------------------------------------------------------------------------------------------------------------------

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
EXEC ERP9AddLanguage N'S', N'SF0001.Platform', N'SF0001', N'Platform', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsDisabled', N'SF0001', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsHidden', N'SF0001', N'Hidden', N'en-US', NULL
EXEC ERP9AddLanguage N'S', N'SF0001.IsApplyAll', N'SF0001', N'All platforms apply', N'en-US', NULL


