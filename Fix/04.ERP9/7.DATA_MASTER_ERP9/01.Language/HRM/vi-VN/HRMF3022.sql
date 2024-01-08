DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3022';
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo huê hồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3022.DivisionID',  @FormID, @LanguageValue, @Language;
