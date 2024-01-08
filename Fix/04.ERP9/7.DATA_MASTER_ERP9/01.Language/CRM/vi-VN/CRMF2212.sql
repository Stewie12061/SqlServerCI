-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2212- CRM
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
SET @FormID = 'CRMF2212';

SET @LanguageValue = N'Chi tiết dữ liệu ao đầu mối online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsComfirmLead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi Chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết nguồn dữ liệu online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.ThongTinChiTietNguonDuLieuOnline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.NoiDungThongTinNguonDuLieuOnline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.KhachHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DauMoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin trao đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TraoDoiThongTin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã team';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu Ads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LeadName', @FormID, @LanguageValue, @Language;