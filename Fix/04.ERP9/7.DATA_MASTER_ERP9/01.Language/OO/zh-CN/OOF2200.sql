-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2200- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2200';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'警告內容';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'警告類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.MessageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.IsRead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'業務';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenID', @FormID, @LanguageValue, @Language;

