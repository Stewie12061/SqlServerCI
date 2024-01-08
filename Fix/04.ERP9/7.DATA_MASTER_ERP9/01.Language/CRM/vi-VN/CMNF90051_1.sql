DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = '00';
SET @FormID = 'CMNF90051_1'
---------------------------------------------------------------

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailAssignedTo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailToReceiver',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailCCReceiver',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailBCCReceiver',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mẫu Email';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.EmailTemplateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CMNF90051_1.AttachID',  @FormID, @LanguageValue, @Language;



