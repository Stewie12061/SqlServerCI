-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1821- M
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
SET @FormID = 'MF1821';

SET @LanguageValue = N'Update production resource';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lined up timme';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waiting time';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min time';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max time';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type name';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;