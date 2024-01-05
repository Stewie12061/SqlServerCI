------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2151 - CRM 
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2151';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật đơn hàng bán lẻ (Sell Out)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật giá trị tham số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2003Title.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DivisionID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Giờ đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderTime' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Mã chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DivisionID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ShipDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 1';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.NotesDetail' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhân viên giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATObjectID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATAccountID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.RouteID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng in';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsPrinted' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người theo dõi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.EmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderStatus' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.AccountName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ObjectName' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Address' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsInvoice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.LastModifyDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.LastModifyUserID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CreateDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mức độ khẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ImpactLevel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryTypeID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryTypeName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ExchangeRate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContractNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContractDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ClassifyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày đáo hạn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DueDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Contact' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryAddress' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương tiện vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Transport' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentTermID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CurrencyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATObjectName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Disabled' , @FormID, @LanguageValue, @Language;

 
    SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tham số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Xem nhanh công nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ViewDebit' , @FormID, @LanguageValue, @Language;


 
 SET @LanguageValue = N'Cho mượn vật tư';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsBorrow' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryName' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.UnitID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalePrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Thành tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OriginalAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thành tiền quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ConvertedAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsPicking' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Kho giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.WareHouseID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Description' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Hoàn tất';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Finish' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Notes01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Notes02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá chuẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.StandardPrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'% thuế VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATPercent' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Nhóm thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATGroupID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar03' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar04' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar05' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar06' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar07' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar08' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar09' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.nvarchar10' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 11';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 12';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar02' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 13';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar03' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 14';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar04' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 15';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar05' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 16';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar06' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 17';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar07' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 18';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar08' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 19';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar09' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 20';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Varchar10' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thông tin kinh doanh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.RefInfor' , @FormID, @LanguageValue, @Language;



  SET @LanguageValue = N'Mã phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.AnaID.CB' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tên phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.AnaName.CB' , @FormID, @LanguageValue, @Language;
 

  
 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryName.Auto' , @FormID, @LanguageValue, @Language;


   SET @LanguageValue = N'Số lượng cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Parameter01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Parameter02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số tiền cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Parameter03' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATGroupName.CB' , @FormID, @LanguageValue, @Language;
 
 
SET @LanguageValue = N'Bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PriceListID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Doanh số lũy kế tháng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.AccumulaAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Hàng khuyến mãi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tiền chiết khấu quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PriceListName.CB' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Loại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TypeName.CB' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Phí vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ShipAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TotalPayAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Chọn phiếu báo giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ChooseQuotationID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 1';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 2';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 3';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 4';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 5';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 6';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 7';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 8';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 9';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 10';
EXEC ERP9AddLanguage @ModuleID, 'nvarchar10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng bán từ App Mobile';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Choose_app',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Danh_sach_mat_hang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsInheritPO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.UnitName.CB',  @FormID, @LanguageValue, @Language;
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TaskName',  @FormID, @LanguageValue, @Language;

 ---[ĐÌnh Hoà] [27/06/2020] Thêm ngôn ngữ
SET @LanguageValue = N'Số tiền đã thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TotalAfterAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ShipStartDate' , @FormID, @LanguageValue, @Language;

---[Trọng Kiên] [25/11/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Nhân viên bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana02Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana03Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana04Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana05Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana01ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana02ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana02Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana03ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana03Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana04ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana04Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana05ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana05Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giao hàng và thu tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền phải thu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn phiếu báo giá Sale(BPKD)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ChooseQuotationSaleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DealerID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đại lý'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DealerID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đại lý'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DealerName.CB',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Mã vạch'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContactorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.WareHouseIDOTT02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn kho thực tế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.EndQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hàng đang về'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hàng giữ chỗ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn kho sẵn sàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ReadyQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TabOT2002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TabOTT2002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ChooseOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryAddressID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryAddressName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khuyến mãi'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PromoteIDList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng số tiền bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ItemTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền VAT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền còn lại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsExportOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsWholeSale' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền ví tích lũy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountWalletTotal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.RetailPrice' , @FormID, @LanguageValue, @Language;