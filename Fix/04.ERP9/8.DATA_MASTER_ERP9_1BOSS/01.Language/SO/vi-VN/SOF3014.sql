declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF3014'
SET @LanguageValue = N'Báo cáo thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3014.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3014'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3014.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOF3014'
SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3014.FromAccountName' , @FormID, @LanguageValue, @Language;



