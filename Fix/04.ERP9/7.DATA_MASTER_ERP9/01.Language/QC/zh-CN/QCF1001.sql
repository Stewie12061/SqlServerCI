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
SET @Language = 'zh-CN'  
SET @ModuleID = 'QC';
SET @FormID = 'QCF1001';

SET @LanguageValue = N'更新的标准';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准代码';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称（英文）';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型号名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'父親標準';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配方类型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預設字段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认值';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'技術參數';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'数据类型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聲明公式';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用材質';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型价格计算表';
EXEC ERP9AddLanguage @ModuleID, 'QCF1001.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

