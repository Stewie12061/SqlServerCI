DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2023A'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa phiếu báo giá (Sale)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.ExchangeRate',  @FormID, @LanguageValue, @Language;

-- Đình Hoà [23/08/2021]
-- Xoá mã VoucherNo để thay thế VouCherNo(Cho các DB đã chay fix này trc đó)
DELETE A00001 where ID = 'SOF2023A.VoucherNo'
SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VouCherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VouCherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Attention1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Attention2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Dear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương tiện vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Transport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.PriceListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.InventoryType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'kế thừa phiéu báo gía (Kĩ thuật)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.IsInheritTPQ',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn danh sách mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.lblBtnInventoryList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kĩ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.QuoCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá vốn/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.UnitPriceInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diện tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Area',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.OrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.ConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Qui đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATOriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.VATConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã tạo đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.IsSO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp chống cháy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.FirePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.LengthSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.WithSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kích thước cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.HeightSize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lip';
EXEC ERP9AddLanguage @ModuleID, 'SOF2023A.LipSize',  @FormID, @LanguageValue, @Language;