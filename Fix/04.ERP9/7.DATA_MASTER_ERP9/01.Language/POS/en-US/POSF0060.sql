                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0060 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:34:14 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0060' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0060' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0060.POSF0061Title', N'POSF0060', N'Update the time', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.Title', N'POSF0060', N'Timeline category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.EndHour', N'POSF0060', N'To', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.EndTime', N'POSF0060', N'To time', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.Description', N'POSF0060', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.DivisionID', N'POSF0060', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.BeginMinute', N'POSF0060', N'Hour', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.EndMinute', N'POSF0060', N'Hour', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.Disabled', N'POSF0060', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.ShopID', N'POSF0060', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.TimeID', N'POSF0060', N'Time ', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.TimeName', N'POSF0060', N'Time name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.TimeNameE', N'POSF0060', N'Time name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.Time', N'POSF0060', N'Time', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.BeginHour', N'POSF0060', N'From', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.BeginTime', N'POSF0060', N'From time', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0060.POSF0062Title', N'POSF0060', N'View time details', N'en-US', NULL

