-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2001- PO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US ' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2001';

SET @LanguageValue  = N'Update purchase order'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order classification';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier code';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping method';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date due';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Ana10ID', @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house name'
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due day';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DueDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Picking';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsPicking' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ware house';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsConfirm01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ConfDescription02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchasing staff';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PurchaseManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the purchasing plan';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsInheritPP', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the purchase request';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ReceivingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit supplier quotes';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit sales orders';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.Departure', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Line up day';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PLU';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.APKOT3003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost of goods';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'total';
EXEC ERP9AddLanguage @ModuleID, 'POF2001.OrderTotal', @FormID, @LanguageValue, @Language;

