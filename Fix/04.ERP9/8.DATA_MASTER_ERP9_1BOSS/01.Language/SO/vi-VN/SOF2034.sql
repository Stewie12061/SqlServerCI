declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF2034'
SET @LanguageValue = N'Xác nhận tiến độ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2034.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2034.IsObjectConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2034.DateConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2034.NoteConfirm' , @FormID, @LanguageValue, @Language;



