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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2140';

SET @LanguageValue = N'Danh mục chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng mail gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bị hủy ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2140.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;

