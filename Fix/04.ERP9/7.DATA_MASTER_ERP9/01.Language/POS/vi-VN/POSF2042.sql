DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2042'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết chốt ca bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Group01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng số hóa đơn trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysInvoiceNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu chuyển khoản';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysTransferAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi nợ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysCreditAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thu nợ tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysDebitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thu nợ chuyển khoản';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysDebitTransferAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt cọc tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysBookAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt cọc chuyển khoản';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.SysBookTransferAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền mặt thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.TotalCashAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Group02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền quỹ đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.BeginAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền quỹ cuối ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.CloseAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.RealAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chênh lệch';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.DeviationAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.IsReal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sổ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.IsSys',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.InvoiceNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số cuống thẻ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.CardStubsNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số cuống Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.VoucherStubsNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.EmployeeID1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.FaceValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng tồn đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.BeginQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhập trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.ImQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng khách trả trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.ReturnQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng bán trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.ExQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng hàng chuyển trong ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.MovedQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng tồn cuối ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.EndQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.Orders',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm đếm tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.TabCashCounting',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kiểm kê kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.TabCheckStore',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bàn giao theo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.IsHandoverType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'POSF2042.LastModifyDate',  @FormID, @LanguageValue, @Language;





