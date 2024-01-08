declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3004'
SET @LanguageValue = N'Sales by inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'From inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3004'
SET @LanguageValue = N'To inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR3004.ToInventoryName' , @FormID, @LanguageValue, @Language;


