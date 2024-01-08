-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1301- CI
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
SET @FormID = 'CIF1301';
SET @LanguageValue  = N'Update inventory norms'
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.APK', @FormID, @LanguageValue, @Language;

