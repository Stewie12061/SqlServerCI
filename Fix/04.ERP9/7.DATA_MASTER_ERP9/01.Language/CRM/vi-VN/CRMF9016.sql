DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9016'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn người nhận'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.ReceiverID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.ReceiverName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.Tel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.Mobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9016.RelatedToTypeName',  @FormID, @LanguageValue, @Language;