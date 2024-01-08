declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Payment status summary';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.ToAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.OrderStatus' , @FormID, @LanguageValue, @Language;

