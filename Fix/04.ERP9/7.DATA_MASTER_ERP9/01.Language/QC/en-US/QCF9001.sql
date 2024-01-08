-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF9001- QC
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
SET @FormID = 'QCF9001';

SET @LanguageValue = N'List of standards';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard code';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name (English)';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Father standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data type';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe type';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default field';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

