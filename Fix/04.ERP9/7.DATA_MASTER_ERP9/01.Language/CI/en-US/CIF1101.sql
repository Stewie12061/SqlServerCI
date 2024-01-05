------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1101 
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
SET @FormID = 'CIF1101';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Update code auto inventory';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.STypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.S' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.SName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1101.Disabled' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;