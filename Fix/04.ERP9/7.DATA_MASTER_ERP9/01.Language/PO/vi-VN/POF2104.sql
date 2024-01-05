------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2104 - CRM 
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2104';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Kế thừa thông tin vận chuyển';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Giờ đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.VoucherDate' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.VoucherTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Nhà cung cấp';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.ObjectName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Đơn hàng mua';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.POrderID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số lượng tổng';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.OrderQuantity' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Số hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.InvoiceNo' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã đơn vận';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.BillOfLadingNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.InventoryID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Tên hàng';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.InventoryName' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.UnitID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số lượng đã kế thừa';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.InheritQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Số lượng còn lại';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.RemainQuantity' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.ObjectID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.ObjectName.CB' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Số lượng đã kế thừa';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.InheritQuantity' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Đơn giá';
 EXEC ERP9AddLanguage @ModuleID, 'POF2104.PurchasePrice' , @FormID, @LanguageValue, @Language;