-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2061B- SO
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
SET @FormID = 'SOF2061B';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation maker';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment conditions';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transportation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the purchase request';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit supplier quotes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of Science and Technology';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation Type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coefficient';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value plus (multiplier)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'rose';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Internal freight';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import Tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs fees';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs inspection';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'T/T fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'L / C issue';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance warranty/Contract advance/Warranty';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax 1(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax 2(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reception';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Survey';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value added';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total coefficient';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritBoardPricing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InheritOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061B.OrderTotal', @FormID, @LanguageValue, @Language;

