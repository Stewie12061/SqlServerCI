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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1000';

SET @LanguageValue = N'Danh mục liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CRMF1000Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên đệm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức Danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mở tại ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1000.AccountName', @FormID, @LanguageValue, @Language;

