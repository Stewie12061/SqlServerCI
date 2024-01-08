-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1490- CI
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
SET @FormID = 'CIF1490';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Groups';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regional order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.OrdersArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the analysis code type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1490.AnaTypeName', @FormID, @LanguageValue, @Language;

