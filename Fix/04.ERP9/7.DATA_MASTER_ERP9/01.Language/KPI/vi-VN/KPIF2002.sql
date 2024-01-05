DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2002'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết cá nhân tự đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm mạnh';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.StrengthPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm yếu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.WeakPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đề xuất sau đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.EmployeeProposes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmTitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ThongTinCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết cá nhân tự đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ChiTietCaNhanTuDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2002.ReevaluatedNote',  @FormID, @LanguageValue, @Language;