-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2011- S
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
SET @FormID = 'SF2011';

SET @LanguageValue = N'更新管道';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管道代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.PipeLineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管線名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.PipeLineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'晵用事件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'觸發動作';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionActive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第01對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第02對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第03對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第04對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第05對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第06對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第07對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第08對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第09對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第10對象';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第01條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第02條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第03條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第04條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第05條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第06條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第07條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第08條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第09條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第10條件';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第01價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'价值 2';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第03價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'价值 4';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'价值 5';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第06價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第07價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第08價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第09價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第10價值';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ControlType10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.SearchIDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObjectTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObjectFormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObjectArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.IsRequired10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.APKSettingTime', @FormID, @LanguageValue, @Language;

