-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2010- OO
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
SET @FormID = 'OOF2010';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permit application code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Room';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Committee';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proponent';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF2010.Description', @FormID, @LanguageValue, @Language;

