declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF3024'
SET @LanguageValue = N'Báo cáo phương án kinh doanh và thực tế';
EXEC ERP9AddLanguage @ModuleID, 'SOF3024.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3024'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3024.DivisionID' , @FormID, @LanguageValue, @Language;


