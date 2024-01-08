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
SET @Language = 'zh-CN' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF1002';

SET @LanguageValue = N'標準詳情';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准代码';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称（英文）';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型号名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'父親標準';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'配方类型';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CalculateType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預設字段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认值';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.IsVisible', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.Recipe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'技術參數';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.SpecificationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'码数';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DeclareSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用材質';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.UsingMaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1002.TypeSpreadsheetID', @FormID, @LanguageValue, @Language;

