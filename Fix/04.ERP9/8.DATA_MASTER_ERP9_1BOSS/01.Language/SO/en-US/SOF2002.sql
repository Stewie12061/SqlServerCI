-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2002- SO
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
SET @FormID = 'SOF2002';

SET @LanguageValue = N'Sales order view';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order No';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tracking employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order classification';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport vehicle';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'shipping fee ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.UnitID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Sale price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalePrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderQuantity' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATPercent' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RefInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finish';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Finish' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ApprovalDate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ThongTinDonHang' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tasks';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TaskName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive order progress';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TienDoNhanHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery progress';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TienDoGiaoHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.StatusID', @FormID, @LanguageValue, @Language;
