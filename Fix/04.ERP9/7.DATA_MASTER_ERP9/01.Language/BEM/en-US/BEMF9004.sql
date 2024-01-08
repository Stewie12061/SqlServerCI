-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF9004- BEM
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
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF9004';

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trade name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT No';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ObjectTypeID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Telephone';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contactor';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Customer';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Supplier';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsUpdateName';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O01ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O02ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O03ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O04ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'O05ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF9004.PaAccountID', @FormID, @LanguageValue, @Language;

