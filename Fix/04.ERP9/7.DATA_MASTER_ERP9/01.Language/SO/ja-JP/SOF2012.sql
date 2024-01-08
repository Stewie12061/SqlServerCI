------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2012 - CRM 
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
SET @Language = 'ja-JP';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2012';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chi tiết đơn hàng bán nhà phân phối';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Title' , @FormID, @LanguageValue, @Language;
 SET @LanguageValue = N'Chi tiết';
 EXEC ERP9AddLanguage @ModuleID, 'TabOT2002' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Xem chi tiết đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ThongTinDonHangNhaPhanPhoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ShipDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Diễn giải cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.NotesDetail' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhân viên giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATObjectID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VoucherTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.RouteID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng in';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsPrinted' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người lập phiếu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.EmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderStatus' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'ID Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ObjectName' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Address' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsInvoice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày sửa';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.LastModifyDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người sửa';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.LastModifyUserID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CreateDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mức độ khẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ImpactLevel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ExchangeRate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ContractNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ContractDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ClassifyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày đáo hạn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DueDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Contact' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DeliveryAddress' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương tiện vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Transport' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PaymentTermID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PaymentID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CurrencyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATObjectName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Disabled' , @FormID, @LanguageValue, @Language;




 
   SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryName' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.UnitID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.SalePrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Thành tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OriginalAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsPicking' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Kho giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.WareHouseID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Description' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Hoàn tất';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Finish' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá chuẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.StandardPrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'% thuế VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATPercent' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Nhóm thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATGroupID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar03' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar04' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar05' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar06' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar07' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar08' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar09' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.nvarchar10' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 11';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 12';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar02' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 13';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar03' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 14';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar04' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 15';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar05' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 16';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar06' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 17';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar07' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 18';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar08' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 19';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar09' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 20';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Varchar10' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã phân tích 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana01ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana02ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana03ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana04ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana05ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana06ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana07ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana08ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana09ID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã phân tích 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana10ID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thông tin kinh doanh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.RefInfor' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Thông tin đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ThongTinDonHang' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Số lượng cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Parameter01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Parameter02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số tiền cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Parameter03' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Thành tiền quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ConvertedAmount' , @FormID, @LanguageValue, @Language;




SET @LanguageValue = N'Bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PriceListID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Hàng khuyến mãi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tiền chiết khấu quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountConvertedAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Phí vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ShipAmount' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Tổng cộng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalAmount' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Giá trị thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PayAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalPayAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Chiết khấu doanh số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountSaleAmountDetail' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thành tiền trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalBeforeAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thành tiền sau thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalAfterAmount' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Tiền chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;