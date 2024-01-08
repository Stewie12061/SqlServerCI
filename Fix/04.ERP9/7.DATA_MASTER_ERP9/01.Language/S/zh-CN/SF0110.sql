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
SET @Language = 'zh-CN' 
SET @ModuleID = 'S';
SET @FormID = 'SF0110';

SET @LanguageValue = N'隱藏/顯示選單之设立';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.TypeMenu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'企業名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.MenuNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'業務代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0110.ScreenIDFilter', @FormID, @LanguageValue, @Language;

