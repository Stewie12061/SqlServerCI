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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1001';

SET @LanguageValue = N'Cập nhật liên Hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CRMF1001Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên đệm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BirthDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mở tại ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extent';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.AccountName', @FormID, @LanguageValue, @Language;

--- 06/01/2021 - Trọng Kiên: Bổ sung ngôn ngữ cho các Group và Title

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'GR.ThongTinChung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'GR.ThongTinKhac', @FormID, @LanguageValue, @Language;

--- 15/03/2021 - Đình Hòa : Bổ sung ngôn ngữ Combobox
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1001.DistrictName.CB', @FormID, @LanguageValue, @Language;



