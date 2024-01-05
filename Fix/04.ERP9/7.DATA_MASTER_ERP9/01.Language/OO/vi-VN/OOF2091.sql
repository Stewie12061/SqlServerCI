-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2091- OO
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
SET @FormID = 'OOF2091';

SET @LanguageValue = N'Cập nhật thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông báo chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformType1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông báo nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformType2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformType1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.InformType2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.ChooseFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm ảnh';
EXEC ERP9AddLanguage @ModuleID, 'OOF2091.ChooseImage', @FormID, @LanguageValue, @Language;