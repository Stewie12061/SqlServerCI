-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1822- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1822';

SET @LanguageValue = N'生產資源詳細之查看';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設定時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'等待的時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最短時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最長時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源類型';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceTypeID', @FormID, @LanguageValue, @Language;

