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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2142';

SET @LanguageValue = N'Xem chi tiết chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignMailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignMailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TemplateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TimeSendCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.TemplateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng mail gửi/lần';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chiến dịch mail';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.ThongTinChiTietChienDichEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi Chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.StatusCampaignEmailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmailSucceed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng gửi mail thất bại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantitySendEmailFail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bị hủy ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2142.QuantityEmailUnsubcription', @FormID, @LanguageValue, @Language;