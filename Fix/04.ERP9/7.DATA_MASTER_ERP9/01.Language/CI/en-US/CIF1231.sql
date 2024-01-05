-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1231- CI
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
SET @FormID = 'CIF1231';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.FromInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ToInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'WareHouse ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rated type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ReOrderQuantity', @FormID, @LanguageValue, @Language;