------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2144 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'M';
SET @FormID = 'MF2144';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật giá trị tham số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2003Title.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ShipDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.NotesDetail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.RouteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng in';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsPrinted' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ObjectName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao hàng kèm hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức độ khẩn';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ImpactLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ExchangeRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ContractDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đáo hạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DueDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Contact' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Disabled' , @FormID, @LanguageValue, @Language;

 
SET @LanguageValue = N'Người bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.SalesManID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Varchar' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem nhanh công nợ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ViewDebit' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Cho mượn vật tư';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsBorrow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.InventoryID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.InventoryName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.UnitID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.SalePrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ConvertedAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsPicking' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Description' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Hoàn tất';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Finish' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Ghi chú 01';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Notes01' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Ghi chú 02';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Notes02' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Đơn giá chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.StandardPrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATPercent' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thông tin kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.RefInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Parameter01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Parameter02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Parameter03' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.PriceListID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Doanh số lũy kế tháng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.AccumulaAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ShipAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.TaskName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền đã thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.TotalAfterAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ShipStartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giao hàng và thu tiền'
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền phải thu'
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bán sỉ'
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsWholeSale',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'MF2144.UnitName',  @FormID, @LanguageValue, @Language;
