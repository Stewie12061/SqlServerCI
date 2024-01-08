-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1012- OO
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
SET @FormID = 'OOF1012';

SET @LanguageValue = N'Unusual type View';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormal type code';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Treatment methods';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Treatment methods';
EXEC ERP9AddLanguage @ModuleID, 'OOF1012.HandleMethodName', @FormID, @LanguageValue, @Language;

