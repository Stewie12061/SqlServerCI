-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2062C- so
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
SET @ModuleID = 'so';
SET @FormID = 'SOF2062C';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation maker';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment conditions';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transportation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quote Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of NC';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of Science and Technology';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation Type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coefficient';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value added';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Internal freight';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import Tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs fees';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs inspection';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'T/T fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'L / C issue';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive L/C';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance warranty/Contract advance/Warranty';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reception';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Survey';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application fee';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total coefficient';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritBoardPricing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InheritOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2062C.OrderTotal', @FormID, @LanguageValue, @Language;

