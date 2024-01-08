                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0035 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:24:30 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0035' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0035' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0035.PopupAddTitle', N'POSF0035', N'Update area', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.Description', N'POSF0035', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.Disabled', N'POSF0035', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.AreaID', N'POSF0035', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.AreaName', N'POSF0035', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.AreaNameE', N'POSF0035', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0035.Title', N'POSF0035', N'Area info', N'en-US', NULL

