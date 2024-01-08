-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1090-OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1092';

SET @LanguageValue = N'Xem chi tiết thông tin thiết bị/phòng họp';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.ThongTinThietBiPhongHop', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1092.LastModifyDate', @FormID, @LanguageValue, @Language;
