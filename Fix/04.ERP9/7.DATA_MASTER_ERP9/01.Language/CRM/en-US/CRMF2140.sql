-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2140- CRM
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
SET @FormID = 'CRMF2140';

SET @LanguageValue = N'List of email campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Send setting';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of sent email/time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.StatusCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email failure';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancelled quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;