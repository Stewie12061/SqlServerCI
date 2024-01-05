-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1030- CRM
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
SET @FormID = 'CRMF1030';

SET @LanguageValue = N'Email group receipt list';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email receipt group ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email receipt group name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revision date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1030.LastModifyDate', @FormID, @LanguageValue, @Language;

