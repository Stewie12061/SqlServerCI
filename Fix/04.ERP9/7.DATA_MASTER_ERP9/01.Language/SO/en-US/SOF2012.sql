-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2012- SO
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
SET @FormID = 'SOF2012';

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Impact Level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales Man';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total after tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales discount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis 4';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis 5';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.InventoryName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.UnitID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Sale price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.SalePrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATPercent' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.RefInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finish';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Finish' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ApprovalDate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details of sales orders for distributors';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'TabOT2002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales orders for distributors info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2012.ThongTinDonHangNhaPhanPhoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.UnitName' , @FormID, @LanguageValue, @Language;