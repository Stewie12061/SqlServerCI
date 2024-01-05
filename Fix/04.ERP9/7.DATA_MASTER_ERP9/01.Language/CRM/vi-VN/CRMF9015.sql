DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9015'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chủ đề yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.RequestSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.RequestDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.RequestStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời hạn xử lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.DeadlineRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.TimeRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.RequestCustomerID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9015.TypeOfRequest',  @FormID, @LanguageValue, @Language;