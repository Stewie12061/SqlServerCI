-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1001- HRM
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
SET @FormID = 'OOF1001';

SET @LanguageValue = N'Pemission types Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.AbsentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Vie)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Come late/leave early';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.IsDTVS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restrict';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restrict';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1001.RestrictName', @FormID, @LanguageValue, @Language;

