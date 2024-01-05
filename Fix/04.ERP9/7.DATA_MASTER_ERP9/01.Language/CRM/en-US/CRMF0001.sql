declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'en-US'

SET @FormID = 'CRMF0001'
SET @LanguageValue = N'Is use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.IsUsed' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.TypeID' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Name (VIE)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.UserName' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Name (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.UserNameE' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Parameter define';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.CRMF0001Title' , @FormID, @LanguageValue, @Language;