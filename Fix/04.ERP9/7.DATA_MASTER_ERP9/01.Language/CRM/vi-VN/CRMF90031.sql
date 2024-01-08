declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'


SET @FormID = 'CRMF90031'
SET @LanguageValue = N'Cập nhật ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.NotesSubject' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.Description' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.RelatedToTypeID_REL' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.CreateDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.TypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventSubject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.Location' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventStartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.PriorityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.TypeActive' , @FormID, @LanguageValue, @Language;