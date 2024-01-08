DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1051'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.OrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FrequencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Categorize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Percentage.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm vào từ điển chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.IsAddTargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu phòng ban/công ty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.MainTargetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn từ điển';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.Choostarget',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1051.FormulaName.CB',  @FormID, @LanguageValue, @Language;
