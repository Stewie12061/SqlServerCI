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
SET @Language = 'zh-CN' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF9001';

SET @LanguageValue = N'选择标准';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准代码';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称（英文）';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型号名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'父親標準';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配方类型';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預設字段';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认值';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

