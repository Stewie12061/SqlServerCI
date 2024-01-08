-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1831- M
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
SET @FormID = 'MF1831';

SET @LanguageValue = N'Update alternative material';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialName_Temp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Alternative material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Alternative material name';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Alternative factor';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CoValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type name';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.StandardName.CB', @FormID, @LanguageValue, @Language;