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
SET @Language = 'zh-CN' 
SET @ModuleID = 'S';
SET @FormID = 'SF0012';

SET @LanguageValue = N'訪問歷史記錄';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'系統時間';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ServerTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶時間';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ClientTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IP地址';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.IPLogin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽器';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽器版本';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.FromToDate', @FormID, @LanguageValue, @Language;

