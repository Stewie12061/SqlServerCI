-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1330- CI
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
SET @FormID = 'CIF1330';

SET @LanguageValue  = N'Automatic object ID'
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Generate code automatically';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsAutomatic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display format';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsSeparator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TypeID',  @FormID, @LanguageValue, @Language;