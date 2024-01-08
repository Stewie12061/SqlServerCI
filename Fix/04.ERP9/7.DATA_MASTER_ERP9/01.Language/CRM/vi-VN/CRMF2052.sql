DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2052'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết cơ hội'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giai đoạn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày dự kiến kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectedCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác suất thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Rate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thực hiện hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT10001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT20301',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOT2101',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ThongTinCoHoi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ khóa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SalesTagID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động thêm vào lịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsAddCalendar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung thêm vào lịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.EventSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesID',  @FormID, @LanguageValue, @Language;

-- [Bảo Toàn] [Ngày cập nhật: 09/07/2019] [Thêm ngôn ngữ group Dự Án]
SET @LanguageValue  = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOOT2100',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOOT2110' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TaskID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TaskName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PlanStartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PlanEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StepName' , @FormID, @LanguageValue, @Language;

-- [Bảo Toàn] [Ngày cập nhật: 29/07/2019] [Bổ sung group Yêu cầu báo giá]
SET @LanguageValue = N'Yêu cầu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT20801' , @FormID, @LanguageValue, @Language;
--tab yêu cầu mua hàng
SET @LanguageValue  = N'Yêu cầu mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabOT3101',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.VoucherNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OrderStatus', @FormID, @LanguageValue, @Language;

--tab hợp đồng mua
SET @LanguageValue  = N'Hợp đồng mua';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCIFT1360',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OrderStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TaskName2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesName',  @FormID, @LanguageValue, @Language;

-- Tab Sản phẩm
SET @LanguageValue  = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TabCRMT2181',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AmountInventory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Discountamount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TablePriceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TotalPrice',  @FormID, @LanguageValue, @Language;
