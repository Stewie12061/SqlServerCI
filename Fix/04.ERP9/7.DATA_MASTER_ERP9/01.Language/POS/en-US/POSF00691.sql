                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00691 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:35:44 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00691' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00691' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00691.Title', N'POSF00691', N'Detailed member sales report', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00691.MemberID', N'POSF00691', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00691.PlaceHolder', N'POSF00691', N'Enter the code or member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00691.MemberName', N'POSF00691', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00691.MemberNameE', N'POSF00691', N'English name', N'en-US', NULL

