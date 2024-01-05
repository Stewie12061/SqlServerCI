declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'CMNF9015'
SET @LanguageValue = N'Chọn nhóm mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9015.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9015'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9015.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9015'
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9015.AnaID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9015'
SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9015.AnaName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9015'
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9015.Notes' , @FormID, @LanguageValue, @Language;
