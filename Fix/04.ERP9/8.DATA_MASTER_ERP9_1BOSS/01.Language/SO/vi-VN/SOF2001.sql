------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2001 - CRM 
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
SET @FormID = 'SOF2001';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật đơn hàng bán sỉ (Sell In)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật giá trị tham số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2003Title.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DivisionID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Giờ đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderTime' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Mã chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DivisionID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ShipDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 1';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.NotesDetail' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhân viên giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATObjectID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATAccountID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.RouteID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng in';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsPrinted' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người theo dõi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.EmployeeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderStatus' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AccountName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ObjectName' , @FormID, @LanguageValue, @Language;


  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Address' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsInvoice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.LastModifyDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người cập nhật';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.LastModifyUserID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CreateDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mức độ khẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ImpactLevel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ExchangeRate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContractNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContractDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên PL đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày đáo hạn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DueDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Contact' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryAddress' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương tiện vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Transport' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentID.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên phương thức thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentName.CB' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Khách hàng VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATObjectName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Disabled' , @FormID, @LanguageValue, @Language;

 
    SET @LanguageValue = N'Người bán hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SalesManID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tham số';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Xem nhanh công nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ViewDebit' , @FormID, @LanguageValue, @Language;


 
 SET @LanguageValue = N'Cho mượn vật tư';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsBorrow' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryName' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SalePrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Thành tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OriginalAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thành tiền quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ConvertedAmount' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsPicking' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Kho giữ chỗ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.WareHouseID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Description' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Hoàn tất';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Finish' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Ghi chú 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Đơn giá chuẩn';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.StandardPrice' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'% thuế VAT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATPercent' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Nhóm thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATGroupID' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 01';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 02';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar02' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 03';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar03' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 04';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar04' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 05';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar05' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 06';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar06' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 07';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar07' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 08';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar08' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 09';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar09' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.nvarchar10' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 11';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar01' , @FormID, @LanguageValue, @Language;
 
   SET @LanguageValue = N'Tham số 12';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar02' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 13';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar03' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 14';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar04' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 15';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar05' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 16';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar06' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 17';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar07' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 18';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar08' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 19';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar09' , @FormID, @LanguageValue, @Language;
  
   SET @LanguageValue = N'Tham số 20';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Varchar10' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Thông tin kinh doanh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.RefInfor' , @FormID, @LanguageValue, @Language;



  SET @LanguageValue = N'Mã phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AnaID.CB' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tên phân tích';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AnaName.CB' , @FormID, @LanguageValue, @Language;
 

  
 SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryName.Auto' , @FormID, @LanguageValue, @Language;


   SET @LanguageValue = N'Số lượng cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Parameter01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Parameter02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số tiền cọc, nợ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Parameter03' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên nhóm';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATGroupName.CB' , @FormID, @LanguageValue, @Language;
 
 
SET @LanguageValue = N'Bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PriceListID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Doanh số lũy kế tháng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AccumulaAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Hàng khuyến mãi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsProInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền chiết khấu nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountOriginalAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Tiền chiết khấu quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountConvertedAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã bảng giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PriceListName.CB' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Loại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TypeName.CB' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số tiền được hưởng chiết khấu DS';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountSalesAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'% chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountPercentSOrder' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Giá trị chiết khấu';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountAmountSOrder' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Phí vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ShipAmount' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá trị trước thuế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TotalUnVATAmount' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Số tiền thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TotalPayAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Chọn phiếu báo giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ChooseQuotationID' , @FormID, @LanguageValue, @Language;

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
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Choose_app',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Danh_sach_mat_hang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng mua';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsInheritPO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitName.CB',  @FormID, @LanguageValue, @Language;
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TaskName',  @FormID, @LanguageValue, @Language;

 ---[ĐÌnh Hoà] [27/06/2020] Thêm ngôn ngữ
SET @LanguageValue = N'Số tiền đã thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TotalAfterAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PayAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tàu chạy';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ShipStartDate' , @FormID, @LanguageValue, @Language;

---[Trọng Kiên] [25/11/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Nhân viên bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana02Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 03'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana03Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 04'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana04Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 05'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana05Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana01ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana01Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana02ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana02Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana03ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana03Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana04ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana04Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana05ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana05Name.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giao hàng và thu tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền phải thu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ReceiveAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn phiếu báo giá Sale(BPKD)'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ChooseQuotationSaleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vạch'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContactorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.WareHouseIDOTT02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn kho thực tế'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.EndQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hàng đang về'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hàng giữ chỗ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tồn kho sẵn sàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ReadyQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TabOT2002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TabOTT2002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ChooseOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryAddressID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên địa chỉ giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryAddressName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khuyến mãi'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PromoteIDList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng số tiền bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ItemTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền chiết khấu'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền VAT'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền còn lại'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderTotal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountAmount' , @FormID, @LanguageValue, @Language;