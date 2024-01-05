declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Sales by area';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'From area';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromAreaID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'To area';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToAreaID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Period selection';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.CheckListPeriodControl' , @FormID, @LanguageValue, @Language;



