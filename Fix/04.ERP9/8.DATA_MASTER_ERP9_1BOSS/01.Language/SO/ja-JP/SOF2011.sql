------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2011 - CRM 
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
SET @FormID = 'SOF2011';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DivisionID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Mã chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DivisionID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ShipDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Diễn giải cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.NotesDetail' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhân viên giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATObjectID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.RouteID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng in';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsPrinted' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người theo dõi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.EmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderStatus' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'ID Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ObjectName' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Address' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsInvoice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày sửa';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.LastModifyDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người sửa';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.LastModifyUserID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CreateDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mức độ khẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ImpactLevel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ExchangeRate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ContractNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ContractDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày đáo hạn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DueDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Contact' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DeliveryAddress' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương tiện vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Transport' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATObjectName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Disabled' , @FormID, @LanguageValue, @Language;

 
    SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalesManID' , @FormID, @LanguageValue, @Language;





 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryName' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.UnitID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalePrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Thành tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OriginalAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thành tiền quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ConvertedAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsPicking' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Kho giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.WareHouseID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Description' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Hoàn tất';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Finish' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá chuẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.StandardPrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'% thuế VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATPercent' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Nhóm thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar03' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar04' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar05' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar06' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar07' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar08' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar09' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.nvarchar10' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 11';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 12';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar02' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 13';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar03' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 14';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar04' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 15';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar05' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 16';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar06' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 17';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar07' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 18';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar08' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 19';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar09' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 20';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Varchar10' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thông tin kinh doanh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.RefInfor' , @FormID, @LanguageValue, @Language;



  SET @LanguageValue = N'Mã phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.AnaID.CB' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tên phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.AnaName.CB' , @FormID, @LanguageValue, @Language;
 

  
 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Inventory.Auto' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Parameter01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Parameter02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số tiền cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Parameter03' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupName.CB' , @FormID, @LanguageValue, @Language;
 
 
SET @LanguageValue = N'Bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PriceListID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Doanh số lũy kế tháng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.AccumulaAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Hàng khuyến mãi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tiền chiết khấu quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PriceListName.CB' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Phí vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ShipAmount' , @FormID, @LanguageValue, @Language;
 
 
  SET @LanguageValue = N'Tổng cộng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalAmount' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Giá trị thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PayAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalPayAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Chiết khấu doanh số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountSaleAmountDetail' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Thành tiền trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalBeforeAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thành tiền sau thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalAfterAmount' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Tiền chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;