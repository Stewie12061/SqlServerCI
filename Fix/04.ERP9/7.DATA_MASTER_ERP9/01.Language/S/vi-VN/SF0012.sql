-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0012- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0012';

SET @LanguageValue = N'Lịch sử truy cập';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ hệ thống';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ServerTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ máy khách';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ClientTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ IP';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.IPLogin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trình duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiên bản trình duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Note', @FormID, @LanguageValue, @Language;
