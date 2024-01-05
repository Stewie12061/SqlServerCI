                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0026 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:19:09 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0026' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0026' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0026.Title', N'POSF0026', N'Membership card category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.DivisionID', N'POSF0026', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.Active', N'POSF0026', N'Activity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.Locked', N'POSF0026', N'Lock card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.MemberCardType', N'POSF0026', N'Card type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.LockReason', N'POSF0026', N'Reason for locking', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.MemberID', N'POSF0026', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.MemberCardID', N'POSF0026', N'Member card ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.ExpiryDate', N'POSF0026', N'Expire date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.ReleaseDate', N'POSF0026', N'Release date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.MemberName', N'POSF0026', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.MemberCardName', N'POSF0026', N'Member card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0026.PopupAddTitle', N'POSF0026', N'Add member', N'en-US', NULL

