DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2122'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết phiếu báo giá Sale'
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VouCherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VouCherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Description',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.InventoryID',  @FormID, @LanguageValue, @Language

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kĩ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin phiếu báo giá Sale';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ThongTinPhieuBaoGiaSale',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.TabSOT2121',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.QuoCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.UnitPriceInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diện tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Area',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưới báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã tạo đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.IsSO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.GhiChu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.DinhKem',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tệp đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.AttachFileName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.Ana01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.ProjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp chống cháy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.FirePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.LengthSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.WithSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.HeightSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lip';
EXEC ERP9AddLanguage @ModuleID, 'SOF2122.LipSize',  @FormID, @LanguageValue, @Language;