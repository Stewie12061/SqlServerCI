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
SET @FormID = 'OOF1090';

SET @LanguageValue = N'Danh mục thiết bị/phòng họp';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF1090.AreaName.CB', @FormID, @LanguageValue, @Language;