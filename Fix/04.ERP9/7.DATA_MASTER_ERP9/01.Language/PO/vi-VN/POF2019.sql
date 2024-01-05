DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2019'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem thông tin đơn đặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ContactPerson',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ContactPersonTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DeliverAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác nhận tiến độ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DVT'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cọc'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DepositNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền cọc'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DepositAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền cọc quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DepositConAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng theo tiến độ'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ScheduleDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác nhận tiến độ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác nhận tiến độ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.TabThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.TabThongTinChiTiet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2019.LastModifyDate',  @FormID, @LanguageValue, @Language;