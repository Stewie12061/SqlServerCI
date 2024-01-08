DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2050'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giai đoạn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CauseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày dự kiến kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectedCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác suất thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Rate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thực hiện hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LeadName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionName',  @FormID, @LanguageValue, @Language;