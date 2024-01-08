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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2250';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件夾代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件夾名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母文件夾';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.ParentNode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門/組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.UserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門/組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.UserGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastFolderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.LastFolderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.FieldUserGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.Edit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2250.CreateUserName', @FormID, @LanguageValue, @Language;

