-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1371- CI
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
SET @FormID = 'CIF1371';

SET @LanguageValue = N'資源之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投入使用日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源類型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'排隊時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設定時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'等待的時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'移動時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最短時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最長時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'容量/計量單位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'額定時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工總數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WorkersLimit', @FormID, @LanguageValue, @Language;

