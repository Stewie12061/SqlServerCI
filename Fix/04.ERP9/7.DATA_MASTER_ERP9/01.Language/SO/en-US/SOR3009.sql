declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Summary of sales by salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'From inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'To inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToInventoryName' , @FormID, @LanguageValue, @Language;




