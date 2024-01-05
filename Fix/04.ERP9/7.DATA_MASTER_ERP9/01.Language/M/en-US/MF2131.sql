-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2131- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2131';

SET @LanguageValue = N'Update production process';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process name';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waitting time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max time';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PreviousOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Next phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.NextOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;