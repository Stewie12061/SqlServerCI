-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0101- S
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
SET @FormID = 'SF0101';

SET @LanguageValue = N'Updated data';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code master';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID 01';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order no';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LanguageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file name';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleName.CB', @FormID, @LanguageValue, @Language;
