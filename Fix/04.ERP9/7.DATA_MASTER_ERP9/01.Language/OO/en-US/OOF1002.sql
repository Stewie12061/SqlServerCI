-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1002- OO
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
SET @FormID = 'OOF1002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Spell type code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regulation Code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of work';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of Regulation';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictName', @FormID, @LanguageValue, @Language;

