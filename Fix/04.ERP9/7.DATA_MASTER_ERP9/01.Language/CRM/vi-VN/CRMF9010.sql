DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9010'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn sự kiện'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.EventSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.EventStartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.EventEndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.TypeActive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9010.TypeID',  @FormID, @LanguageValue, @Language;
