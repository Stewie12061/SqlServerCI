-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1001- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1001';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Spell type code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of permission to arrive late and leave early';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regulations';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of Regulation';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictName', @FormID, @LanguageValue, @Language;

