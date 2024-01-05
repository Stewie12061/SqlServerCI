                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0033 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:23:33 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0033' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0033' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0033.CurrentShift', N'POSF0033', N'Current shift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0033.NextShift', N'POSF0033', N'Next shift', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0033.Description', N'POSF0033', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0033.Title', N'POSF0033', N'Finish shift', N'en-US', NULL

