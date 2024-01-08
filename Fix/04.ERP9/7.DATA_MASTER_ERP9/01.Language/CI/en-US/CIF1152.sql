-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1152- CI
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
SET @FormID = 'CIF1152';

SET @LanguageValue = N'Object view';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trademark';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact phone';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supplier';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Haunt';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transaction currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowable debt limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt age limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lock (Stop selling)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts receivable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowable debt limit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to pay';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to enjoy the discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rate of discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Authorized capital';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object parsing code 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounts payable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Distributor';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsDealer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wards';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Area Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.AreaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'City Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'District Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DistrictName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Delivery Ward';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryWard',  @FormID, @LanguageValue, @Language;