-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2190- CRM
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
SET @Language = 'zh-CN'
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2190';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'短信 戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignSMSID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'短信戰略名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模式的短信';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模式的短信';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送短信數/次';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.StatusCampaignSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.StatusCampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成功發送的短信數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMSSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送失敗的短信數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMSFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取消的短信數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySMSUnsubcription', @FormID, @LanguageValue, @Language;

