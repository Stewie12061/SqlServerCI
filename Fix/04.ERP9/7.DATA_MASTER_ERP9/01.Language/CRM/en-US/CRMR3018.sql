declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'en-US'
SET @FormID = 'CRMR3018'

SET @LanguageValue = N'Report Detail Marketing -Sale';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3018.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3018.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3018.CampaignID' , @FormID, @LanguageValue, @Language;


