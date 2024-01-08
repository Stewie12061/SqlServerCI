-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2250- OO
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2250';

SET @LanguageValue = N'Danh mục thư mục (public)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thư mục';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thư mục';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thư mục cha';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.ParentNode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban/Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.UserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban/Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.UserGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastFolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastFolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FieldUserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.Edit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateUserName', @FormID, @LanguageValue, @Language;

