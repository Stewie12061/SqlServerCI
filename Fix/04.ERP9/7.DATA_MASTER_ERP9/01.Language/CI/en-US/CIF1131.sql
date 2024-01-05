------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1131 
-----------------------------------------------------------------------------------------------------
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
SET @FormID = 'CIF1131';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Update inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Inventory type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.InventoryTypeNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1131.Disabled' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;