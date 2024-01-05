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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1371';

SET @LanguageValue = N'Update machine';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standby time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capacity/Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total working hours';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

