-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1151- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1151';

SET @LanguageValue = N'Update object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trademark';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Haunt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transaction currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt age limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lock (Stop Selling)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receivable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of discount days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Charter capital';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used electronic invoice';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUsedEInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Electronic invoice object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.EInvoiceObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery CountryID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery Postal Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryPostalCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryDistrictID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery Ward';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryWard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Add';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnAddDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnCleanDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AddressMTH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnUpdateDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cancle';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnCancelDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DistrictID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DistrictName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThongTinKhac' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information Trade';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThuongMai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of sale, receivables';
EXEC ERP9AddLanguage @ModuleID, 'CI1151.IsRePayment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase terms, pay';
EXEC ERP9AddLanguage @ModuleID, 'CI1151.IsPaPayment' , @FormID, @LanguageValue, @Language;

