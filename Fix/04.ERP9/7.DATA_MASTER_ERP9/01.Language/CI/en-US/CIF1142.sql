-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1142- CI
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
SET @FormID = 'CIF1142';

SET @LanguageValue = N'Detail Ware House';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Store code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ware house temp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsTemp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stocker';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is location';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsLocation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is CS';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsCS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage by location';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsLocationCBB', @FormID, @LanguageValue, @Language;

SET @Finished = 0;