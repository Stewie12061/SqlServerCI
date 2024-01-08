-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2011- SO
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
SET @Language = 'en-US' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2011';

SET @LanguageValue = N'Update orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Impact Level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales Man';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date due';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transportation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total after tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales discount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'total';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ChooseQuotationSaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.UnitID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Sale price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalePrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OriginalAmount' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.SalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.OrderTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.APKOT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DiscountWalletTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.IsInheritSO_AP', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATPercent' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.RefInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finish';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Finish' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ApprovalDate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.InventoryTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PaymentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.AnaID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Analysis';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.PriceListName.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2011.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.UnitName' , @FormID, @LanguageValue, @Language;
