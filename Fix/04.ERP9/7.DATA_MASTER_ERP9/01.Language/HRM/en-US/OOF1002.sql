-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1002- HRM
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
SET @FormID = 'OOF1002';

SET @LanguageValue = N'Permission types View';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent TypeID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Descriptioni';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restrict ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restrict Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.RestrictName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permission type information';
EXEC ERP9AddLanguage @ModuleID, 'OOF1002.SubTitle1' , @FormID, @LanguageValue, @Language;