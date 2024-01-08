-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2056- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2056';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RecDecisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Decision day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.FromToDate', @FormID, @LanguageValue, @Language;

