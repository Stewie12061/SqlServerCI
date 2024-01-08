-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1001- CRM
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
SET @FormID = 'CRMF1001';

SET @LanguageValue = N'Update contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CRMF1001Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vocative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'First and middle names';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mobile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue bank name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.APKRel2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.RelatedToID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.TableREL2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is convert';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsConvert', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, N'GR.ThongTinChung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other information';
EXEC ERP9AddLanguage @ModuleID, N'GR.ThongTinKhac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, N'BusinessCity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, N'City', @FormID, @LanguageValue, @Language;

