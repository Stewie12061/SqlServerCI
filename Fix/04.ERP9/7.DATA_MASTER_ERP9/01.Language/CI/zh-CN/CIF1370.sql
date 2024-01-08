-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1370- CI
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
SET @FormID = 'CIF1370';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投入使用日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'資源類型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'效率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'排隊時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設定時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'等待的時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換乘時間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'容量/計量單位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WorkersLimit', @FormID, @LanguageValue, @Language;

