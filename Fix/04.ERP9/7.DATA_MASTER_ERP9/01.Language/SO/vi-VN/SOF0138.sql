------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0138 - CRM 
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
SET @FormID = 'SOF0138';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Kế thừa đơn hàng mua';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Giờ đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OrderDate' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VoucherTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Mã đối tượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Loại tiền';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tỷ giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ExchangeRate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryTypeID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tình trạng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OrderStatus' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tình trạng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OrderStatusName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số hợp đồng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ContracNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ngày ký';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ContractDate' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Description' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryName' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.UnitID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedSalePrice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số lượng đã kế thừa (ĐVT chuẩn)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InheritQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số lượng còn lại (ĐVT chuẩn)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.RemainQuantity' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Đơn giá(ĐVT chuẩn)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.PurchasePrice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OriginalAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'% Thuế GTGT';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATPercent' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Thuế GTGT nguyên tệ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Thuế GTGT quy đổi';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 1';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 2';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 3';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 4';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes03' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú 5';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes04' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Ghi chú 6';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes05' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Ghi chú 7';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes06' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Ghi chú 8';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes07' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Ghi chú 9';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes08' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Ghi chú 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes09' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectName.CB' , @FormID, @LanguageValue, @Language;

     SET @LanguageValue = N'Mã';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyName.CB' , @FormID, @LanguageValue, @Language;