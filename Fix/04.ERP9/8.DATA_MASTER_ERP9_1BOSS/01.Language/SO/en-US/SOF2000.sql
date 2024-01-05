-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2000- SO
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
SET @FormID = 'SOF2000';


SET @LanguageValue = N'Sales order list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tracking employee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery with invoice';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency level';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order classification';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport vehicle';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2000.ReceiveAmount', @FormID, @LanguageValue, @Language;

