------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1002 - POS
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
SET @FormID = 'POSF1002';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'View event detail';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DisabledEvent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EventBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.GeneralInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commodity information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CommodityInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employees of event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeesOfEventTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billing information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.BillingInformation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type information';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherInformationTab' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by price column';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PriceColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is selling by price column';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.IsColumn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is selling by price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PackagePriceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.IsPackage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling by promote price table';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PromotePriceTable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promote';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PromoteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch store';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.ComWarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selected';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.Selected' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account (tax)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TaxDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account (tax)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TaxCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account (return inventory)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PayDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account (return inventory)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.PayCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account (billing)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account (billing)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax debt account (cost)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CostDebitAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax credit account (cost)';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CostCreditAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receiving Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Salling return voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse checklist voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling Voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diaries voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal for return of goods voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Difference voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposal for internal transportation voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Internal transportation voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Billing of exchange';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory balance voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType13' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receipts voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType14' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deposit voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType16' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request an invoice voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType17' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request delivery voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType18' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType19' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General journal entry voucher';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.VoucherType20' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF1002.LastModifyUserID' , @FormID, @LanguageValue, @Language;
