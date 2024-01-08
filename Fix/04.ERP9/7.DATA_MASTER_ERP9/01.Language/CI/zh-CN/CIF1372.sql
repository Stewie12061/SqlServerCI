-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1372- CI
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
SET @FormID = 'CIF1372';

SET @LanguageValue = N'資源詳細之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投入使用日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源類型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'排隊時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設定時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'等待的時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最短時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最長時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'容量/計量單位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工總數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WorkersLimit', @FormID, @LanguageValue, @Language;

