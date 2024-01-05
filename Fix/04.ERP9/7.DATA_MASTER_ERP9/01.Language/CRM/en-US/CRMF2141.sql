-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2141- CRM
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
SET @FormID = 'CRMF2141';

SET @LanguageValue = N'Update email campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Send setting';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of sent email/time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.StatusCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email failure';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancelled quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;

