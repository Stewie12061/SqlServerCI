-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1042- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1042';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'順序';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'百分比 （％）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.IsSystem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.Color', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'系統階段';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.SystemStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'英文的階段名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.StageNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過濾數據';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1042.DataFilter', @FormID, @LanguageValue, @Language;

