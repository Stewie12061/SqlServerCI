-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1821- M
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
SET @FormID = 'MF1821';

SET @LanguageValue = N'生產資源之更新';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'排隊時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設定時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'等待的時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換乘時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最短時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最長時間';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源類型';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceTypeID', @FormID, @LanguageValue, @Language;

