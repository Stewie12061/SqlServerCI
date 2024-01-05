-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1150- CI
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
SET @FormID = 'CIF1150';

SET @LanguageValue = N'List of objects';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trademark';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Haunt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transaction currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt age limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lock (Stop Selling)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receivable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of discount days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shipping address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Charter capital';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID object analysis 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payable account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CityID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CityName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CountryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CountryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment term name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used electronic invoice';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsUsedEInvoice' , @FormID, @LanguageValue, @Language;

