declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3014'

SET @LanguageValue = N'Thống kê khách hàng không phát sinh cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3014.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3014.DivisionID' , @FormID, @LanguageValue, @Language;
