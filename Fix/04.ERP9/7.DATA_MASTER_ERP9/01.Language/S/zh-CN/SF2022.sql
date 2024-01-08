-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2022- S
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
SET @FormID = 'SF2022';

SET @LanguageValue = N'詳細規則之查看';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TypeRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則類型';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TypeRulesName', @FormID, @LanguageValue, @Language;

