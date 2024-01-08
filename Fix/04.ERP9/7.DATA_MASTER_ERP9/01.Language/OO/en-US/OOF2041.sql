-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2041- OO
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
SET @FormID = 'OOF2041';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permit application code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Board name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Description', @FormID, @LanguageValue, @Language;

