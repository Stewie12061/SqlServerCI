                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00111 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:08:03 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF00111' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF00111' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF00111.Title', N'POSF00111', N'{0} member', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleUpdate', N'POSF00111', N'MEMBER UPDATES', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Address', N'POSF00111', N'Address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.AccruedScore', N'POSF00111', N'Accured score', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Description', N'POSF00111', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Phone', N'POSF00111', N'Mobile phone', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Email', N'POSF00111', N'Email', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Fax', N'POSF00111', N'Fax', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Gender', N'POSF00111', N'Gender', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Active', N'POSF00111', N'Activity', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.IsMemberID', N'POSF00111', N'Membership / Visitation', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Mailbox', N'POSF00111', N'Mailbox', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Locked', N'POSF00111', N'Lock card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Disabled', N'POSF00111', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TypeNo', N'POSF00111', N'Card type category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberID', N'POSF00111', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Identify', N'POSF00111', N'Identify', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberCardID', N'POSF00111', N'Member card ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.AreaID', N'POSF00111', N'Area ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.ExpireDate', N'POSF00111', N'Expire date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.ReleaseDate', N'POSF00111', N'Release date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Birthday', N'POSF00111', N'Birthday', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.WardName', N'POSF00111', N'Wards', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.CountyName', N'POSF00111', N'District', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.CountryID', N'POSF00111', N'Country', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Tel', N'POSF00111', N'Tel', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberName', N'POSF00111', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberNameE', N'POSF00111', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.ShortName', N'POSF00111', N'Short name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberCardName', N'POSF00111', N'Member card name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleInsert', N'POSF00111', N'INSERT SHOP', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleA', N'POSF00111', N'Member info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleB', N'POSF00111', N'Member name card info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.CityID', N'POSF00111', N'City', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.Website', N'POSF00111', N'Website', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.IsCommon', N'POSF00111', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.BankAccountNo', N'POSF00111', N'Bank account no', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.BankName', N'POSF00111', N'Bank name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.BankAddress', N'POSF00111', N'Bank address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.CompanyAddress', N'POSF00111', N'Company address', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.CompanyName', N'POSF00111', N'Company name', N'en-US', NULL

EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberIDOKIA', N'POSF00111', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.MemberNameOKIA', N'POSF00111', N'Customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleOKIA', N'POSF00111', N'Customer update', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleAOKIA', N'POSF00111', N'Customer information', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF00111.TitleBOKIA', N'POSF00111', N'Customer card information', N'en-US', NULL