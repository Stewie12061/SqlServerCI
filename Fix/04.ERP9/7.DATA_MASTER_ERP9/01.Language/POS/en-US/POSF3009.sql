                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF3009 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:38:10 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF3009' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF3009' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF3009.ShopID', N'POSF3009', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.ToMemberID', N'POSF3009', N'To member', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.ToInventoryID', N'POSF3009', N'To inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.DivisionID', N'POSF3009', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.EmployeeID', N'POSF3009', N'Employee', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.Title', N'POSF3009', N'Consolidate sales by item', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.FromMemberID', N'POSF3009', N'From member', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF3009.FromInventoryID', N'POSF3009', N'From inventory', N'en-US', NULL

