                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0038 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:25:53 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0038' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0038' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0038.Title', N'POSF0038', N'Order', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0038.Dish', N'POSF0038', N'Dish', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0038.Category', N'POSF0038', N'Analysis', N'en-US', NULL

