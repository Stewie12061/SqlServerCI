DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3025';
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo đánh giá công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3025.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3025.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3025.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3025.EmployeeName',  @FormID, @LanguageValue, @Language;

