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
SET @Language = 'vi-VN' 
SET @ModuleID = 'S';
SET @FormID = 'SF2020';

SET @LanguageValue = N'Danh sách rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
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

SET @LanguageValue = N'Mã rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Rule';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.TypeRulesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Rule';
EXEC ERP9AddLanguage @ModuleID, 'SF2020.TypeRules', @FormID, @LanguageValue, @Language;



