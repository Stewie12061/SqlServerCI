DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9011'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn nhiệm vụ'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.CRMF9011Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.TypeActive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9011.TaskStatus',  @FormID, @LanguageValue, @Language;
