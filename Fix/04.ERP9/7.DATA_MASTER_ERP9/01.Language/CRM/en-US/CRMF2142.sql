-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2142- CRM
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
SET @FormID = 'CRMF2142';

SET @LanguageValue = N'View email campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Send setting';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email Template';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of sent email/time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.StatusCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of email failure';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancelled quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email campaign infomation';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.ThongTinChiTietChienDichEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TabCRMT00002', @FormID, @LanguageValue, @Language;

