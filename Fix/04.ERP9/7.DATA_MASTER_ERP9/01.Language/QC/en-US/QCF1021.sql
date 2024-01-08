-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1021- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF1021';

SET @LanguageValue = N'Update standard definition';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.InventoryIDSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.UpdateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.ChooseImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.TabQCT1021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apperance standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.TabQCT10211', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardID_APPE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lower threshold';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.SRange01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.SRange02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.SRange03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.SRange04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Upper threshold';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.SRange05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.MathRecipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1021.UnitName.CB', @FormID, @LanguageValue, @Language;