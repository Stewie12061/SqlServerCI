-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2072- OO
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
SET @FormID = 'OOF2072';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift change application code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.Description', @FormID, @LanguageValue, @Language;

