DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2111'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật tính cách D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Descriptions',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách tự nhiên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.GroupA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách thích ứng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.GroupB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeName.CB',  @FormID, @LanguageValue, @Language;


