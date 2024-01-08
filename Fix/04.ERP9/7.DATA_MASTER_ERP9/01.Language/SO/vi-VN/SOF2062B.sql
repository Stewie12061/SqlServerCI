DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2062B'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết phiếu báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InventoryID',  @FormID, @LanguageValue, @Language

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ThongTinPhieuBaoGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabOT2102',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.QuotationStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.SalesManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.OpportunityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành bảo trì';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng báo giá thiết bị chính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ReportQuotation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TabPaymentTerm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ kiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Coefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Factor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.ProfileCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cước vận chuyển Nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InternalShipCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaxImport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hải quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.CustomsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm định thông quan';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.CustomsInspectionCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phí T/T';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TT_Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.LC_Open',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.LC_Receice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảo hành tạm ứng/TTHD/Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.WarrantyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InformType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 1(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaxFactor1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế 2(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaxFactor2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaxCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.GuestsCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.SurveyCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.PlusCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TotalCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InheritNC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa KHCU';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.InheritKHCU',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số tổng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TotalCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.PlusSaleCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số KT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giảm giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.Ana06Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaskName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản được quyền kế thừa màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.UserInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062B.TaskID',  @FormID, @LanguageValue, @Language;
