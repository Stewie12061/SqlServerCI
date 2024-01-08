                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0058 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:33:26 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0058' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0058' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0058.Description', N'POSF0058', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.Disabled', N'POSF0058', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.ShopID', N'POSF0058', N'Mã cửa hàng', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.DivisionID', N'POSF0058', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.AreaID', N'POSF0058', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.AreaName', N'POSF0058', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.AreaNameE', N'POSF0058', N'Area name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.POSF0058Group02Title', N'POSF0058', N'System info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.POSF0058Group01Title', N'POSF0058', N'Area info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0058.Title', N'POSF0058', N'Area info details', N'en-US', NULL

