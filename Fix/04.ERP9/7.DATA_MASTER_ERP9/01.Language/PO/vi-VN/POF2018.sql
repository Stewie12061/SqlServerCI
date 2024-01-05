DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2018'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật đơn đặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ContactPerson',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ContactPersonTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.DeliverAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DVT'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OrderPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cọc'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.DepositNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền cọc'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.DepositAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền cọc quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.DepositConAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng theo tiến độ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ScheduleDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OrderStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.OrderStatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ObjectName1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2018.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2018.Danh_sach_mat_hang',  @FormID, @LanguageValue, @Language;