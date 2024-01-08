DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CMNF9004'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Fax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Contactor',  @FormID, @LanguageValue, @Language;


