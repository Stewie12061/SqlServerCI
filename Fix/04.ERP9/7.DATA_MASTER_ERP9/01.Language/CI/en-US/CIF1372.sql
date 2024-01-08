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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1372';

SET @LanguageValue = N'Machine view';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng góp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of formation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time in line';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setup time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waiting time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travel time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capacity/unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rated time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total number of employees';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Infomation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Technical parameters';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StatusID',  @FormID, @LanguageValue, @Language;

