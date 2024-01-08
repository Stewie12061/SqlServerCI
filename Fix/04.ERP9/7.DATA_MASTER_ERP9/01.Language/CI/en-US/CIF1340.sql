-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1340- CI
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
SET @FormID = 'CIF1340';

SET @LanguageValue = N'UNit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Generate code automatically';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsAutomatic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display format';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsSeparator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.APK', @FormID, @LanguageValue, @Language;

