DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF2000'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'In danh sách đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Print1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực chuyên môn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.Print2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.LanguageTD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;



SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2000.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;


