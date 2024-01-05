-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1051- CRM
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
SET @FormID = 'CRMF1051';

SET @LanguageValue = N'Update reasons for failure / success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CauseType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason type name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CauseTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1051.LastModifyUserName', @FormID, @LanguageValue, @Language;