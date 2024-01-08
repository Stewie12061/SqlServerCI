-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1400- CI
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
SET @FormID = 'CIF1400';

SET @LanguageValue = N'換算單位清單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計量單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算係數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.ConversionFactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公式代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'例子';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.Example', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.UnitText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位換算';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.ConvertUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.OperatorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1400.APKDetail', @FormID, @LanguageValue, @Language;

