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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1002';
 
SET @LanguageValue = N'Xem chi tiết liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CRMF1002Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TabDetail';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabDetail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên đệm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Messenger', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức Danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TitleContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/xã cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessPostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/xã nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeWardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomePostalCodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia nhà riêng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Birthdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mở tại ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extent';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.HomeFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ThongTinChung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.ThongTinKhac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCMNT90051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.KhachHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.BusinessCountry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1002.Birthdate', @FormID, @LanguageValue, @Language;

