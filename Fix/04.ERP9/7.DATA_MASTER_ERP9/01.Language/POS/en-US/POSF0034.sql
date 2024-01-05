                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0034 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:23:59 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0034' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0034' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0034.PopupAddTitle', N'POSF0034', N'Update region list', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.Title', N'POSF0034', N'Area category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.Description', N'POSF0034', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.Disabled', N'POSF0034', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.ShopID', N'POSF0034', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.DivisionID', N'POSF0034', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.AreaID', N'POSF0034', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.AreaName', N'POSF0034', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.AreaNameE', N'POSF0034', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0034.DisabledFilter', N'POSF0034', N'Disabled filter', N'en-US', NULL

