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
SET @Language = 'ja-JP'
SET @ModuleID = 'S';
SET @FormID = 'SF0012';

SET @LanguageValue = N'Login history';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Server time';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ServerTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client time';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.ClientTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IP address';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.IPLogin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browser';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browser version';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.BrowserVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'SF0012.Note', @FormID, @LanguageValue, @Language;
