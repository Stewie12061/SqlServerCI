-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1000- QC
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
SET @FormID = 'QCF1000';

SET @LanguageValue = N'标准清单';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准代码';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称（英文）';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型号名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'父親標準';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配方类型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預設字段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认值';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'技術參數';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1000.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

