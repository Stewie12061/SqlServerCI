                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0011 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:07:09 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0011' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0011' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0011.Title', N'POSF0011', N'Member category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.AddressFilter', N'POSF0011', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.AccruedScore', N'POSF0011', N'Accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.PhoneFilter', N'POSF0011', N'Mobile phone', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.DivisionIDFilter', N'POSF0011', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.EmailFilter', N'POSF0011', N'Email', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.FaxFilter', N'POSF0011', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.Gender', N'POSF0011', N'Gender', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.DisabledFilter', N'POSF0011', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.ShopIDFilter', N'POSF0011', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.MemberIDFilter', N'POSF0011', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.IdentifyFilter', N'POSF0011', N'Identify', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.TelFilter', N'POSF0011', N'Tel', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.MemberNameFilter', N'POSF0011', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.Disabled', N'POSF0011', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.IsCommon', N'POSF0011', N'Common', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSF0011.TitleOKIA', N'POSF0011', N'Customer category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.MemberIDFilterOKIA', N'POSF0011', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0011.MemberNameFilterOKIA', N'POSF0011', N'Customer name', N'en-US', NULL

