-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1091- CI
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
SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1091';

EXEC ERP9AddLanguage @ModuleID, N'CIF1091.Title', @FormID, N'Update type of object increase automatically', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeID', @FormID, N'Type of object', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeName.CB', @FormID, N'Type name', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeID.CB', @FormID, N'Type ID', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CIF1091.TypeName.CB', @FormID, N'Type name', @Language, NULL

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.STypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.SName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1091.APK', @FormID, @LanguageValue, @Language;

