-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1000- OO
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
SET @FormID = 'OOF1000';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Spell type code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1000.RestrictName', @FormID, @LanguageValue, @Language;

