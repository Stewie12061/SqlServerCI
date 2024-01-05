DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2002'
---------------------------------------------------------------




SET @LanguageValue  = N'Xem chi tiết đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PurchaseManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PriceListName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LastModifyUserDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.IsPicking',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinDonHangMua',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabOT3002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Attacth.GR'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabOT3006',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PlanName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hàng kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PlanReceivingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.AmountPlan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ReceivingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch nhận hàng';
EXEC ERP9AddLanguage '00', 'A00.ProcessReceive',  'A00', @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn tất';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Finish' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ApprovalNotes'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt của người'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ApprovalDate'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.APKMaster_9000'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ApprovingLevel'  ,@FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.StatusID', @FormID, @LanguageValue, @Language;

--==============================================================

-- Thêm ngôn ngữ cho table OT3007 by Minh Hiếu

SET @LanguageValue = N'Thông tin vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TabOT3007', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng container'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.QuantityContainer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InvoiceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vận đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.BillOfLadingNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn thông quan'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ClearanceExpirationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu chạy'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DepartureDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ArrivalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DateFreeCont',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu bãi'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DateFreePlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thanh toán tiền hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PaymentDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hồ sơ đăng ký chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CRMajorsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số giấy đăng chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CRMajorsNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lấy mẫu kiểm tra chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DateInspection',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.LegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng nhận hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CertificateLegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng thư'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.CertificateNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kéo cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.TowingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lấy mẫu kiểm tra chuyên ngành';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';

EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinChiPhi', @FormID, @LanguageValue, @Language;


-- Thêm ngôn ngữ cho table OT3011 by Đình Định
SET @LanguageValue = N'Thông tin tiến độ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Tiendonhanhang', @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên mặt hàng ';
 EXEC ERP9AddLanguage @ModuleID, 'POF2002.InventoryName' , @FormID, @LanguageValue, @Language;


 SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Date', @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'POF2002.OrderQuantity' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Số lượng (DVT chuẩn)';
 EXEC ERP9AddLanguage @ModuleID, 'POF2002.ConvertedQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Còn lại';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã giao';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ShippedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng giao';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ShippedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 4';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 5';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 6';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 7';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 8';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 9';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 10';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 11';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 12';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 13';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 14';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 16';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 17';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 18';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 19';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 20';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 21';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 22';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 23';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 24';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 25';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 26';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 27';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 28';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 29';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày 30';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.Quantity30', @FormID, @LanguageValue, @Language;
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinChiPhi', @FormID, @LanguageValue, @Language;
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinChiPhi', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiếu khấu'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.DiscountOriginalAmount',  @FormID, @LanguageValue, @Language;

-- Thêm ngôn ngữ cho table OT3010
SET @LanguageValue = N'Thông tin chi phí';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ThongTinChiPhi', @FormID, @LanguageValue, @Language;

-- Modified by Viết Toàn on 09/03/2023: Thêm ngôn ngữ cho table OT3002

SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2002.ReceivedDate', @FormID, @LanguageValue, @Language;

-- Hoàng Long - 13/09/2023 : Bổ sung trường số PO
SET @LanguageValue  = N'Số PO'
EXEC ERP9AddLanguage @ModuleID, 'POF2002.PONumber',  @FormID, @LanguageValue, @Language;