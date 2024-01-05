------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1141 
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
SET @FormID = 'CIF1141';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Category Ware House';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Ware house code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ware house name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.WareHouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ware house temp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.IsTemp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stocker';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1141.Disabled' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;