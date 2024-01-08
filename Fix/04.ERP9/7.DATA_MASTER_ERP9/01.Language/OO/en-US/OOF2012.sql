-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2012- OO
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
SET @FormID = 'OOF2012';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permit application code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.Description', @FormID, @LanguageValue, @Language;

