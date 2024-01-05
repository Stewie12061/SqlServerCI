declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'CMNF9013'
SET @LanguageValue = N'Chọn khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9013.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9013'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9013.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9013'
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9013.AnaID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9013'
SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9013.AnaName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9013'
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9013.Notes' , @FormID, @LanguageValue, @Language;
