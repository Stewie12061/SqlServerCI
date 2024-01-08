-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1510- CI
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
SET @FormID = 'CIF1510';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tool code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tool name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tool type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tool type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.ToolTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the unit of measure';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.IsDisable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1510.LastModifyDate', @FormID, @LanguageValue, @Language;

