-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1042- CI
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
SET @FormID = 'CIF1042';

SET @LanguageValue = N'样本電子郵件詳細信息之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本電子郵件代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'樣本電子郵件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.EmailTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件群組';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.EmailGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'邮件內容';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.EmailBody', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.EmailGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1042.ScreenID', @FormID, @LanguageValue, @Language;

