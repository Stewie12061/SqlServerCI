DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2035'
---------------------------------------------------------------

SET @LanguageValue  = N'Mở ca bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền quỹ đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.BeginAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.InvoiceNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số cuống thẻ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.CardStubsNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số cuống Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.VoucherStubsNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.EmployeeID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm đếm tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'TabPOSFT20351',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.FaceValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm kê kho';
EXEC ERP9AddLanguage @ModuleID, 'TabPOSFT20352',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng tồn đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.BeginQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhập trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ImQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng khách trả trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ReturnQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ExQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng hàng chuyển trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.MovedQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng tồn cuối ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.EndQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ShiftDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.OpenTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.CloseTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lấy từ số bàn giao của ca trước';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.IsFromShift',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên nhận bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.EmployeeID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ca bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.ShiftID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ca bán hàng đã đóng. Bạn vui lòng tạo ca mới!';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Message1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bạn có muốn tiếp tục ca {0} từ {1} đến {2}?';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Message2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Orders',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cửa hàng chưa tạo ca bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2035.Message3',  @FormID, @LanguageValue, @Language;