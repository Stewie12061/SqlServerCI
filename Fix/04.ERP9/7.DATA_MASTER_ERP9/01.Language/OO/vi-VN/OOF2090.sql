-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2090- OO
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
SET @FormID = 'OOF2090';

SET @LanguageValue = N'Danh sách thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformType1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.InformType2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao diện Newsfeed';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.NewsfeedLayout', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hi {0}, bạn muốn thông báo gì?';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.CreatePlaceHolder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng tin';
EXEC ERP9AddLanguage @ModuleID, 'OOF2090.Newsfeed', @FormID, @LanguageValue, @Language;