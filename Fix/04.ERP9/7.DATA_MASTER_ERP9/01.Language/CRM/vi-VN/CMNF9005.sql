DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = '00';
SET @FormID = 'CMNF9005'
---------------------------------------------------------------

SET @LanguageValue  = N'Gửi mail'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.EmailSubject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.SubjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.From',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.To',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.Cc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.Bcc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9005.Date',  @FormID, @LanguageValue, @Language;
