declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Chọn nhà phân phối';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.ObjectTypeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.ObjectID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.ObjectName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.Address' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.Email' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CMNF9010'
SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9010.Tel' , @FormID, @LanguageValue, @Language;


