                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00761 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:37:37 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00761' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00761' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00761.Title', N'POSF00761', N'Choose member', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.TitleOKIA', N'POSF00761', N'Choose customers', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberID', N'POSF00761', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.PlaceHolder', N'POSF00761', N'Enter the code or member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberName', N'POSF00761', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberNameE', N'POSF00761', N'English name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberNameE', N'POSF00761', N'English name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberNameOKIA', N'POSF00761', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.MemberIDOKIA', N'POSF00761', N'Customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.PhoneOKIA', N'POSF00761', N'Phone', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00761.Phone', N'POSF00761', N'Phone', N'en-US', NULL

