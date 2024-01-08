-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1491- CI
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
SET @FormID = 'CIF1491';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regional order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.OrdersArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the analysis code type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1491.AnaTypeName', @FormID, @LanguageValue, @Language;

