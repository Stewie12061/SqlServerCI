DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF9009'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF9009.VATNo', @FormID, @LanguageValue, @Language;