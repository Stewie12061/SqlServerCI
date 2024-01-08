-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1402- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1402';

SET @LanguageValue  = N'See details of conversion units'
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the unit of measure';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion factor';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ConversionFactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.DataType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'For example';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.Example', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.UnitText', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit conversion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ConvertUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculation name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.DataTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.OperatorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.APKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Conversion unit information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1402.ThongTinDonViTinhCD',  @FormID, @LanguageValue, @Language;