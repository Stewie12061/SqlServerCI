                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0036 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:24:59 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0036' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0036' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0036.Empty', N'POSF0036', N'Empty table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0036.Title', N'POSF0036', N'Select area / table', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0036.Choosed', N'POSF0036', N'Selected', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0036.Cooked', N'POSF0036', N'Printed', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0036.Printed', N'POSF0036', N'Print invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0036.Area', N'POSF0036', N'Area', N'en-US', NULL

