-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0010- S
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
SET @FormID = 'SF0010';

SET @LanguageValue = N'用戶資訊';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行數/頁數';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.PageSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.Avatar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言';
EXEC ERP9AddLanguage @ModuleID, 'SF0010.LanguageID', @FormID, @LanguageValue, @Language;

