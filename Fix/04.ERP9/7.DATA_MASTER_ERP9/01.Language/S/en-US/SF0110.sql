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
SET @Language = 'en-US'
SET @ModuleID = 'S';
SET @FormID = 'SF0110';

SET @LanguageValue = N'Setting hide-show menu';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Menu name';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.sysScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not Use';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.CustomerIndex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Menu Name';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ScreenIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Menu Level';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module Name';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleName.CB', @FormID, @LanguageValue, @Language;