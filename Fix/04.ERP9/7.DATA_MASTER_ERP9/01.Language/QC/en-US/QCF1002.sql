-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1002- QC
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
SET @FormID = 'QCF1002';

SET @LanguageValue = N'Details of the standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard code';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'standard name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard name (English)';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Father standard';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default field';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data type';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Using material';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard type of price calculation sheet';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard information';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.History', @FormID, @LanguageValue, @Language;