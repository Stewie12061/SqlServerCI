declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Delivery status summary';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'From inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'To inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30018'
SET @LanguageValue = N'Analysis group';
EXEC ERP9AddLanguage @ModuleID, 'SOR30018.GroupID' , @FormID, @LanguageValue, @Language;

