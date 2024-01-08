DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9004'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.VATNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Fax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Contactor',  @FormID, @LanguageValue, @Language;