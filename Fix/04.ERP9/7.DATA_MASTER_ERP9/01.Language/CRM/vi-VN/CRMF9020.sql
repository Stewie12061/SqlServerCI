DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9020'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn hội thảo - chuyên đề'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.OrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả(Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.DescriptionE',  @FormID, @LanguageValue, @Language;

