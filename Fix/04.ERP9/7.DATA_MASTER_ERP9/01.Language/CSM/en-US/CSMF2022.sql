-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2010- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2022';

SET @LanguageValue = N'Choose Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventor yName';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'WareHouse';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ordered Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.OrderedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.AvailableQuantity', @FormID, @LanguageValue, @Language;

