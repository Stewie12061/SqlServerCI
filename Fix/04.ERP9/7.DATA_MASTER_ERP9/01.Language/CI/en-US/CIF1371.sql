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

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng góp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of formation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time in line';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setup time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waiting time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travel time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capacity/unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rated time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total number of employees';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

