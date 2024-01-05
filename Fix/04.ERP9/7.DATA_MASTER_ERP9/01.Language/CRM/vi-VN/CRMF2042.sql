---Modify by Thị Phượng Date 05/05/2017, chỉnh sửa ngôn ngữ 
DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2042'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết chiến dịch marketing'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectOpenDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà tài trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Sponsor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BudgetCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedRevenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đáp ứng mong đợi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedResponse',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualRevenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ThongTinChiTietChienDich',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch/Mục tiêu (KH) và Thực tế (TT)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.KyVongThucTe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20301',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20501',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT10301',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày diễn ra';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.PlaceDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Age',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí địa lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Position',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'hành vi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Behavior',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí/Leads KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leader tham dự KH';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ tham dự KH(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí/Leads TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leader tham dự TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ tham dự TT(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads tham dự từ chiến dịch trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsPreviousActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionTargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu tham dự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết chuyển đổi kế hoạch/mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.MucTieuChuyenDoi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChienDichEmail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionActualName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionRateActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham dự thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết chuyển đổi thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChiTietChuyenDoiThucTe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads đúng chân dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadPortrait',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ đúng chân dung(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadPortraitRate',  @FormID, @LanguageValue, @Language;
