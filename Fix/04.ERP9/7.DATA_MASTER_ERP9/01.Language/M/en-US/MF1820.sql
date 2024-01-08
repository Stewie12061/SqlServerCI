-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1820- M
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
SET @FormID = 'MF1820';

SET @LanguageValue = N'List of production resources';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng góp';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting time';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waiting time';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer time';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min time';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max time';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type name';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;