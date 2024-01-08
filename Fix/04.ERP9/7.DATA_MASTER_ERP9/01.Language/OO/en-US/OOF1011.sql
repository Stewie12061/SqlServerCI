-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1011- OO
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
SET @FormID = 'OOF1011';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormal type code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Treatment methods';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Treatment methods';
EXEC ERP9AddLanguage @ModuleID, 'OOF1011.HandleMethodName', @FormID, @LanguageValue, @Language;

