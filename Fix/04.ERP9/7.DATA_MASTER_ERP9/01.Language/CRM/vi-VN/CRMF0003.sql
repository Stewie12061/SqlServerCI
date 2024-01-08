declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMF0003'

SET @LanguageValue = N'Thiết lập công thức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0003.Title' , @FormID, @LanguageValue, @Language;


