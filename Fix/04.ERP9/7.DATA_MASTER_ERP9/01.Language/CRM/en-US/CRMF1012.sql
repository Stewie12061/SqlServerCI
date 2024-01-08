-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1012- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1012';

SET @LanguageValue = N'Customer view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'is organization';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsOrganize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsVATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common law';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stop using';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsUsing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.VATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 05';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/Wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BillWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/Wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ConvertType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.InheritConvertID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ConvertUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for conversion';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CauseConverted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description of switching';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DescriptionConvert', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Switching from';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ConvertTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge of switching';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ConvertUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.WarningNoOrdersGenerated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Tel1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Tel2', @FormID, @LanguageValue, @Language;

