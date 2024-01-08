-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2020- S
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
SET @FormID = 'SF2020';

SET @LanguageValue = N'規則清單';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則類型';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.TypeRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'規則類型';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.TypeRulesName', @FormID, @LanguageValue, @Language;

