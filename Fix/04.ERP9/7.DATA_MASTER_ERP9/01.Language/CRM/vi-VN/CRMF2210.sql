-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2210- CRM
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
SET @FormID = 'CRMF2210';

SET @LanguageValue = N'Danh sách ao đầu mối online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Được chuyển thành đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trao đổi thông tin khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TraoDoiThongTin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã team';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu Ads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LeadName', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Ladipage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Link', @FormID, @LanguageValue, @Language;
