-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1001- QC
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
SET @FormID = 'QCF1001';

SET @LanguageValue = N'Update standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard code';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Father standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default field';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Declare the formula';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use raw materials';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseIDSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseNameSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type of price calculation sheet';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

