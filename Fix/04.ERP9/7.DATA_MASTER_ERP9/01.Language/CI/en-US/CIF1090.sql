-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1090- CI
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
SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1090';

EXEC ERP9AddLanguage @ModuleID, N'CIF1090.Title', @FormID, N'Type of object increase automatically', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeID', @FormID, N'Type of object', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeName.CB', @FormID, N'Type name', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1090.TypeID.CB', @FormID, N'Type ID', @Language, NULL

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.STypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.SName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan detail ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.APK', @FormID, @LanguageValue, @Language;

