-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2191- CRM
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
SET @FormID = 'CRMF2191';

SET @LanguageValue = N'Cập nhật chiến dịch SMS';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch SMS';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CampaignSMSID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch SMS';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập thời gian gửi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SMS mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sms gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.QuantitySendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.StatusCampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.QuantitySendSMSSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.QuantitySendSMSFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bị hủy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.QuantitySMSUnsubcription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2191.StatusCampaignSMS', @FormID, @LanguageValue, @Language;

