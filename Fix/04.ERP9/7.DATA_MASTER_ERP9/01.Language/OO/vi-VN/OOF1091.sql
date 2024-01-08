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
SET @FormID = 'OOF1091';

SET @LanguageValue = N'Cập nhật thông tin thiết bị/phòng họp';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaName.CB', @FormID, @LanguageValue, @Language;

