-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0110- S
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
SET @FormID = 'SF0110';

SET @LanguageValue = N'Thiết lập ẩn-hiện menu';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.sysScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.CustomerIndex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ScreenIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp Menu';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.TypeMenu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Loại';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.TypeMenuID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.TypeMenuName.CB', @FormID, @LanguageValue, @Language;




