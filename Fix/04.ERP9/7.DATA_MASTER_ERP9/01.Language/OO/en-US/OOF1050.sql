-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1050- OO
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
SET @FormID = 'OOF1050';


SET @LanguageValue = N'List of project /task group sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.ProjectSampleID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.ProjectSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1050.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name';									   
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DivisionName.CB', @FormID, @LanguageValue, @Language;
