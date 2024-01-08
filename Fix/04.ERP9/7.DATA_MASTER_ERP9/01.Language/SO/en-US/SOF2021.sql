-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2021- SO
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
SET @FormID = 'SOF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update quotations';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee provide quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dear';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport vehicle';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 4';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 5';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 6';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 7';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 8';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 9';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of supplier quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of project';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritBoardPricing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total VAT amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderTotal', @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuoQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit Price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coefficient';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Coefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT oringinal';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATOrginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT converted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATConvertAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Guarantee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ChooseGuarantee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Assessory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ChooseAccessory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Approval Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price list'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT group'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analysis'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Standard'
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.UnitPrice.CB',  @FormID, @LanguageValue, @Language;
