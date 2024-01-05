-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1080- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1080';

SET @LanguageValue = N'List of action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1080.LastModifyUserName', @FormID, @LanguageValue, @Language;