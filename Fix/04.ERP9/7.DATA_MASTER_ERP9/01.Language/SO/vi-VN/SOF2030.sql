declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF2030'
SET @LanguageValue = N'Thủ kho xác nhận giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2030.Title' , @FormID, @LanguageValue, @Language