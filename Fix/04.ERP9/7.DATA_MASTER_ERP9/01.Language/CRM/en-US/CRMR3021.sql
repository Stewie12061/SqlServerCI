declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'en-US'
SET @FormID = 'CRMR3021'

SET @LanguageValue = N'Report Marketing - Sale year';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.CampaignTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year(Number)';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.Year' , @FormID, @LanguageValue, @Language;


