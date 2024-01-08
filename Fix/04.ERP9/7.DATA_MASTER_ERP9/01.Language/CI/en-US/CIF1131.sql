-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1131- CI
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
SET @FormID = 'CIF1131';
SET @LanguageValue = N'Update inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.APK', @FormID, @LanguageValue, @Language;

SET @Finished = 0;