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
SET @Language = 'en-USN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1401';

SET @LanguageValue  = N'Update conversion units'
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the unit of measure';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion factor';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.ConversionFactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculation code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'For example';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Example', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit conversion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.ConvertUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculation name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.OperatorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.APKDetail', @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Inventory code code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory code name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operator code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.Operator.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.OperatorName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Calculation code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Calculation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.DataTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recipe code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recipe name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.FormulaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Specification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Specification name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1401.StandardName.CB',  @FormID, @LanguageValue, @Language;
