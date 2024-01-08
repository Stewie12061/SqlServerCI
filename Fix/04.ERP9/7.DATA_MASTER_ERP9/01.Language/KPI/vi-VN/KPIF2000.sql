DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2000'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục cá nhân tự đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm mạnh';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.StrengthPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm yếu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.WeakPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đề xuất sau đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeProposes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmTitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ThongTinCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ChiTietCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất do';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng tổng hợp KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Print1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá kết quả công việc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.Print2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EvaluationSetName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Têm người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2000.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

