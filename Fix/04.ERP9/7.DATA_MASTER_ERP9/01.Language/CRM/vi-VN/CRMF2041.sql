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
SET @FormID = 'CRMF2041'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chiến dịch marketing'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectOpenDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà tài trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Sponsor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BudgetCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedRevenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualRevenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đáp ứng mong đợi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedResponse',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ThongTinChiTiet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kỳ vọng và thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.KyVongThucTe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày diễn ra';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.PlaceDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leader tham dự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ tham dự(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leader tham dự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ tham dự(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Age',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí địa lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Position',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành vi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Behavior',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Inventoryname',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà tài trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.SponsorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch/Mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.KeHoachMucTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ThucTe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nghành nghề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads tham dự từ chiến dịch trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsPreviousActual',  @FormID, @LanguageValue, @Language

SET @LanguageValue  = N'Tên mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionTargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads tham dự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendTarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.MucTieuChuyenDoi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionActualName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionRateActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads tham dự';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendActual',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Leads đúng chân dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadPortrait',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉ lệ đúng chân dung(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadPortraitRate',  @FormID, @LanguageValue, @Language;
