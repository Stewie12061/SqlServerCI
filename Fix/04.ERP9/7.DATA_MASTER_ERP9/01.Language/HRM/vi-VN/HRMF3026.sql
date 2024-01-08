declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'HRM'
SET @Language = 'vi-VN'

SET @FormID = 'HRMF3026'
SET @LanguageValue = N'Báo cáo chấm công theo định vị (GPS)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3026.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3026'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3026.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3026'
SET @LanguageValue = N'Nhân viên (Sale)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3026.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3026'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3026.ObjectName' , @FormID, @LanguageValue, @Language;

