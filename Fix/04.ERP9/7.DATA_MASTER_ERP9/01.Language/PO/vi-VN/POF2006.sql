DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2006'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn kế hoạch mẫu'
EXEC ERP9AddLanguage @ModuleID, 'POF2006.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế hoạch mẫu';
EXEC ERP9AddLanguage @ModuleID, 'POF2006.FormPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2006.Description',  @FormID, @LanguageValue, @Language;



