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
SET @FormID = 'CRMF2040'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục chiến dịch marketing'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectOpenDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà tài trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Sponsor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.BudgetCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedRevenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đáp ứng mong đợi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedResponse',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualSales',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoàn vốn thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualROI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày diễn ra';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.PlaceDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatusName',  @FormID, @LanguageValue, @Language;

