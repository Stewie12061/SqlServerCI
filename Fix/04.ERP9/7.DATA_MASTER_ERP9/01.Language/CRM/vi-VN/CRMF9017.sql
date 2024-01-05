DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9017'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn nhóm người nhận'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.IsCommon',  @FormID, @LanguageValue, @Language;

