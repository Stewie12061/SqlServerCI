DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9026'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật nhiệm vụ'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.CRMF9026Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.TaskStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hoạt động ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.TypeActive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.RelatedToTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.EndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.RelatedToTypeID_REL' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9026.CreateDate' , @FormID, @LanguageValue, @Language;
