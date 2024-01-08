-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0100- OO
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
SET @ModuleID = 'S';
SET @FormID = 'SF0100';

SET @LanguageValue = N'List of data';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.CategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code master';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file name';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'SF0100.LastModifyDate', @FormID, @LanguageValue, @Language;

