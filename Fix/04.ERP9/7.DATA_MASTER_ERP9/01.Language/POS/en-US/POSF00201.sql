                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00201 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:15:42 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00201' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00201' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00201.PopupAddTitle', N'POSF00201', N'Update membership card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.TitleOKIA', N'POSF00201', N'Update customer card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.DivisionID', N'POSF00201', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.Locked', N'POSF00201', N'Lock card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.Disabled', N'POSF00201', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.IsCommon', N'POSF00201', N'IsCommon', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.TypeNo', N'POSF00201', N'Card type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.LockReason', N'POSF00201', N'Reason for locking', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.LockedReason', N'POSF00201', N'Lock reason', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberID', N'POSF00201', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberCardID', N'POSF00201', N'Member card ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.ExpireDate', N'POSF00201', N'Expire date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.ReleaseDate', N'POSF00201', N'Release date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberName', N'POSF00201', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberCardName', N'POSF00201', N'Member card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.Title', N'POSF00201', N'Member name card info', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberCardIDOKIA', N'POSF00201', N'Customer card code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberCardNameOKIA', N'POSF00201', N'Customer card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberIDOKIA', N'POSF00201', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00201.MemberNameOKIA', N'POSF00201', N'Customer name', N'en-US', NULL

