DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = '00';
SET @FormID = 'CMNF9006'
---------------------------------------------------------------

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9006.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9006.AttachName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9006.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9006.CreateUserID',  @FormID, @LanguageValue, @Language;


