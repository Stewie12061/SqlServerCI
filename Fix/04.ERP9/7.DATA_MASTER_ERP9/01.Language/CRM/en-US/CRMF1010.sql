-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1010- CRM
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
SET @FormID = 'CRMF1010';

SET @LanguageValue = N'List of customers';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'is organization';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsOrganize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsVATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common law';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed credit limit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery route';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stop using';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsUsing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.VATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 05';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/Wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Postal code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communes/Wards';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ConvertType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.InheritConvertID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ConvertUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for conversion';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CauseConverted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description of switching';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DescriptionConvert', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Switching from';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ConvertTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge of switching';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ConvertUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.WarningNoOrdersGenerated', @FormID, @LanguageValue, @Language;

