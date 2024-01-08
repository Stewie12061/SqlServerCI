-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1410- CI
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
SET @FormID = 'CIF1410';

SET @LanguageValue  = N'List of goods specifications'
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification type name (English)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsCommon', @FormID, @LanguageValue, @Language;

