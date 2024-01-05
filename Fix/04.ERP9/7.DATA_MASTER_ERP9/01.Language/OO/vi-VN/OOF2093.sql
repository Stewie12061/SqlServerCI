-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2093- OO
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
SET @FormID = 'OOF2093';

SET @LanguageValue = N'Xem chi tiết thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.XemChiTietThongBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.NoiDung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2093.DinhKem', @FormID, @LanguageValue, @Language;