-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2002 - SO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2002';
SET @LanguageValue = N'Chi tiết đơn hàng bán sỉ (Sell In)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabOT2002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Tel' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Diễn giải cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.NotesDetail' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhân viên giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RouteID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng in';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsPrinted' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người theo dõi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.EmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderStatus' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'ID Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'ID Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Address' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInvoice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyUserID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mức độ khẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ImpactLevel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ExchangeRate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ClassifyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày đáo hạn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DueDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Contact' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DeliveryAddress' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương tiện vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Transport' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentTermID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CurrencyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Disabled' , @FormID, @LanguageValue, @Language;




 
   SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryName' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.UnitID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalePrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Thành tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OriginalAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsPicking' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Kho giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.WareHouseID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Description' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Hoàn tất';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Finish' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá chuẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.StandardPrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'% thuế VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATPercent' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Nhóm thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATGroupID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar03' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar04' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar05' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar06' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar07' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar08' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar09' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.nvarchar10' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 11';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 12';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar02' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 13';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar03' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 14';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar04' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 15';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar05' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 16';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar06' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 17';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar07' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 18';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar08' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 19';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar09' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 20';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Varchar10' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã phân tích 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana01ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana02ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana03ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana04ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana05ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana06ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana07ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana08ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana09ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana10ID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thông tin kinh doanh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RefInfor' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Thông tin đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ThongTinDonHang' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Số lượng cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Parameter01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Parameter02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số tiền cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Parameter03' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Thành tiền quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PriceListID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Hàng khuyến mãi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tiền chiết khấu quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountConvertedAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Phí vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalPayAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TaskName',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tiến độ nhận hàng của đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TienDoNhanHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ giao hàng của đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TienDoGiaoHang', @FormID, @LanguageValue, @Language;
	
SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShippedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RemainAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipStartDate', @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vạch';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ViTriDonHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SA - PG';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana01Name' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana02Name' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana03Name' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'ADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana04Name' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'QLADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalesManName' , @FormID, @LanguageValue, @Language;