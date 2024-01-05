DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3023';
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo tình hình thay đổi lao động 6 tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3023.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3023.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kỳ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3023.Period',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3023.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3023.Year',  @FormID, @LanguageValue, @Language;