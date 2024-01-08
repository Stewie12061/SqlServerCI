﻿-----------------------------------------------------------------------------------------------------
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2140';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件活動代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件活動名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模板的電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'營銷戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收件人組';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模板的電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發送郵件數/次';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.StatusCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成功郵寄數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'失敗的郵件數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取消數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;

