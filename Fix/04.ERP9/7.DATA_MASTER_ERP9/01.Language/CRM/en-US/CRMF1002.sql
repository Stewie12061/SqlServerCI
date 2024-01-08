-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1002- CRM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1002';

SET @LanguageValue = N'Contact view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vocative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'First and middle names';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Birthdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCMNT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ThongTinChung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ThongTinKhac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View contact details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CRMF1002Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT10101', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.StatusID', @FormID, @LanguageValue, @Language;

