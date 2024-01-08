-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1492- CI
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
SET @FormID = 'CIF1492';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regional order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.OrdersArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the analysis code type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1492.AnaTypeName', @FormID, @LanguageValue, @Language;

