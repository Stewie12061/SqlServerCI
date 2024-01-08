                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0020 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:15:11 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0020' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0020' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0020.Title', N'POSF0020', N'Membership card category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.TitleOKIA', N'POSF0020', N'Customer card category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.DivisionID', N'POSF0020', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.TypeNo', N'POSF0020', N'Card type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.LockReason', N'POSF0020', N'Reason for locking', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberID', N'POSF0020', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberCardID', N'POSF0020', N'Member card ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.ExpiryDate', N'POSF0020', N'Expire date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.ReleaseDate', N'POSF0020', N'Release date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberName', N'POSF0020', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberCardName', N'POSF0020', N'Member card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.PopupAddTitle', N'POSF0020', N'Add member card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.Disabled', N'POSF0020', N'Status', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.IsCommon', N'POSF0020', N'Common', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberCardIDOKIA', N'POSF0020', N'Customer card code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberCardNameOKIA', N'POSF0020', N'Customer card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberIDOKIA', N'POSF0020', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0020.MemberNameOKIA', N'POSF0020', N'Customer name', N'en-US', NULL

