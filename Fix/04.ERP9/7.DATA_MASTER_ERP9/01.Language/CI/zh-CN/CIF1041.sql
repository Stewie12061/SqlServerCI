-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1041- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1041';

SET @LanguageValue = N'配送路線詳細之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本電子郵件代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本電子郵件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.EmailTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件群組';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.EmailGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'邮件內容';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.EmailBody', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.EmailGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1041.ScreenID', @FormID, @LanguageValue, @Language;

