------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1001 - POS
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF1001';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Update event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ShopName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'CustomerID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DisabledEvent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EventBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.GeneralInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commondity information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CommodityInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employees of event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeesOfEventTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billing information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.BillingInformation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by price column';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PriceColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is selling by price column';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is selling by price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is selling by package price';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPackage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by promote price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PromotePriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promote';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PromoteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch store';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ComWarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selected';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Selected' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.TaxDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.TaxCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiving Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salling return voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse checklist voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diaries voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal for return of goods voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Difference voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal for internal transportation voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Internal transportation voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billing of exchange';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory balance voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType13' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receipts voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType14' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deposit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType16' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request an invoice voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType17' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request delivery voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType18' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType19' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General journal entry voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherType20' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsPromote' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table price ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table price name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.FromDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.ToDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table price ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table price name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PackagePriceName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.BeginDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.EndDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.WareHouseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax account information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitInfor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Return inventory account information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.PayBillInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billing account information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.DebitInfor2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account information costs';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.CostBillInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice promotion';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.InvoicePromotionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply';
EXEC ERP9AddLanguage @ModuleID, 'POSF1001.IsInvoicePromotionID' , @FormID, @LanguageValue, @Language;