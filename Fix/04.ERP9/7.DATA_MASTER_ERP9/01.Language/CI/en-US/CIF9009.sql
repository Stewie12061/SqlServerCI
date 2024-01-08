-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF9009- CI
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
SET @FormID = 'CIF9009';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trademark';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Haunt';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Share';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt age limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lock (Stop Selling)';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts receivable';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowable debt limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to enjoy the discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rate of discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Authorized capital';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts payable';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Distributor';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.IsDealer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nation';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wards';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.DeliveryWard', @FormID, @LanguageValue, @Language;

