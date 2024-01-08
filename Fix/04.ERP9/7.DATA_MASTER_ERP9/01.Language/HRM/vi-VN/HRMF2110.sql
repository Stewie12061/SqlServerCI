DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2110'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục tính cách D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách tự nhiên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách thích ứng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ điểm D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến điểm D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ điểm I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến điểm I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ điểm S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến điểm S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ điểm C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến điểm C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CharacterTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tự nhiên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Native',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thích nghi';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive',  @FormID, @LanguageValue, @Language;