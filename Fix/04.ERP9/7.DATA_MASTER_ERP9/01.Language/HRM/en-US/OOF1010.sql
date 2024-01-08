-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1010- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'OOF1010';

SET @LanguageValue = N'List of unusual types';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unusual Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.HandleMethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Handle Method Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1010.HandleMethodName', @FormID, @LanguageValue, @Language;

