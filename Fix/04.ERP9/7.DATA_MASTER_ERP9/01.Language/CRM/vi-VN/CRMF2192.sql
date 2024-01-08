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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2192';

SET @LanguageValue = N'Xem chi tiết chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignSMSID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sms gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.ThongTinChiTietChienDichSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi Chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.StatusCampaignSMSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMSSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi sms thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySendSMSFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bị hủy ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2192.QuantitySMSUnsubcription', @FormID, @LanguageValue, @Language;