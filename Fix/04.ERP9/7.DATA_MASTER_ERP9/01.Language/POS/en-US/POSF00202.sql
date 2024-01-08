                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00202 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:16:08 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00202' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00202' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00202.MemberID', N'POSF00202', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00202.MemberName', N'POSF00202', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00202.Title', N'POSF00202', N'Member filter', N'en-US', NULL

