DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2051'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giai đoạn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.ExpectAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày dự kiến kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.ExpectedCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác suất thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Rate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thực hiện hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ khóa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SalesTagID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lý do';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lý do';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn gốc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn gốc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động thêm vào lịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.IsAddCalendar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung thêm vào lịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.EventSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.TaskName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionName',  @FormID, @LanguageValue, @Language;