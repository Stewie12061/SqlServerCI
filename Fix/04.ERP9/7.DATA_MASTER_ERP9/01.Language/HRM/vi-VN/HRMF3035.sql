declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'HRM'
SET @Language = 'vi-VN'

SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Báo cáo chi tiết hồ sơ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.TeamID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.StatusID' , @FormID, @LanguageValue, @Language;


SET @FormID = 'HRMF3035'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3035.AssignedToUserID' , @FormID, @LanguageValue, @Language;

