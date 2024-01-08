declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'HRM'
SET @Language = 'vi-VN'

SET @FormID = 'HRMF3028'
SET @LanguageValue = N'Báo cáo tổng hợp hồ sơ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3028.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3028'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3028.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3028'
SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3028.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3028'
SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3028.TeamID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3028'
SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3028.StatusID' , @FormID, @LanguageValue, @Language;

