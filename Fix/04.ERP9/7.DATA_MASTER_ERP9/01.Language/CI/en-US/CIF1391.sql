-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1391- CI
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
SET @FormID = 'CIF1391';

SET @LanguageValue  = N'Update conversion formula settings'
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Notes', @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Declare parameters';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.KhaiBaoThamSo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Set up the formula';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.ThietLapCongThuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Define';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'English definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.IsUsed',  @FormID, @LanguageValue, @Language;