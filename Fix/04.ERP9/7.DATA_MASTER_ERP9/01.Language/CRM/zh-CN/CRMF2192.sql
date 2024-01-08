-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2192- CRM
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
SET @FormID = 'CRMF2192';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'短信 戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignSMSID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'短信戰略名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模板的電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件戰略的發送時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模板的電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送短信數/次';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.StatusCampaignSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.StatusCampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成功發送的短信數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMSSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送失敗的短信數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMSFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取消數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySMSUnsubcription', @FormID, @LanguageValue, @Language;

