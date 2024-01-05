------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2101 - S
-- Người tạo: Tấn Thành - 21/01/2021
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
SET @ModuleID = 'S';
SET @FormID = 'SF2101';
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Environment Config ';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Config Type';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Variable Name';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.KeyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Config Function';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.GroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data Type';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DataTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.KeyValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default Value';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DesDefaultValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.ModuleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsEnvironment';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.IsEnvironment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division Name';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionName' , @FormID, @LanguageValue, @Language;