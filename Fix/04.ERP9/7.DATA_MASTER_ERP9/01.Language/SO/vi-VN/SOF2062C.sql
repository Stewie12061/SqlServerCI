DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2062C'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết phiếu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InventoryID',  @FormID, @LanguageValue, @Language

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ThongTinPhieuBaoGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabOT2102',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng báo giá thiết bị chính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ReportQuotation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TabPaymentTerm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Coefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Factor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ProfileCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cước vận chuyển Nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InternalShipCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxImport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hải quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CustomsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm định thông quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CustomsInspectionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí T/T';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TT_Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LC_Open',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LC_Receice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành tạm ứng/TTHD/Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.WarrantyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InformType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxFactor1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxFactor2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.GuestsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SurveyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PlusCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TotalCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritNC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa KHCU';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritKHCU',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số tổng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TotalCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số KT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana06Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaskName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản được quyền kế thừa màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.UserInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaskID',  @FormID, @LanguageValue, @Language;
