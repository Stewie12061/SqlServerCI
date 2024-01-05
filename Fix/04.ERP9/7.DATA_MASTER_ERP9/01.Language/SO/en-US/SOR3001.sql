declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'en-US'

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Quotation summary';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'From salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'To salesman';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30011'
SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOR30011.OrderStatus' , @FormID, @LanguageValue, @Language;

