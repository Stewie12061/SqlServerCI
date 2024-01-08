declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)

SET @ModuleID = 'CRM'
SET @Language = 'en-US'
SET @FormID = 'CRMF0000'

SET @LanguageValue = N'Systems settings';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of CT requested from customers';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT campaign email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaignEmail', @FormID, @LanguageValue, @Language;