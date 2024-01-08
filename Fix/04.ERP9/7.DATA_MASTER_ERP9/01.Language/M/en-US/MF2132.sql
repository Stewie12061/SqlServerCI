-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2132- M
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
SET @FormID = 'MF2132';

SET @LanguageValue = N'Production process view';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process name';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ResourceUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waitting time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max time';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PreviousOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Next phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.NextOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production process';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.QuyTrinhSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production process details';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ChiTietQuyTrinhSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.StatusID', @FormID, @LanguageValue, @Language;