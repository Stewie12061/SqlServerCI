DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3024';
---------------------------------------------------------------

SET @LanguageValue  = N'Mã báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.ReportID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.ReportName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.TeamID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chuyền'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.SectionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công đoạn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3024.ProcessID',  @FormID, @LanguageValue, @Language;