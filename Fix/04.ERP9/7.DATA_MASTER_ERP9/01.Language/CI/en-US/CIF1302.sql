-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1302- CI
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
SET @FormID = 'CIF1302';
SET @LanguageValue  = N'View inventory norms in detail'
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm code information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ThongTinMaDinhMuc',  @FormID, @LanguageValue, @Language;