-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2001- SO
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
SET @FormID = 'SOF2001';

SET @LanguageValue = N'Update sales order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order No';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tracking employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order classification';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Due date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport vehicle';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paid';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping fee ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Select Sales quotation (Sales Department)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ChooseQuotationSaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATPercent' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.SalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.OrderTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.APKOT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DiscountWalletTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.IsInheritSO_AP', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'VAT converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business info';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.RefInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finish';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Finish' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ApprovalDate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.InventoryTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ClassifyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PaymentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AnaID.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Analysis';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.PriceListName.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.UnitPrice.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inherit Purchare Order'
EXEC ERP9AddLanguage @ModuleID, 'SOF2001.ChooseOrder',  @FormID, @LanguageValue, @Language;