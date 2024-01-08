DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2032'
---------------------------------------------------------------
SET @LanguageValue  = N'Xem chi tiết yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Master.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Detail.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Attacth.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Notes.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.History.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ ưu tiên'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.PriorityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ContractDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.CurrencyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ExchangeRate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ReceivedAddress'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Transport'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức TT'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.PaymentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.OrderStatusName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.InventoryTypeName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đáo hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.DueDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Description'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.InventoryName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.QuantityInStock'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.RequestPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.OriginalAmount'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VATGroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế suất'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT NT'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VATOriginalAmount'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuể GTGT QĐ'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.CreateDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.CreateUserID'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.LastModifyUserID'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.LastModifyDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu mua hàng'
EXEC ERP9AddLanguage '00', 'A00.OT3101'  ,'A00', @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết yêu cầu mua hàng'
EXEC ERP9AddLanguage '00', 'A00.OT3102'  ,'A00', @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Status'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ApprovalNotes'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt của người'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.ApprovalDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Specification'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.RequestName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.TaskName'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản được quyền kế thừa màn hình'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.UserInherit'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'POF2032.TaskID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'POF2032.Ana06Name',  @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF2032.StatusID', @FormID, @LanguageValue, @Language;

-- Hoàng Long - 11/08/2023 : Bổ sung trường phòng ban
SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.DepartmentName',  @FormID, @LanguageValue, @Language;

-- Hoàng Long - 13/09/2023 : Bổ sung trường số PO
SET @LanguageValue  = N'Số PO'
EXEC ERP9AddLanguage @ModuleID, 'POF2032.PONumber',  @FormID, @LanguageValue, @Language;