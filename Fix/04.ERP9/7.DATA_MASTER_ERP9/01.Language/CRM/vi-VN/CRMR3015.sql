declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3015'

SET @LanguageValue = N'Thống kê hoạt động khách hàng có phát sinh cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3015.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3015.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3015.ObjectID' , @FormID, @LanguageValue, @Language;