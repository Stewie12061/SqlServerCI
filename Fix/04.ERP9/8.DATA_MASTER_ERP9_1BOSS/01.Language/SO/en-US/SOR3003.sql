declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Sales order summary';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.OrderStatus' , @FormID, @LanguageValue, @Language;

