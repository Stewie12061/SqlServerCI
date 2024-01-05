declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3007'
SET @LanguageValue = N'Average sales of the company';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3007'
SET @LanguageValue = N'Period selection';
EXEC ERP9AddLanguage @ModuleID, 'SOR3007.CheckListPeriodControl' , @FormID, @LanguageValue, @Language;



