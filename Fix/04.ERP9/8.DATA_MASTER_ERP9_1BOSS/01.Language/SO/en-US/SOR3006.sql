declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Average sales of orders by salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.ToSalesManName' , @FormID, @LanguageValue, @Language;


