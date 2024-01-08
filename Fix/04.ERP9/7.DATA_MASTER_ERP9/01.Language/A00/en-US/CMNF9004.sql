DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = '00';
SET @FormID = 'CMNF9004'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose Object'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ObjectID';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'VAT No';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9004.VATNo',  @FormID, @LanguageValue, @Language;


