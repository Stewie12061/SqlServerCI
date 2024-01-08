-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1401- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1401';

SET @LanguageValue = N'換算單位之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計量單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算係數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.ConversionFactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計算方式代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公式代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公式描述';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Example', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.ConvertUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'庫存名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計算名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.OperatorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.APKDetail', @FormID, @LanguageValue, @Language;

