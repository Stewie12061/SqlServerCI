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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1370';

SET @LanguageValue = N'List of machine';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standby time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capacity/Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total working hours';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

