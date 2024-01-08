-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0041- OO
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
SET @FormID = 'OOF0041';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團組代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團組名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF0041.ModuleName', @FormID, @LanguageValue, @Language;

