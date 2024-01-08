-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1144- CI
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
SET @FormID = 'CIF1144';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Store code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stocker';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.IsTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage by location';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.IsLocation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is CS';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.IsCS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage by location';
EXEC ERP9AddLanguage @ModuleID, 'CIF1144.IsLocationCBB', @FormID, @LanguageValue, @Language;

