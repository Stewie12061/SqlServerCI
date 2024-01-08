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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2141';

SET @LanguageValue = N'Cập nhật chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập thời gian gửi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng mail gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bị hủy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2141.StatusCampaignEmail', @FormID, @LanguageValue, @Language;

