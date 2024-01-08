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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Name(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standby time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capacity/Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total working hours';
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

