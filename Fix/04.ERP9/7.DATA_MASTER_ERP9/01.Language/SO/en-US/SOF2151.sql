-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2151- SO
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
SET @FormID = 'SOF2151';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Urgency level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order PL';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date due';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transportation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The amount paid';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount to enjoy sales discount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit purchase orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Authorized dealer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery and collection';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Select Sales quotation (Sales Department)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ChooseQuotationSaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.SalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.OrderTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount due';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.APKOT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.DiscountWalletTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2151.IsInheritSO_AP', @FormID, @LanguageValue, @Language;

