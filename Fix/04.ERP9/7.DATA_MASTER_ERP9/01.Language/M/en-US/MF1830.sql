-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1830- M
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
SET @FormID = 'MF1830';

SET @LanguageValue = N'List of alternative materials';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material name';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialName_Temp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material type name';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;