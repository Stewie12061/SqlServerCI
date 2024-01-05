-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1000- CRM
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
SET @FormID = 'CRMF1000';

SET @LanguageValue = N'List of contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vocative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'First and middle names';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.TableREL2', @FormID, @LanguageValue, @Language;

