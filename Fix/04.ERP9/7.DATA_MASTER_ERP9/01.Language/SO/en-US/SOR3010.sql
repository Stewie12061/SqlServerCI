declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Sales by salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Period selection';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.CheckListPeriodControl' , @FormID, @LanguageValue, @Language;



