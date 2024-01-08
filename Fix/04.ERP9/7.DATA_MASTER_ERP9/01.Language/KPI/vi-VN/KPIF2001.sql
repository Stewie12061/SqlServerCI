DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2001'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật cá nhân tự đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp trên đánh giá lại'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Title2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm mạnh';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.StrengthPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm yếu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.WeakPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đề xuất sau đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeProposes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmTitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ThongTinCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ChiTietCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LanguageTD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LanguageXL',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EvaluationSetName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Têm người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.ReevaluatedNote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LabelPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2001.LabelReevaluatedPoint',  @FormID, @LanguageValue, @Language;