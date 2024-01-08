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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2190';

SET @LanguageValue = N'Danh mục chiến dịch SMS';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignSMSID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sms gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.StatusCampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMSSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySendSMSFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sms bị hủy ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2190.QuantitySMSUnsubcription', @FormID, @LanguageValue, @Language;

