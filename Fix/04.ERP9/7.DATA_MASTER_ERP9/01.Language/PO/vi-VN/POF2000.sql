DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2000'
---------------------------------------------------------------
SET @LanguageValue  = N'Theo thời gian tàu đi'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.DepartureDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo thời gian tàu đi'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Departure',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo tên sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo số Bill of lading'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.BillOfLadingNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo số Invoice'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InvoiceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo thời gian tàu đi'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.DepartureDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo thời gian tàu đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ArrivalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ContractNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ContractDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PurchaseManID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.PurchasePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.LastModifyUserDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ReceivingStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.OrderStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2000.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.IsExportOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng giá trị đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2000.TotalAmount',  @FormID, @LanguageValue, @Language;