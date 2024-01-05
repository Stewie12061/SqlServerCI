-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2020- SO
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
SET @FormID = 'SOF2020';


SET @LanguageValue = N'List of quotations';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee provide quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation NO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dear';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transport vehicle';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of supplier quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of project';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.InheritBoardPricing', @FormID, @LanguageValue, @Language;

--- ĐÌnh Hòa - 06/07/2021 : Bổ sung ngôn ngữ cho Phiếu in Báo giá
SET @LanguageValue  = N'BALLOT QUOTES'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.QuotesReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'We are pleased to offer you goods with the following terms and conditions :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title1Report',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'We are looking forward to the support of our customers for our company products.'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.Title2Report',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Pay :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PayReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note :'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.NoteReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Best regards!'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.BestRegardsReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'DIRECTOR'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DirectorReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Telephone'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.TelephoneReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher No'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.VoucherNoReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Date'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DateReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.FromReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.ToReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.NameReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Company'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.CompanyReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.EmailReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.AddressReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.FaxReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.DescriptionReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kind of paper'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.KindOfPaperReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Paper label'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PaperLabelReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.AmountReport',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price'
EXEC ERP9AddLanguage @ModuleID, 'SOF2020.PriceReport',  @FormID, @LanguageValue, @Language;

