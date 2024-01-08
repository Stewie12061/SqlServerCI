-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF9004- CI
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
SET @FormID = 'CIF9004';

SET @LanguageValue = N'UNit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trademark';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province - city';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Haunt';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CurrencyID';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowable debt limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RePaymentTermID';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReDueDays';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeAddress';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt age limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lock (Stop Selling)';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts receivable';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowable debt limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to enjoy the discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rate of discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Authorized capital';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts payable';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Distributor';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.IsDealer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nation';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wards';
EXEC ERP9AddLanguage @ModuleID, 'CIF9004.DeliveryWard', @FormID, @LanguageValue, @Language;

