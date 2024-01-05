declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)

SET @ModuleID = 'POS'
SET @Language = 'vi-VN'
SET @FormID = 'CMNF9004'

SET @LanguageValue = N'Chọn khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khàng hàng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.VATNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Fax' , @FormID, @LanguageValue, @Language;

