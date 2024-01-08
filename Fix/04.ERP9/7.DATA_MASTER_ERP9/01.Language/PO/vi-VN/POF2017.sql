DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2017'
---------------------------------------------------------------

SET @LanguageValue  = N'Đơn đặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày GH theo tiến độ'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ScheduleFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ScheduleToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày GH theo yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.RequireFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.RequireToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ContactPersonTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.DeliverAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ContactName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatusName.CB',  @FormID, @LanguageValue, @Language;

