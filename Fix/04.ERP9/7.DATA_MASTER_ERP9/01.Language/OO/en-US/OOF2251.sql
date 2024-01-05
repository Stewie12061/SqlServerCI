-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2251- OO
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
SET @FormID = 'OOF2251';

SET @LanguageValue = N'Update folder';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Folder ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.FolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Folder name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.FolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent folder';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.ParentNode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.UserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department/group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.UserGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.LastFolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.LastFolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.FieldUserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.Edit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2251.CreateUserName', @FormID, @LanguageValue, @Language;

