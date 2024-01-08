DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1072'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết thiết lập bảng đánh giá KPI'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ChiTietThietLapBangDanhGiaTungViTri',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin thiết lập bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ThongTinThietLapBangDanhGiaTungViTri',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ClassificationName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu phòng ban/công ty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.MainTargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsGroupPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.UnitKpiName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FrequencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.CategorizeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.TargetsPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1072.ToDate',  @FormID, @LanguageValue, @Language;



