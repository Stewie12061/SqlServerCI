declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF2031'
SET @LanguageValue = N'Xác nhận đi';
EXEC ERP9AddLanguage @ModuleID, 'SOF2031.Title' , @FormID, @LanguageValue, @Language